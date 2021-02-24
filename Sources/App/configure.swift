import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(.postgres(
        hostname: "2.tcp.ngrok.io",
        port: 13756,
        username: "postgres",
        password: "admin",
        database: "employees_api",
        connectionPoolTimeout: .seconds(60)
    ), as: .psql)

    app.migrations.add(CreateEmployee())
    try app.autoMigrate().wait()

    // register routes
    try routes(app)
}

//        hostname: Environment.get("tcp://0.tcp.ngrok.io") ?? "localhost",
//        port: Environment.get("13953").flatMap(Int.init(_:)) ?? PostgresConfiguration.ianaPortNumber,
//        username: Environment.get("admin") ?? "vapor_username",
//        password: Environment.get("admin") ?? "vapor_password",
//        database: Environment.get("employees_api") ?? "vapor_database"
