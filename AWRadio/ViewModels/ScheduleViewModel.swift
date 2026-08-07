//
//  ScheduleViewModel.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI
import Combine

@MainActor
final class ScheduleViewModel: ObservableObject {
    @Published var programs: [Program] = []
    @Published var selectedDate: Date = Date()
    @Published var searchQuery: String = ""
    @Published var isLoading: Bool = false
    
    private let programService = ProgramService.shared
    
    func loadSchedule() async {
        isLoading = true
        self.programs = await programService.fetchPrograms()
        isLoading = false
    }
    
    var filteredPrograms: [Program] {
        if searchQuery.isEmpty {
            return programs
        }
        return programs.filter {
            $0.title.localizedCaseInsensitiveContains(searchQuery) ||
            $0.presenterName.localizedCaseInsensitiveContains(searchQuery) ||
            $0.description.localizedCaseInsensitiveContains(searchQuery)
        }
    }
}
