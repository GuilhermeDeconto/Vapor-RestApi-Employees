import Fluent
import Vapor

struct EmployeeController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let employee = routes.grouped("employee")
        employee.get(use: getAll)
        employee.post(use: createBatch)
        employee.group(":employeeID") { employee in
            employee.delete(use: delete)
            employee.post(use: createEmployee)
            employee.get(use: getById)
            
        }
    }

    func getAll(req: Request) throws -> EventLoopFuture<Response<[Employee]>> {
        let employees = Employee.query(on: req.db).all()
        return employees.map{ employees in Response.init(message: "Success", status: HTTPStatus.ok.code, data: employees)}.unwrap(orError: Abort(.badRequest))
    }
    
    func getById(req: Request) throws -> EventLoopFuture<Response<Employee>> {
        return Employee.find(req.parameters.get("employeeID"), on: req.db).unwrap(or: Abort(.notFound)).map { employee in Response.init(message: "Success", status: HTTPStatus.ok.code, data: employee)}
    }
    

    func createEmployee(req: Request) throws -> EventLoopFuture<Response<Employee>> {
        let employee = try req.content.decode(Employee.self)
    
        return employee.save(on: req.db).map { Response(message: "Success", status: HTTPStatus.ok.code, data: employee)}
    }
    
    func createBatch(req: Request) throws -> EventLoopFuture<Response<[Employee]>> {
        let employees = try req.content.decode(EmployeeList.self)
        return employees.data.create(on: req.db).map{ Response.init(message: "Success", status: HTTPStatus.ok.code, data: employees.data )}.unwrap(orError: Abort(.badRequest))
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Employee.find(req.parameters.get("employeeID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
