import Fluent
import Vapor

final class Employee: Model, Content {
    static let schema = "employees"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "firstName")
    var firstName: String?
    
    @Field(key: "lastName")
    var lastName: String?
    
    @Field(key: "department")
    var department: String?
    
    @Field(key: "salary")
    var salary: Double?
    
    @Field(key: "age")
    var age: Int?
    
    @Field(key: "title")
    var title: String
    
    init() { }
    
    init(id: UUID? = nil, title: String, firstName: String, lastName: String, department: String, salary: Double, age: Int) {
        self.id = id
        self.title = title
        self.firstName = firstName
        self.lastName = lastName
        self.department = department
        self.salary = salary
        self.age = age
    }
}

struct EmployeeList: Content {
    var data: [Employee]
}

struct Response<T> : Content where T: Content {
    var message: String?
    var status: UInt?
    var data: T?
    
    init(message: String, status: UInt, data: T) {
        self.message = message
        self.status = status
        self.data = data
    }
}
