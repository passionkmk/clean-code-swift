# 오류 처리

### 오류 코드보다 예외를 사용하라
```swift
extension DeviceController {
    enum DeviceControllerError: Error {
        case authValidation
        case shutdown
        case reset
    }
    
    func sendShutDown() {
        do {
            try chekValidation()
            try shutdown()
            try reset()
            
        } catch {
            guard let error = error as? DeviceControllerError else {
                return
            }
            switch error {
            case .authValidation:
                print("Check Validation FAIL")
            case .shutdown:
                print("Shutdown FAIL")
            case .reset:
                print("Reset FAIL")
            }
        }
    }
}

private extension DeviceController {
    func chekValidation() throws {
        guard Bool.random() else {
            throw DeviceControllerError.authValidation
        }
        
        print("Check Validation SUCCESS")
    }
    
    func shutdown() throws {
        guard Bool.random() else {
            throw DeviceControllerError.shutdown
        }
        
        print("Shutdown SUCCESS")
    }
    
    func reset() throws {
        guard Bool.random() else {
            throw DeviceControllerError.reset
        }
        print("Reset SUCCESS")
    }
}
```
- 예전에는 오류 처리시 오류 플래그나 오류 코드를 반환하는 방법이 전부.
- 플래그나 오류코드로 분기를 처리하는 방법은 코드가 복잡해진다. 함수를 호출한 즉시 오류를 확인해야 하기 때문.
- 오류가 발생하면 예외를 던지는 편이 좋다. 그러면 호출 코드가 깔끔해짐.

### 미확인(unknown) 에러를 사용하라
모든 에러를 정의하고 처리하는 것은 비용이 많이 든다.
OCP(Open Closed Principle)를 위반한다. 함수에서 확인된 에러를 던졌는데 catch 블록이 세단계 위에 있다면 그 사이 메서드 모두가 선언부에 해당 예외를 정의 해야한다. 즉, 하위 단계에서 코드를 변경하면 상위 단계 메서드 선언부를 전부 고쳐햐 한다는 말이다.

### 호출자를 고려해 예외 클래스를 정의 하라
```swift
// BAD
do {
    try setUpDevice()
} catch DeviceError.error1 {
    print("Error 1 Occur")
} catch DeviceError.error2  {
    print("Error 2 Occur")
} catch DeviceError.error3  {
    print("Error 3 Occur")
}

// GOOD
do {
    try setUpDevice() 
} catch error {
    deviceErrorHandler(error)
}
```
에러 핸들러가 에러를 처리할수 있게 하면 코드가 깔끔해 진다.

