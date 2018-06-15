//
//  ChangeStateCommand.swift
//  States
//
//  Created by Dimasno1 on 6/15/18.
//  Copyright © 2018 Dimasno1. All rights reserved.
//

import UIKit

class ChangeStateCommand: Command {
    
    func execute(then completion: Command.Completion?) {
        siegeTank.changeState(named: indentifier, callback: completion)
    }
   
    init(siegeTank: SiegeTank, state identifier: String) {
        self.siegeTank = siegeTank
        self.indentifier = identifier
    }
    
    private var indentifier: String
    private var siegeTank: SiegeTank
}
