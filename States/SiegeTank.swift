//
//  SiegeTank.swift
//  Copyright © 2018 Dimasno1. All rights reserved.
//

import UIKit

final class SiegeTank: UIView {
    
    init(frame: CGRect, battleMode: BattleMode = .tankMode) {
        self.battleMode = battleMode
        state = battleMode.tankState
        super.init(frame: frame)
        
        setMode(to: battleMode)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("required init not implemented, use frame: state: instead")
    }
    
    func attack(target: CGPoint, then callback: Command.Completion? = nil) {
        guard state.canAttack else {
            callback?()
            return
        }
        
        let bulletSize = CGSize(width: canonView.bounds.size.width, height: canonView.bounds.size.width)
        let bulletOrigin = self.center
        let bullet = UIView(frame: CGRect(origin: bulletOrigin, size: bulletSize))
        
        bullet.backgroundColor = .red
        self.superview?.insertSubview(bullet, at: 0)
        
        UIView.animate(withDuration: 0.5 ,animations: {
            bullet.center = target
        }, completion: { _ in
            bullet.removeFromSuperview()
            callback?()
        })
    }
    
    func aim(to target: CGPoint, then callback: Command.Completion? = nil) {
        let turretAngle = (convert(target, from: superview) - turretView.center).angle + CGFloat.pi / 2
        turretView.rotate(to: turretAngle, then: callback)
    }
    
    func move(to position: CGPoint, then callback: Command.Completion? = nil) {
        guard state.canMove else {
            callback?()
            return
        }
        
        let finalAngle = (position - center).angle + CGFloat.pi / 2
        let turretAngle = (convert(position, from: superview) - turretView.center).angle + CGFloat.pi / 2
        
        turretView.rotate(to: turretAngle) {
            self.turretView.rotate(to: 0, then: nil)
            self.rotate(to: finalAngle) {
                self.shift(to: position, then: callback)
            }
        }
    }
    
    private func setMode(to battleMode: BattleMode, callback: (() -> Void)? = nil) {
        guard state.canChangeTo(battleMode.tankState) else {
            callback?()
            return
        }
        self.battleMode = battleMode
        state = battleMode.tankState
        backgroundColor = state.color
        callback?()
    }
    
    func changeState(named: String, callback: (() -> Void)? = nil) {
        switch named {
        case "tank" : setMode(to: .tankMode, callback: callback)
        case "speed": setMode(to: .speedMode, callback: callback)
        case "siege": setMode(to: .siegeMode, callback: callback)
        default: break
        }
    }
    
    private func shift(to position: CGPoint, then callback: Command.Completion? = nil) {
        guard state.canMove else {
            return
        }
        
        let distance = position.distance(to: center)
        let duration = TimeInterval(distance / state.speed)
        let animations = { self.center = position }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: animations) { _ in
            callback?()
        }
    }
    
    private var canonFrame: CGRect {
        let size = CGSize(width: turretView.bounds.size.width / 4, height: turretView.bounds.size.height * 1.1)
        let origin = CGPoint(x: turretView.bounds.midX - size.width / 2, y: -turretView.bounds.size.height * 1.1 )
        return CGRect(origin: origin, size: size)
    }
    
    private var turretSize: CGSize {
        let size = CGSize(width: bounds.size.width * 0.6, height: bounds.size.width * 0.6)
        return size
    }
    
    private func setup() {
        backgroundColor = state.color
        
        layer.cornerRadius = bounds.size.width / 5
        layer.shadowRadius = 2
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 4)
        
        addSubview(turretView)
        
        turretView.bounds.size = turretSize
        turretView.center = CGPoint(x: bounds.midX, y: bounds.midY)
        turretView.backgroundColor = .black
        turretView.layer.cornerRadius = turretSize.width / 5
        turretView.addSubview(canonView)
        
        canonView.backgroundColor = .darkGray
        canonView.frame = canonFrame
        canonView.layer.cornerRadius = canonView.bounds.width / 3
    }
    
    private let turretView = UIView()
    private let canonView = UIView()
    private var battleMode: BattleMode
    private var state: SiegeTankState
}


extension SiegeTank {
    
    enum BattleMode {
        case speedMode
        case siegeMode
        case tankMode
        
        var tankState: SiegeTankState {
            switch self {
            case .tankMode: return TankState()
            case .speedMode: return SpeedState()
            case .siegeMode: return SiegeState()
            }
        }
    }
}

extension UIView {
    func rotate(to: CGFloat, then callback: Command.Completion? = nil) {
        let animation = { self.transform = CGAffineTransform(rotationAngle: to) }
        UIView.animate(withDuration: 0.25, animations: animation) { _ in
            callback?()
        }
    }
}
