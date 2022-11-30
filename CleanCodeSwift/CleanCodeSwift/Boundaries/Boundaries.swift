//
//  Boundaries.swift
//  CleanCodeSwift
//
//  Created by pkmk on 2022/11/30.
//

import Foundation

protocol HashMap {
    func get(id: String) -> AnyObject?
}

final class Boundaries {
    class Sensor {
        var map = MyMap()
        
        func get(id: String) -> Sensor? {
            map.get(id: id) as? Sensor
        }
    }
    
    class MyMap: HashMap {
        var maps: [String: AnyObject] = [:]
        
        func get(id: String) -> AnyObject? {
            maps[id]
        }
    }
    
    class SpecialMap<T> {
        var maps: [String: T] = [:]
        
        func get(id: String) -> T? {
            maps[id]
        }
    }
}

extension Boundaries {
    func test() {
        let map = MyMap()
        let sesor = map.get(id: "sensor") as? Sensor
        
        let specialMap = SpecialMap<Sensor>()
        let specailSensor = specialMap.get(id: "sensor")
    }
}

extension Boundaries {
    
}
