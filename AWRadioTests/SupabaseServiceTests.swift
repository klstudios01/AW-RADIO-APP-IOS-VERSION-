//
//  SupabaseServiceTests.swift
//  AWRadioTests
//
//  Created for AW Radio iOS Application.
//

import XCTest
@testable import AWRadio

final class SupabaseServiceTests: XCTestCase {
    
    func testSupabaseRequestHeaderGeneration() {
        let manager = SupabaseClientManager.shared
        manager.configure(url: "https://test.supabase.co", anonKey: "test-key")
        
        let request = manager.makeRequest(endpoint: "stations?select=*")
        XCTAssertNotNil(request)
        XCTAssertEqual(request?.value(forHTTPHeaderField: "apikey"), "test-key")
        XCTAssertEqual(request?.value(forHTTPHeaderField: "Authorization"), "Bearer test-key")
    }
}
