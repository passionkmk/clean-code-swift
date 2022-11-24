//
//  Employee.swift
//  CleanCodeSwift
//
//  Created by pkmk on 2022/11/24.
//

import Foundation

typealias Money = Int
typealias Address = String

enum EmployType {
    case commissioned
    case hourly
    case salary
}

struct EmployRecord {
    let type: EmployType
    let payDate: Date
    let workHour: Int
    let wage: Int
}

protocol Employee {
    var record: EmployRecord { get }
    
    var isPayday: Bool { get }
    func calculatePay() -> Money
    func deliveryPay(to address: Address)
}

extension Employee {
    var isPayday: Bool {
        return record.payDate == Date()
    }
    
    func calculatePay() -> Money {
        return record.wage * record.workHour
    }
    
    func deliveryPay(to address: Address) {
        print("Delivery to \(address) payment is \(calculatePay())")
    }
}

protocol EmployeeFactory {
    func makeEmployee(record: EmployRecord) -> Employee
}
