//
//  Function.swift
//  CleanCodeSwift
//
//  Created by pkmk on 2022/11/24.
//

import Foundation

final class FuctionExample {
    
}

extension FuctionExample {
    class PageData {
        private var html: String = ""
        
        func getHtml() -> String {
            return html
        }
    }
}

private extension FuctionExample {
    struct CommissionedEmployee: Employee {
        let record: EmployRecord
    }
    
    struct HourlyEmployee: Employee {
        let record: EmployRecord
    }
    
    struct SalaryEmployee: Employee {
        let record: EmployRecord
    }
    
    class EmployeeFactoryEmplemetation: EmployeeFactory {
        func makeEmployee(record: EmployRecord) -> Employee {
            switch record.type {
            case .commissioned:
                return CommissionedEmployee(record: record)
            case .hourly:
                return HourlyEmployee(record: record)
            case .salary:
                return SalaryEmployee(record: record)
            }
        }
    }
}


private extension FuctionExample {
    func calculatePay(record: EmployRecord) -> Money {
        switch record.type {
        case .commissioned:
            return calculateCommissioned(record: record)
        case .hourly:
            return calculateHourly(record: record)
        case .salary:
            return calculateSalary(record: record)
        }
    }
    
    func calculateCommissioned(record: EmployRecord) -> Money {
        return record.wage * record.workHour
    }
    
    func calculateHourly(record: EmployRecord) -> Money {
        return record.wage * record.workHour
    }
    
    func calculateSalary(record: EmployRecord) -> Money {
        return record.wage * record.workHour
    }
}

private extension FuctionExample {
    func testableHtml() { } // BAD
    func setupTeardownIncluder() { } // GOOD
    
    // 일관성 있는 이름으로
    func includeSetupAndTeardownPages() { }
    func includeSetupPage() { }
    func includeSuiteSetupPage() { }
}

private extension FuctionExample {
    func set(attribute: String, value: String) -> Bool {
        return false
    }
    
    func attributeExist(attribute: String) -> Bool {
        return true
    }
    
    func setAttribute(attribute: String, value: String) {
        
    }
}

private extension FuctionExample {
    // 한가지 일만 하는 함수
    func renderPageWithSetupAndTearsdowns(with data: PageData, isSuite: Bool) -> String {
        if isTestPage(data) {
            includeSetupAndTeardownPage(data, isSuite: isSuite)
        }
        return data.getHtml()
    }
    
    // 추상화 수준이 동일하지 못하면 읽는 사람이 헷갈린다.
    func renderPageWithSetup(with data: PageData, isSuite: Bool) -> String {
        if isTestPage(data) {
            includeSetup(data, isSuite: isSuite)
        }
        
        var render: String = data.getHtml()
        
        render.append("\n") // 추상화 수준 낮음
        
        return render
    }
}

private extension FuctionExample {
    func isTestPage(_ data: PageData) -> Bool {
        return true
    }
    
    func includeSetupAndTeardownPage(_ data: PageData, isSuite: Bool) {
        print("Include SetupPage")
        print("Include TeardownPage")
    }
    
    func includeSetup(_ data: PageData, isSuite: Bool) {
        print("Include SetupPage")
    }
}
