# 경계

### 외부 코드 사용하기
```swift
protocol HashMap {
    func get(id: String) -> AnyObject?
}
    
class MyMap: HashMap {
    var maps: [String: AnyObject] = [:]
    
    func get(id: String) -> AnyObject? {
        maps[id]
    }
}

class Sensor { }

let map = MyMap() // --- 1
let sesor = map.get(id: "sensor") as? Sensor // --- 2
```
1. `Sensor`를 담는 객체 `MyMap`을 만든다.
2. `Sensor`객체가 필요하면 `MyMap`에서 2와 같이 가져온다.

위와 같은 코드는 여러차례 나온다. 즉 `MyMap`이 반환하는 Object를 올바른 유형으로 변환할 책임은 `Map`을 사용하는 클라이언트에 있다. 코드는 작동하지만 깨끗한 코드라 보기는 어렵다.

```swift
class SpecialMap<T> {
    var maps: [String: T] = [:]
    
    func get(id: String) -> T? {
        maps[id]
    }
}

let specialMap = SpecialMap<Sensor>()
let specailSensor = specialMap.get(id: "sensor")
```
- Generic을 사용하면 가독성은 늘어난다.
- 하지만 `HashMap`의 인터페이스가 변할 경우 수정할 코드가 많아 진다.

```swift
class Sensor {
    var map = MyMap() // --- 1
    
    func get(id: String) -> Sensor? {
        map.get(id: id) as? Sensor // --- 2
    }
}
```
개선
1. 경계 인터 페이스인 `MyMap`을 `Sensor` 안으로 숨긴다. 
따라서 인터페이스가 변하더라도 나머지 프로그램에는 영향을 미치지 않는다.
2. Generic을 사용하든 하지 않든 더 이상 문제가 되지 않는다. `Sensor`안에서 객체 유형을 관리하게 되기 때문이다.

프로그램에 필요한 인터페이스만 제공하며 나머지 프로그램이 설계 규칙과 비즈니스 규칙을 따르도록 강제 할 수 있다.

