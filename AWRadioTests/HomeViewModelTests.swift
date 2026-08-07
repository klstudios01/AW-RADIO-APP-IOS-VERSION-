//
//  HomeViewModelTests.swift
//  AWRadioTests
//
//  Created for AW Radio iOS Application.
//

import XCTest
@testable import AWRadio

@MainActor
final class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = HomeViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testLoadContentPopulatesStationsAndPrograms() async {
        await viewModel.loadContent()
        
        XCTAssertNotNil(viewModel.featuredStation)
        XCTAssertFalse(viewModel.recommendedStations.isEmpty)
    }
    
    func testCategoryFilter() async {
        await viewModel.loadContent()
        viewModel.selectedCategory = .news
        
        let filtered = viewModel.filteredStations
        XCTAssertTrue(filtered.allSatisfy { $0.category == .news })
    }
}
