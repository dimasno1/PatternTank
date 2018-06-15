//
//  ISiegeTankState.swift
//  States
//
//  Created by Dimasno1 on 6/12/18.
//  Copyright © 2018 Dimasno1. All rights reserved.
//

import UIKit

protocol SiegeTankState {
    
    var identifier: String { get }
    var damage: Int { get }
    var speed: CGFloat { get }
    var armor: Int { get }
    var canMove: Bool { get }
    var canAttack: Bool { get }
    var color: UIColor { get }
    func canChangeTo(_ state: SiegeTankState) -> Bool
}
