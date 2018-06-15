//
//  ViewController.swift
//  States
//
//  Created by Dimasno1 on 6/12/18.
//  Copyright © 2018 Dimasno1. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        makeButtons()
        view.addSubview(siegeTank)
    }
    
    @objc private func moveGestureHandler(sender: UITapGestureRecognizer) {
        if !siegeTank.frame.contains(sender.location(in: view)) {
            let destination = sender.location(in: view)
            let moveCommand = MoveCommand(siegeTank: siegeTank, destination: destination)
            commandDispatcher.add(moveCommand)
        }
    }
    
    @objc private func aimGestureHandler(sender: UITapGestureRecognizer) {
        let destination = sender.location(in: view)
        let aimCommand = AimCommand(siegeTank: siegeTank, target: destination)
        commandDispatcher.add(aimCommand)
        
        aimedTarget = destination
    }
    
    @objc private func swipeGestureHandler(sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .up: if let targetToAttack = aimedTarget {
                    switch sender.state {
                    case .changed, .ended:
                        let attackCommand = AttackCommand(siegeTank: siegeTank, target: targetToAttack)
                        commandDispatcher.add(attackCommand)
                    default: break
                }
            }
        default: break
        }
    }
    
    private func setup() {
        view.backgroundColor = .green
        siegeTank = SiegeTank(frame: CGRect(origin: view.center, size: CGSize(width: 25, height: 33)), battleMode: .speedMode)
        
        let moveRecognizer = UITapGestureRecognizer(target: self, action: #selector(moveGestureHandler(sender:)))
        moveRecognizer.numberOfTapsRequired = 2
        recognizers.append(moveRecognizer)
        
        let aimRecognizer = UITapGestureRecognizer(target: self, action: #selector(aimGestureHandler(sender:)))
        aimRecognizer.numberOfTapsRequired = 1
        recognizers.append(aimRecognizer)
        
        let attackRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureHandler(sender:)))
        attackRecognizer.direction = .up
        recognizers.append(attackRecognizer)
        
        let commandRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureHandler(sender:)))
        commandRecognizer.direction = .down
        recognizers.append(commandRecognizer)
        
        view.addGestureRecognizer(moveRecognizer)
        view.addGestureRecognizer(attackRecognizer)
        view.addGestureRecognizer(aimRecognizer)
        view.addGestureRecognizer(commandRecognizer)
    }
    
    @objc func changeMode(sender: UIButton) {
        let changeStateCommand = ChangeStateCommand(siegeTank: siegeTank, state: sender.currentTitle ?? "")
        commandDispatcher.add(changeStateCommand)
    }
    
    
    private func makeButtons() {
        let siegeButton = UIButton(type: .system)
        siegeButton.setTitle("siege", for: .normal)
        siegeButton.sizeToFit()
        siegeButton.addTarget(self, action: #selector(changeMode(sender:)), for: .touchUpInside)
        siegeButton.center = CGPoint(x: view.bounds.midX, y: view.bounds.maxY - 20)
        
        let tankButton = UIButton(type: .system)
        tankButton.setTitle("tank", for: .normal)
        tankButton.sizeToFit()
        tankButton.addTarget(self, action: #selector(changeMode(sender:)), for: .touchUpInside)
        tankButton.center = CGPoint(x: view.bounds.midX / 2, y: view.bounds.maxY - 20)
        
        let speedButton = UIButton(type: .system)
        speedButton.setTitle("speed", for: .normal)
        speedButton.sizeToFit()
        speedButton.addTarget(self, action: #selector(changeMode(sender:)), for: .touchUpInside)
        speedButton.center = CGPoint(x: view.bounds.maxX - view.bounds.midX / 2, y: view.bounds.maxY - 20)
        
        view.addSubview(siegeButton)
        view.addSubview(tankButton)
        view.addSubview(speedButton)
    }
    
    private var aimedTarget: CGPoint?
    private var siegeTank: SiegeTank!
    private var commandDispatcher = CommandsDispatcher()
    private var recognizers = [UIGestureRecognizer]()
}

