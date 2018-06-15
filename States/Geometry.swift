//
//  VectorMath.swift
//  States
//
//  Created by Dimasno1 on 6/13/18.
//  Copyright © 2018 Dimasno1. All rights reserved.
//

import UIKit

typealias Vector = CGPoint

extension Vector {
    
    static func -(l: Vector, r: Vector) -> Vector {
        return Vector(x: l.x - r.x, y: l.y - r.y)
    }
    
    var angle: CGFloat {
        return atan2(y, x)
    }
    
    var length: CGFloat {
        return sqrt(x * x + y * y)
    }
    
    func distance(to vector: Vector) -> CGFloat {
        return (vector - self).length
    }
}
