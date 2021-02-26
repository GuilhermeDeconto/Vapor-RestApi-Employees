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
    
    @Enum(key: "userType")
    var userType: UserType
    
    init() { }
    
    init(id: UUID? = nil, title: String, firstName: String, lastName: String, department: String, salary: Double, age: Int, userType: UserType = .standard) {
        self.id = id
        self.title = title
        self.firstName = firstName
        self.lastName = lastName
        self.department = department
        self.salary = salary
        self.age = age
        self.userType = userType
    }
}

struct EmployeeList: Content {
    var data: [Employee]
}



