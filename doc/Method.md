# 함수

### 작게 만들어라!
함수를 만드는 
첫번째 규칙은 작게 만드는 것이다.
두번째 규칙은 **더** 작게 만드는 것이다.
##### 블록과 들여쓰기
`if else`, `switch`, `while` 등 block안에서는 한줄로만 작성한다.(이게 가능? ㅠㅠ)
들여쓰기는 1단이나 2단을 넘어서지 않도록 하자.

### 한가지만 하기
함수는 한 가지를 해야한다.
그 한 가지 잘 해야 한다.
그 한 가지만을 해야 한다.
```swift
func isTestPage(_ data: PageData) -> Bool {
        return true
    }
    
func includeSetupAndTeardownPage(_ data: PageData, isSuite: Bool) {
    print("Include SetupPage")
    print("Include TeardownPage")
}

func renderPageWithSetupAndTearsdowns(with data: PageData, isSuite: Bool) -> String {
    if isTestPage(data) { // --- 1
        includeSetupAndTeardownPage(data, isSuite: isSuite) // --- 2
    }
    return data.getHtml() // --- 3
}
```
`renderPageWithSetupAndTearsdowns` 는 1가지 일을 하는것인가 3가지 일을 하는것인가?
1. 테스트 페이지인지 확인한다.
2. 테스트 페이지 이면 설정 페이지와 해제 페이지를 넣는다.
3. 페이지를 html로 렌더링한다.

3가지 일을 하는것 처럼 보이지만 이것은 추상화 수준이 하나다.
`TO`문단으로 기술해보면 알수있다.

> `TO RenderPageWithSetupAndTearsdowns`
> 페이지가 테스트 페이지인가 확인한 후 테스트 페이지라면 설정 페이지와 해제 페이지를 넣는다. 테스트 페이지든 아니든 페이지를 HTML로 렌더링 한다.

지정된 함수 이름아래에서 하나인 단계만 수행하면 그 함수는 한 가지 작업만 한다.

##### 함수 당 추상화 수준은 하나로 해야한다.
```swift
func renderPageWithSetup(with data: PageData, isSuite: Bool) -> String {
    if isTestPage(data) { // 추상화 수준 높음
        includeSetup(data, isSuite: isSuite)
    }
    
    var render: String = data.getHtml()
    
    render.append("\n") // 추상화 수준 낮음
    
    return render
}
```
추상화 수준이 동일하지 못하면 읽는 사람이 헷갈린다.

### Switch 문
한 가지 작업만 하는 `switch`문은 만들기 어렵다. N가지의 작업을 처리한다. 하지만 `switch`을 Fatory Pattern 을 이용하여 저 차원 클래스에 숨기고 절대로 반복하지 않는 방법은 있다.
다형성(polymophism)을 이용한다.
```swift
struct EmployRecord {
    let type: EmployType
    let payDate: Date
    let workHour: Int
    let wage: Int
}

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
```
문제점
1. 함수가 길다. 새 직원 유형을 추가하면 더 길어진다.
2. '한 가지' 작업만 수행하지 않는다.
3. 단일 책임 원칙(Single Responsibillity Principle)을 위반한다.
코트를 변경할 이유가 여럿이기 때문이다.
4. 개방 폐쇄 원칙(Open Closed Principle)을 위반한다.
새직원을 추가할때마다 코드 변경이 필요하다.
5. 동일한 함수가 무한히 존재한다.

```swift
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

...

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
```
개선
1. `switch` 추상문을 팩토리 패턴으로 은닉화함
2. `switch`을 통해 적절한 `Employee` 를 따르는 클래스의 인스턴스를 생성.
3.`isPayday`, `calculatePay()`, `deliveryPay()`는 프로토콜을 extention 으로 정의되어 있고 각 실제 파생 클래스의 함수가 실행됨.
    

