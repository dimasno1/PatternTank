//
//  SpeedState.swift
//  States
//
//  Created by Dimasno1 on 6/12/18.
//  Copyright © 2018 Dimasno1. All rights reserved.
//

import UIKit

class SpeedState: SiegeTankState {
    
    var identifier: String {
        return "speed"
    }
    
    func canChangeTo(_ state: SiegeTankState) -> Bool {
        switch state {
        case is TankState: return true
        case is SpeedState: return false
        case is SiegeState: return true
        default: return false
        }
    }
    
    var damage: Int = 0
    var speed: CGFloat = 200
    var armor: Int = 5
    var canMove: Bool = true
    var canAttack: Bool = false
    var color: UIColor =  .black
}
