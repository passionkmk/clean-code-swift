# Naming

### 의도가 분명히 있는 이름을 사용
```swift
var d: Int = 0 // BAD, 의미없는 이름

var elapsedTimeInDay: Int = 0 // GOOD, 의미있는 이름
var daysSinceCreation: Int = 0
```
변수명에도 의미 있는 이름을 사용하자

```swift
func getThem() -> [Int] { // BAD
    var list1: [Int] = [] // --- 1
    
    for x in theArray { // --- 2
        if x == 4 { // --- 3
            list1.append(x)
        }
    }
    
    return list1
}
```
코드가 무슨일을 하는지 짐작하기 어려운 함수, 코드자체에 명시적으로 기능이 들어나지 않음
1. 함수가 반환하는 `list1`을 어떻게 사용하는가?
2. `theArray`에 무엇이 들어있는가?
3. `x`와 `4`는 어떤 의미인가?

```swift
func getFlaggedCells() -> [Cell] { // GOOD
    var flaggedCells: [Cell] = []
    
    for cell in gameBoard {
        if cell.status == Constant.flagged {
            flaggedCells.append(cell)
        }
    }
    
    return flaggedCells
}
```
이름을 명시적으로 바꿈으로써 함수가 하는 기능이 좀더 명확해진다.

### 그릇된 정보 피하기
```swift
var hp: Int = 0 // BAD, hypotenuse 의 약어
var hypotenuse: Int = 0 // GOOD
```
자신만 알수 잇는 약어는 쓰지말자

```swift
var productList: [String: Price] = [:] // BAD 
var products: [String: Price]] = [:] // GOOD
```
`List`와 같은 혼용하기 자료형과 헷갈리기 쉬운 것은 피하고 단순하게 표현한다.

### 의미있게 구분하기
```swift 
func copyCharacteBad(a1: [Character], a2: inout [Character]) {
    let length = min(a1.count, a2.count)
    
    for index in 0 ..< length {
        a2[index] = a1[index]
    }
}
```
`a1`, `a2` 처럼 의미없는 이름의 파라미터는 사용하지 않는것이 좋다.

```swift
func copyCharacteGood(source: [Character], destination: inout [Character]) {
    let length = min(source.count, destination.count)
    
    for index in 0 ..< length {
        destination[index] = source[index]
    }
}
```
`source`와 `destination`이라는 이름을 사용하여서 인자가 하는 역할을 충분히 알 수 있게 되었다.

```swift
func getActiveAccount() { }
func getActiveAccounts() { }
func getActiveAccountInfo() { }
```
처음 참여하는 프로그래머가 어떤기능 인지 구분할 수 이름은 사용하지 말자.
읽는 사람이 차이를 알 수 있게 이름을 지어라.

### 클래스 이름
```swift
// GOOD
class Customer { }
class WikiPage { }
class Account { }
class AddressParser { }

// BAD
class Manager { }
class Processor { }
class Data { }
class Info {}
```
명사나 명사구를 사용한다. 동사는 사용하지 않음

### 메서드 이름
```swift
// GOOD
func postPayment() { }
func deletePage() { }
func save() { }

func isPerson() -> Bool { } // is
func setPrice(_ price: Int) {  } // set
func getPrice() -> Int { } // get 
```
동사나 동사구를 사용한다.

### 한 개념에 한 단어만 사용
```swift
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

let person = Person()
let animal = Animal()
let plant = Plant()

// 이름을 가져오는 같은 기능을 하는 메서드임에도 클래스 마다 이름이 제각각이다.
print("Peron: \(person.getName())")
print("Animal: \(animal.fetchName())")
print("Plant: \(plant.retrieveName())")
```
같은기능을 하는 코드라면 이름명을 통일하자.
일관성있는 이름을 사용하자.

하지만 "한 개념에 한 단어를 사용하라"는 규칙때문에
너무 포괄적으로 이름 통일 시켜서도 안된다.

### 그외
 - 발음하기 쉬운 이름을 사용하자.
 - 검색하기 쉬운 이름을 사용하자.
 - 카멜 표기법을 사용하자.
 - 기발한 이름은 피하자.

