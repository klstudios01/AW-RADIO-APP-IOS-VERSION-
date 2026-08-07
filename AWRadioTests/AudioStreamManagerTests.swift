//
//  AudioStreamManagerTests.swift
//  AWRadioTests
//
//  Created for AW Radio iOS Application.
//

import XCTest
@testable import AWRadio

@MainActor
final class AudioStreamManagerTests: XCTestCase {
    
    var audioManager: AudioStreamManager!
    
    override func setUp() {
        super.setUp()
        audioManager = AudioStreamManager.shared
    }
    
    override func tearDown() {
        audioManager.stop()
        audioManager = nil
        super.tearDown()
    }
    
    func testPlayStationUpdatesCurrentStationAndState() {
        let station = RadioStation.mockList.first!
        audioManager.play(station: station)
        
        XCTAssertEqual(audioManager.currentStation?.id, station.id)
        XCTAssertTrue(audioManager.state == .playing || audioManager.state == .buffering)
    }
    
    func testStopClearsPlaybackState() {
        let station = RadioStation.mockList.first!
        audioManager.play(station: station)
        audioManager.stop()
        
        XCTAssertEqual(audioManager.state, .stopped)
    }
    
    func testVolumeAdjustment() {
        audioManager.volume = 0.5
        XCTAssertEqual(audioManager.volume, 0.5)
    }
}
