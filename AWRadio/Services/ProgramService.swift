//
//  ProgramService.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import Foundation

@MainActor
final class ProgramService {
    static let shared = ProgramService()
    
    private init() {}
    
    func fetchPrograms() async -> [Program] {
        return Program.mockList
    }
    
    func fetchLiveProgram(for stationId: String) async -> Program? {
        return Program.mockList.first(where: { $0.isLiveNow })
    }
}
