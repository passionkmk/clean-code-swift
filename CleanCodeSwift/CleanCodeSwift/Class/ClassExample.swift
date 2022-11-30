//
//  ClassExample.swift
//  CleanCodeSwift
//
//  Created by pkmk on 2022/11/30.
//

import Foundation

final class ClassExample {
    class Component { }
}

extension ClassExample {
    class SuperDashboard {
        func getLastFocusedComponent() -> Component { Component() }
        func setLastFocused(component: Component) { }
        func getMajorVersionNumber() -> Int { 0 }
        func getMinorVersionNumber() -> Int { 0 }
        func getBuildNumber() -> Int { 0 }
    }
    
    class Version {
        func getMajorVersionNumber() -> Int { 0 }
        func getMinorVersionNumber() -> Int { 0 }
        func getBuildNumber() -> Int { 0 }
    }
}
