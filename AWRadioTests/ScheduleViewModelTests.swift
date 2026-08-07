//
//  ScheduleViewModelTests.swift
//  AWRadioTests
//
//  Created for AW Radio iOS Application.
//

import XCTest
@testable import AWRadio

@MainActor
final class ScheduleViewModelTests: XCTestCase {
    
    var viewModel: ScheduleViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = ScheduleViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testScheduleSearchFiltering() async {
        await viewModel.loadSchedule()
        viewModel.searchQuery = "Morning"
        
        XCTAssertFalse(viewModel.filteredPrograms.isEmpty)
        XCTAssertTrue(viewModel.filteredPrograms.first?.title.contains("Morning") ?? false)
    }
}
