//
//  AudioStreamManager.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import Foundation
import AVFoundation
import MediaPlayer
import Combine

enum PlaybackState: Equatable {
    case stopped
    case buffering
    case playing
    case paused
    case failed(error: String)
}

@MainActor
final class AudioStreamManager: NSObject, ObservableObject {
    static let shared = AudioStreamManager()
    
    @Published var currentStation: RadioStation?
    @Published var currentProgram: Program?
    @Published var state: PlaybackState = .stopped
    @Published var volume: Float = 0.8 {
        didSet {
            player?.volume = volume
        }
    }
    @Published var isMuted: Bool = false {
        didSet {
            player?.isMuted = isMuted
        }
    }
    @Published var reconnectAttempts: Int = 0
    
    private var player: AVPlayer?
    private var playerItem: AVPlayerItem?
    private var timeObserverToken: Any?
    private var statusObservation: NSKeyValueObservation?
    private var bufferObservation: NSKeyValueObservation?
    
    private let maxReconnectAttempts = 5
    private var reconnectTimer: Timer?
    
    override init() {
        super.init()
        setupAudioSession()
        setupRemoteCommandCenter()
    }
    
    // MARK: - Audio Session Setup
    private func setupAudioSession() {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .default, options: [.allowAirPlay, .allowBluetooth, .allowBluetoothA2DP])
            try session.setActive(true)
        } catch {
            print("Failed to configure AVAudioSession: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Streaming Controls
    func play(station: RadioStation, program: Program? = nil) {
        if currentStation?.id == station.id && state == .paused {
            resume()
            return
        }
        
        self.currentStation = station
        self.currentProgram = program ?? Program.mockList.first
        self.reconnectAttempts = 0
        
        stop()
        
        guard let url = URL(string: station.streamUrl) else {
            self.state = .failed(error: "Invalid stream URL")
            return
        }
        
        self.state = .buffering
        
        let asset = AVURLAsset(url: url)
        playerItem = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: playerItem)
        player?.volume = volume
        
        observePlayerItem()
        player?.play()
        
        LocalCacheManager.shared.addRecentlyPlayed(station)
        NowPlayingInfoManager.shared.updateNowPlaying(station: station, program: currentProgram)
    }
    
    func pause() {
        player?.pause()
        self.state = .paused
        NowPlayingInfoManager.shared.updatePlaybackState(isPlaying: false)
    }
    
    func resume() {
        player?.play()
        self.state = .playing
        NowPlayingInfoManager.shared.updatePlaybackState(isPlaying: true)
    }
    
    func stop() {
        player?.pause()
        removeObservers()
        player = nil
        playerItem = nil
        self.state = .stopped
        NowPlayingInfoManager.shared.clearNowPlaying()
    }
    
    func togglePlayPause() {
        if state == .playing {
            pause()
        } else if state == .paused {
            resume()
        } else if let station = currentStation {
            play(station: station, program: currentProgram)
        }
    }
    
    // MARK: - Auto Reconnect Logic
    private func attemptReconnect() {
        guard reconnectAttempts < maxReconnectAttempts, let station = currentStation else {
            self.state = .failed(error: "Stream disconnected. Unable to reconnect.")
            return
        }
        
        reconnectAttempts += 1
        self.state = .buffering
        
        reconnectTimer?.invalidate()
        reconnectTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(reconnectAttempts * 2), repeats: false) { [weak self] _ in
            Task { @MainActor in
                self?.play(station: station, program: self?.currentProgram)
            }
        }
    }
    
    // MARK: - Player Observations
    private func observePlayerItem() {
        guard let item = playerItem else { return }
        
        statusObservation = item.observe(\.status, options: [.new, .old]) { [weak self] item, _ in
            Task { @MainActor in
                switch item.status {
                case .readyToPlay:
                    self?.state = .playing
                    self?.reconnectAttempts = 0
                case .failed:
                    self?.attemptReconnect()
                case .unknown:
                    self?.state = .buffering
                @unknown default:
                    break
                }
            }
        }
        
        bufferObservation = item.observe(\.isPlaybackLikelyToKeepUp, options: [.new]) { [weak self] item, _ in
            Task { @MainActor in
                if item.isPlaybackLikelyToKeepUp {
                    if self?.state != .playing {
                        self?.state = .playing
                    }
                } else {
                    self?.state = .buffering
                }
            }
        }
    }
    
    private func removeObservers() {
        statusObservation?.invalidate()
        bufferObservation?.invalidate()
        statusObservation = nil
        bufferObservation = nil
    }
    
    // MARK: - Remote Command Center (Lock Screen / Headphones / AirPlay)
    private func setupRemoteCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared()
        
        commandCenter.playCommand.isEnabled = true
        commandCenter.playCommand.addTarget { [weak self] _ in
            Task { @MainActor in
                self?.resume()
            }
            return .success
        }
        
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.pauseCommand.addTarget { [weak self] _ in
            Task { @MainActor in
                self?.pause()
            }
            return .success
        }
        
        commandCenter.togglePlayPauseCommand.isEnabled = true
        commandCenter.togglePlayPauseCommand.addTarget { [weak self] _ in
            Task { @MainActor in
                self?.togglePlayPause()
            }
            return .success
        }
        
        commandCenter.stopCommand.isEnabled = true
        commandCenter.stopCommand.addTarget { [weak self] _ in
            Task { @MainActor in
                self?.stop()
            }
            return .success
        }
    }
}
