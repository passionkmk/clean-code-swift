//
//  ErrorHandling.swift
//  CleanCodeSwift
//
//  Created by pkmk on 2022/11/29.
//

import Foundation

final class ErrorHandling {
    class DeviceController { }
}

extension ErrorHandling.DeviceController {
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

private extension ErrorHandling.DeviceController {
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
