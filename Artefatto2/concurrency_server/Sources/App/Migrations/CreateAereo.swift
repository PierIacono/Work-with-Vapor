//
//  File.swift
//  
//
//  Created by Pierluigi Iacono on 31/03/22.
//
import Fluent

struct CreateAereo: AsyncMigration {
    
    func prepare(on database: Database) async throws {
        try await database.schema("aereo")
            .id()
            .field("modello", .string, .required)
            .field("capienza", .int, .required)
            .field("pilot", .string)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("aereo").delete()
    }
}
