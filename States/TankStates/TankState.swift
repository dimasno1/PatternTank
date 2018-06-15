//
//  TankState.swift
//  States
//
//  Created by Dimasno1 on 6/12/18.
//  Copyright © 2018 Dimasno1. All rights reserved.
//

import UIKit

class TankState: SiegeTankState {
    
    var identifier: String {
        return "tank"
    }
    
    func canChangeTo(_ state: SiegeTankState) -> Bool {
        switch state {
        case is TankState: return false
        case is SpeedState: return true
        case is SiegeState: return true
        default: return false
        }
    }
    
    var damage: Int = 7
    var speed: CGFloat = 100
    var armor: Int = 2
    var canMove: Bool = true
    var canAttack: Bool = true
    var color: UIColor = .gray
}
