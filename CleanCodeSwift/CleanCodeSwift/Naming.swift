//
//  Naming.swift
//  CleanCodeSwift
//
//  Created by pkmk on 2022/11/23.
//

import Foundation

final class NamingExample {
    var d: Int = 0 // 의미없는 이름
    
    var elapsedTimeInDay: Int = 0 // 의미있는 이름
    var daysSinceCreation: Int = 0
    
    let theArray: [Int] = Array(0...10)
    let gameBoard: [Cell] = Array(0...10).map { Cell(status: $0) }
    
    var hp: Int = 0 // hypotenuse 의 약어, 자신만 알수 잇는 약어는 쓰지 않는것이 좋음
    var hypotenuse: Int = 0
}

private extension NamingExample {
    class Person {
        private var name: String = ""
        
        func getName() -> String {
            name
        }
    }
    
    class Animal {
        private var name: String = ""
        
        func fetchName() -> String {
            name
        }
    }
    
    class Plant {
        private var name: String = ""
        
        func retrieveName() -> String {
            name
        }
    }
    
    func printName() {
        let person = Person()
        let animal = Animal()
        let plant = Plant()
        
        // 이름을 가져오는 같은 기능을 하는 메서드임에도 클래스 마다 이름이 제각각이다.
        print("Peron: \(person.getName())")
        print("Animal: \(animal.fetchName())")
        print("Plant: \(plant.retrieveName())")
    }
}

private extension NamingExample {
    // 코드가 무슨일을 하는지 짐작하기 어려운 함수, 코드자체에 명시적으로 기능이 들어나지 않음
    func getThem() -> [Int] {
        var list1: [Int] = []
        
        for x in theArray {
            if x == 4 {
                list1.append(x)
            }
        }
        
        return list1
    }
    
    // 이름을 명시적으로 바꿈으로써 함수가 하는 기능이 좀더 명확해짐
    func getFlaggedCells() -> [Cell] {
        var flaggedCells: [Cell] = []
        
        for cell in gameBoard {
            if cell.status == Constant.flagged {
                flaggedCells.append(cell)
            }
        }
        
        return flaggedCells
    }
}

private extension NamingExample {
    // a1, a2 처럼 의미없는 이름의 파라미터는 사용하지 않는것이 좋다
    func copyCharacteBad(a1: [Character], a2: inout [Character]) {
        let length = min(a1.count, a2.count)
        
        for index in 0 ..< length {
            a2[index] = a1[index]
        }
    }
    
    // source와 destination이라는 이름을 사용하여서 인자가 하는 역할을 충분히 알수 잇게 되었다.
    func copyCharacteGood(source: [Character], destination: inout [Character]) {
        let length = min(source.count, destination.count)
        
        for index in 0 ..< length {
            destination[index] = source[index]
        }
    }
}

private extension NamingExample {
    // 처음 참여하는 프로그래머가 어떤기능 인지 구분할 수 이름은 사용하지 말자
    // 읽는 사람이 차이를 알 수 있게 이름을 지어라
    func getActiveAccount() { }
    func getActiveAccounts() { }
    func getActiveAccountInfo() { }
}

private extension NamingExample {
    enum Constant {
        static let flagged: Int = 4
    }
}
