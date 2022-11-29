# 객체와 자료 구조

### 자료 객체 비대칭
```swift
class Square {
    var topLeft: CGPoint = .init(x: 0, y: 0)
    var side: CGFloat = 0
}

class Rectangle {
    var topLeft: CGPoint = .init(x: 0, y: 0)
    var width: CGFloat = 0
    var height: CGFloat = 0
}

class Circle {
    var center: CGPoint = .init(x: 0, y: 0)
    var radius: CGFloat = 0
}

class Geometry {
    enum GeometryError: Error {
        case noSuchShapeException
    }
    
    func area(shape: AnyClass) throws -> CGFloat {
        if shape is Square.Type {
            let square = Square()
            return square.side * square.side
            
        } else if shape is Rectangle.Type {
            let rectangle = Rectangle()
            return rectangle.width * rectangle.height
            
        } else if shape is Circle.Type {
            let circle = Circle()
            return circle.radius * circle.radius * .pi
            
        } else {
            throw GeometryError.noSuchShapeException
        }
    }
}
```
절차적인 도형 클래스
- 클래스는 자료 구조로 이루어져 있고 메서드를 제공하지 않음
- `Geometry`클래스에 둘레 길이를 구하는 `perimeter()` 함수를 추가한다면? 도형클래스는 아무 영향 받지 않음.
- 반대로 새 도형을 추가 하고 싶다면 `Geometry`클래스에 속한 모든 함수를 고쳐야 함.

```swift
protocol Shape {
    func area() -> CGFloat
}

extension ObjectsData.ObjectSample {
    class Square: Shape {
        private var topLeft: CGPoint = .init(x: 0, y: 0)
        private var side: CGFloat = 0
        
        func area() -> CGFloat {
            side * side
        }
    }
    
    class Rectangle: Shape {
        private var topLeft: CGPoint = .init(x: 0, y: 0)
        private var width: CGFloat = 0
        private var height: CGFloat = 0
        
        func area() -> CGFloat {
            width * height
        }
    }
    
    class Circel: Shape {
        private var center: CGPoint = .init(x: 0, y: 0)
        private var radius: CGFloat = 0
        
        func area() -> CGFloat {
            pow(radius, 2) * .pi
        }
    }
}
```
객체 지향적인 도형 클래스
-  여기서 `area()`는 다형(polymorphic) 함수다.
- `Geometry`클래스는 필요없다.
- 새 도형을 추가 하더라도 기존 함수에 영향을 미치지 않는다.
- 반면 새 함수를 추가 하고 싶으면 도형클래스 전부를 고쳐야 한다.

절차 지향적인 구조와 객체 지향적 언어는 서로 상호 보완적이다.

> **절차적인 코드**는 기존 자료 구조를 변경하지 않으면서 **새 함수를 추가하기 쉽다.**
> **객체 지향적인 코드**는 기존 함수를 변경하지 않으면서 **새 클래스를 추가하기 쉽다.**

> **절차적인 코드**는 **새로운 자료구조를 추가 하기 어렵다.** 그러려면 모든 함수를 고쳐야 한다.
> **객체 지향적인 코드**는 **새로운 함수를 추가하기 어렵다.** 그러려면 모든 클래스를 고쳐야 한다.

### 디미터 법칙
모듈은 자신이 조작하는 객체의 속사정을 몰라야 한다는 법칙.
객체는 자료를 숨기고 함수를 공개해야 한다.
객체는 조회 함수로 내부 구조를 공개하면 안 된다.
```swift
// BAD
let outputDir: String = ctxt.getOption().getScratchDir().getAbsolutePath()

// GOOD
let opts: Option = ctxt.getOption()
let scratchDir: File = opts.getScratchDir()
let outputDir: String = scratchDir.getAbsolutePath()
```

### 자료 전달 객체
```swift
class Address {
    private var street: String
    private var streetExtra: String
    private var city: String
    private var state: String = ""
    private var zip: String = ""
    
    init(
        street: String,
        streetExtra: String,
        city: String,
        state: String,
        zip: String
    ) {
        self.street = street
        self.streetExtra = streetExtra
        self.city = city
        self.state = state
        self.zip = zip
    }
}
```
변수만 있고 함수가 없는 클래스 형태, 자료 구조체를
자료 구조 전달 객체, DTO(Data Transfer Object)라고 한다.

```swift
extension Address {
    func getStreet() -> String {
        street
    }
    
    func getStreetExtra() -> String {
        streetExtra
    }
    
    func getCity() -> String {
        city
    }
    
    func getState() -> String {
        state
    }
    
    func getZip() -> String {
        zip
    }
}
```
위와 같은 형태를 빈(Bean)구조라 한다. 
비공개 변수를 단순히 조회/설정 함수로 조작한다.
하지만 위와 같은 구조는 일부 순수 Oriented Object 순수 주의자나 만족 시킬뿐 변다른 이익은 없다.

##### 활성 레코드 - Active Record
Active Record는 DTO의 특수한 형태 이다. 변수의 조회/설정 함수가 있는 자료 구조이며 `save()`, `find()`와 같은 탐색 함수도 제공한다.
활성 레코드는 데이터 베이스 테이블이나 다른 소스레서 다료를 직접 변환한 결과다.
하지만 이는 바람직 하지 않다. 왜냐면 자료 구조도 아니고 객체도 아닌 잡종구조가 나오기 때문이다.
