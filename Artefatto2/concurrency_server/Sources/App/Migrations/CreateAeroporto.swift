//
//  File.swift
//  
//
//  Created by Pierluigi Iacono on 31/03/22.
//

import Fluent

struct CreateAeroporto: AsyncMigration {
    
    func prepare(on database: Database) async throws {
        try await database.schema("aeroporti")
            .id()
            .field("name", .string, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("aeroporti").delete()
    }
}
