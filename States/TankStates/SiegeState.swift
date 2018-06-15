//
//  SiegeState.swift
//  States
//
//  Created by Dimasno1 on 6/12/18.
//  Copyright © 2018 Dimasno1. All rights reserved.
//

import UIKit

class SiegeState: SiegeTankState {
    
    var identifier: String {
        return "siege"
    }
    
    func canChangeTo(_ state: SiegeTankState) -> Bool {
        switch state {
        case is TankState: return true
        case is SpeedState: return false
        case is SiegeState: return false
        default: return false
        }
    }
    
    var damage: Int = 20
    var armor: Int = 17
    var canMove: Bool = false
    var speed: CGFloat = 5
    var canAttack: Bool = true
    var color: UIColor = .brown
    
}
