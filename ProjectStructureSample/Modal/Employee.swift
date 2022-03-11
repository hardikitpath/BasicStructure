//
//  Employee.swift
//  ProjectStructureSample
//
//  Created by MAC OS 13 on 11/03/22.
//

import Foundation

// MARK: - Employee
struct Employee: Codable {
    let id: Int
    let employeeName: String
    let employeeSalary, employeeAge: Int
    let profileImage: String

    enum CodingKeys: String, CodingKey {
        case id
        case employeeName = "employee_name"
        case employeeSalary = "employee_salary"
        case employeeAge = "employee_age"
        case profileImage = "profile_image"
    }
}

extension Employee {
    
    static func getEmployee(withCompletion completion: @escaping (Result<[Employee]>)->Void) {
        
        
        
        let webResource = WebResource<Response<[Employee]>>(urlPath: .getEmployees, httpMethod: .get, header: nil, decode: Response<[Employee]>.decode)
        
        webResource.request { result in
            switch result {
            case .success(let response):
                if let employees = response.data {
                    completion(.success(employees))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    
}
