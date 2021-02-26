import Fluent
import Vapor

struct EmployeeController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let employee = routes.grouped("employee")
        employee.get(use: getAll)
        employee.post(use: createBatch)
        employee.delete(use: deleteBach)
        employee.group(":employeeID") { employee in
            employee.delete(use: delete)
            employee.post(use: createEmployee)
            employee.get(use: getById)
        }
        employee.group("search") { employee in
            employee.get(use: getByParam)
        }
    }
    
    func getAll(req: Request) throws -> EventLoopFuture<String> {
        let employees = Employee.query(on: req.db).all()
        return employees.map{ employees in ResponseWrapper(protocolCode: .success, data: employees).makeResponse() }.unwrap(orError: Abort(.badRequest))
    }
    
    func getById(req: Request) throws -> EventLoopFuture<String> {
        guard let employeeId = req.parameters.get("employeeID") as UUID? else {
            return ResponseWrapper<DefaultResponseObj>(protocolCode: .notFound).makeFutureResponse(req: req)
        }
        return Employee.find(employeeId, on: req.db).unwrap(or: Abort(.notFound)).map { employee in ResponseWrapper(protocolCode: .success, data: employee).makeResponse()}
    }
    
    
    func createEmployee(req: Request) throws -> EventLoopFuture<String> {
        let employee = try req.content.decode(Employee.self)
        
        return employee.save(on: req.db).map { ResponseWrapper(protocolCode: .success, data: employee).makeResponse() }
    }
    
    func createBatch(req: Request) throws -> EventLoopFuture<String> {
        let employees = try req.content.decode(EmployeeList.self)
        return employees.data.create(on: req.db).map{ ResponseWrapper(protocolCode: .success, data: employees.data).makeResponse() }.unwrap(orError: Abort(.badRequest))
    }
    
    func delete(req: Request) throws -> EventLoopFuture<String> {
        guard let employeeId = req.parameters.get("employeeID") as UUID? else {
            return ResponseWrapper<DefaultResponseObj>(protocolCode: .notFound).makeFutureResponse(req: req)
        }
        return Employee.find(employeeId, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: ResponseWrapper<DefaultResponseObj>(protocolCode: .success).makeResponse())
    }
    
    func deleteBach(req: Request) throws -> EventLoopFuture<String> {
        let employees = try req.content.decode(EmployeeList.self)
        return Employee.query(on: req.db).filter(\._$id ~~ employees.data.map{ $0.id ?? UUID() }).delete().transform(to: ResponseWrapper(protocolCode: .success, data: employees.data).makeResponse() ).unwrap(orError: Abort(.badRequest))
    }
    
    func getByParam(req: Request) throws -> EventLoopFuture<String> {
        let employeeType = try req.query.get(at: "employeeType") as UserType.RawValue?
        let employeeName = try req.query.get(at: "firstName") as String?
        
        if (employeeType != nil && employeeName != nil) {
            
            return Employee.query(on: req.db).group(.and){ group in
                group.filter(\.$firstName, .custom("ilike"), employeeName).filter("userType", .equal, employeeType)
            }.all().map{ employee in ResponseWrapper(protocolCode: .success, data: employee).makeResponse() }
            
        }else if (employeeName != nil || employeeType != nil) {
            
            return Employee.query(on: req.db).group(.or){ group in
                group.filter(\.$firstName, .custom("ilike"), employeeName).filter("userType", .equal, employeeType)
            }.all().map{ employee in ResponseWrapper(protocolCode: .success, data: employee).makeResponse() }
            
        }
        
        return ResponseWrapper<DefaultResponseObj>(protocolCode: .notFound).makeFutureResponse(req: req)
    }
    
}
