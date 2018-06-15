//
//  MoveCommand.swift
//  States
//
//  Created by Dimasno1 on 6/14/18.
//  Copyright © 2018 Dimasno1. All rights reserved.
//

import UIKit

class MoveCommand: Command {
    
    func execute(then callback: (() -> Void)?) {
        siegeTank.move(to: destination, then: callback)
    }
    
    init(siegeTank: SiegeTank, destination: CGPoint) {
        self.siegeTank = siegeTank
        self.destination = destination
    }
    
    private var destination: CGPoint
    private var siegeTank: SiegeTank
}
