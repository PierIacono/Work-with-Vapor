import Fluent

struct CreateVolo: AsyncMigration {
    
    func prepare(on database: Database) async throws {
        try await database.schema("voli")
            .id()
            .field("idA", .uuid, .required)
            .field("aP", .string, .required)
            .field("aD", .string, .required)
            .field("oraP", .date, .required)
            .field("oraD", .date, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("voli").delete()
    }
}

