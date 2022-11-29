//
//  ObjectsData.swift
//  CleanCodeSwift
//
//  Created by pkmk on 2022/11/29.
//

import Foundation

final class ObjectsData {
    class DataSample { }
    class ObjectSample { }
}

extension ObjectsData.DataSample {
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
}

// 절차적인 도형
extension ObjectsData.DataSample {
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
                return pow(circle.radius, 2) * .pi
                
            } else {
                throw GeometryError.noSuchShapeException
            }
        }
    }
}

// 다형적인 도형
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
