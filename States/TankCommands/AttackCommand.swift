//
//  AttackCommand.swift
//  States
//
//  Created by Dimasno1 on 6/14/18.
//  Copyright © 2018 Dimasno1. All rights reserved.
//

import UIKit

class AttackCommand: Command {
    
    func execute(then callback: (() -> Void)?) {
        siegeTank.attack(target: target, then: callback)
    }

    init(siegeTank: SiegeTank, target: CGPoint) {
        self.siegeTank = siegeTank
        self.target = target
    }

    private var target: CGPoint
    private var siegeTank: SiegeTank
}
