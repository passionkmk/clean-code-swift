# 클래스

### 클래스 체계
```swift
class MyClass {
    static var value1: String
    
    var value2: String
    
    private var value3: String
    
    func testValue()
}
```
static > public > private > function 순서로 기입

#### 캡슐화
변수와 유틸리티는 가능한 공개하지 않는 편이 좋지만 반드시 숨겨야 하는 법칙도 없다. 캡슐화를 정하는것을 용도에 맞게 적정하게 지정해야 한다.

### 클래스는 작아야한다.
- 클래스는 작아야한다. 클래스가 크면 큰 만큼 많은 책임을 가진다.
- 클래스의 이름은 해당 클래스의 책임을 기술 해야한다.(클래스의 이름이 떠오르지 않는 다면 클래스의 책임이 너무 커서 일지도 모른다.)

#### 단일 책임 원칙 (Single Responsbility Principle)
클래스나 모듈을 변경할 이유가 단 하나 여야 한다.
```swift
// BAD
class SuperDashboard {
    func getLastFocusedComponent() -> Component { }
    func setLastFocused(component: Component) { }
    func getMajorVersionNumber() -> Int { }
    func getMinorVersionNumber() -> Int { }
    func getBuildNumber() -> Int { }
}

// GOOD
class Version {
    func getMajorVersionNumber() -> Int { }
    func getMinorVersionNumber() -> Int { }
    func getBuildNumber() -> Int { }
}
```
- `SuperDashboard`는 충분히 작지 않다. `Component`를 관리 하는 책임과 버전 정보를 가져오는 책임 둘 다 가지고 있기 때문이다.
- `Version`으로 나눠서 버전 정보를 가져오는 객체로 분리 할수 있다.

SPR은 객체 지향 설계에서 중요한 개념이고 이해하고 지키기 수월한 개념이다.
하지만 이상하게도 SPR은 클래스 설계자가 가장 무시하는 규칙 중 하나다. 

그 이유는 *깨끗하고 체계적인 소프트웨어* 보다 *돌아가는 소프트웨어* 에 초첨을 맞추기 때문이다. 문제는 우리들 대다수가 *프로그램이 돌아가면 끝났다* 고 여기는 데 있다.

> **개인적인 생각**
> 클래스가 너무 작아도 복잡한 구조의 프로그램에서는 클래스 개수가 많아지면서 프로그램 복잡도를 늘릴수도 있을 것 같다.
>
> **마틴 생각**
> 작은 클래스가 많은 시스템이든 큰 클래스가 몇 개뿐인 시스템이든 돌아가는 부품은 그 수가 비슷하다.
> 복잡성을 다루려면 체계적인 정리가 필수다. 그래야 개발자가 무엇이 어디에 있는지 쉽게 찾는다. 직접 영향이 미치는 컴포넌트만 이해해도 충분하다.
> 큼직한 다목적 클래스로 몇 개 이루어진 시스템은 변경을 가할때 당장 알 필요가 없는 사실까지 들이 밀어 개발자를 방해한다.
> *작은 클래스는 각자 맡은 책임이 하나며, 변경 할 이유가 하나며, 다른 작은 클래스와 협력해 시스템에 필요한 동작을 수행한다.*

#### 응집도 (Cohension)
- 클래스는 인스턴스 변수 수가 작아야 한다.
- 각 클래스 함수는 클래스 인스턴스 변수를 하나 이상 사용해야 한다.
- 함수가 변수를 더 많이 사용할수록 함수와 클래스는 응집도가 높다.

응집도가 높은 클래스는 바람직하지 않다.
