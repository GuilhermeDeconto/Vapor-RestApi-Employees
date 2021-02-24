import Fluent

struct CreateEmployee: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("employees")
            .id()
            .field("title", .string, .required)
            .field("firstName", .string, .required)
            .field("lastName", .string, .required)
            .field("salary", .double, .required)
            .field("age", .int, .required)
            .field("department", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("employees").delete()
    }
}
