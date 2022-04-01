import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    let encoder = JSONEncoder()
    encoder.keyEncodingStrategy = .convertToSnakeCase
    encoder.dateEncodingStrategy = .iso8601
    
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    decoder.dateDecodingStrategy = .iso8601
    
    ContentConfiguration.global.use(encoder: encoder, for: .json)
    ContentConfiguration.global.use(decoder: decoder, for: .json)
    
    app.databases.use(.postgres(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? PostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
        database: Environment.get("DATABASE_NAME") ?? "vapor_database"
    ), as: .psql)

    app.migrations.add(CreateVolo())
//    app.migrations.add(CreateDinners())
    
//      QUEUES
    try app.queues.use(.postgres(url: "http://127.0.0.1:8080"))

//
//    // MARK: Queue and Jobs
//    try app.queues.use(.redis(url: "redis://127.0.0.1:6379"))
//
//    let recipientJob = RecipientWelcomeEmailJob()
//    app.queues.add(recipientJob)
//
//    let sendNewsletterJob = SendNewsletterJob()
//    app.queues.schedule(sendNewsletterJob).minutely().at(5)
//
//    try app.queues.startInProcessJobs()
//    try app.queues.startScheduledJobs()
    
    
//    This condition verifies if we are in a development enviroment. Practically if we are running our server app on a local host for testing purposes.
        if app.environment == .development{
            try app.autoMigrate().wait()
            }
    
    try routes(app)
}
