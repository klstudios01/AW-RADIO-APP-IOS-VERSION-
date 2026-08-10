//
//  NowPlayingInfoManager.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import Foundation
import MediaPlayer

@MainActor
final class NowPlayingInfoManager {
    static let shared = NowPlayingInfoManager()
    
    private init() {}
    
    func updateNowPlaying(station: RadioStation, program: Program?) {
        var nowPlayingInfo = [String: Any]()
        
        nowPlayingInfo[MPMediaItemPropertyTitle] = program?.title ?? station.name
        nowPlayingInfo[MPMediaItemPropertyArtist] = program?.presenterName ?? station.tagline
        nowPlayingInfo[MPMediaItemPropertyAlbumTitle] = station.name
        nowPlayingInfo[MPNowPlayingInfoPropertyIsLiveStream] = true
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    func updatePlaybackState(isPlaying: Bool) {
        if var info = MPNowPlayingInfoCenter.default().nowPlayingInfo {
            info[MPNowPlayingInfoPropertyPlaybackRate] = isPlaying ? 1.0 : 0.0
            MPNowPlayingInfoCenter.default().nowPlayingInfo = info
        }
    }
    
    func clearNowPlaying() {
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nil
    }
}
