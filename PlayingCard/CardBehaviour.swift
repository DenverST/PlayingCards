//
//  CardBehaviour.swift
//  PlayingCard
//
//  Created by Denver Stove on 20/11/18.
//  Copyright © 2018 Denver Stove. All rights reserved.
//

import UIKit

class CardBehaviour: UIDynamicBehavior {
    
    lazy var collissionBehaviour: UICollisionBehavior = {
        let behaviour = UICollisionBehavior()
        behaviour.translatesReferenceBoundsIntoBoundary = true
        return behaviour
    }()
    
    lazy var itemBehaviour: UIDynamicItemBehavior = {
        let behaviour = UIDynamicItemBehavior()
        behaviour.allowsRotation = false
        behaviour.elasticity = 1.0
        behaviour.resistance = 0.0
        return behaviour
    }()
    
    private func push(_ item: UIDynamicItem) {
        let push = UIPushBehavior(items: [item], mode: .instantaneous)
        push.angle = (2*CGFloat.pi).arc4random
        push.magnitude = CGFloat(1.0) + CGFloat(2.0).arc4random
        push.action = { [unowned push, weak self] in
            self?.removeChildBehavior(push)
        }
    addChildBehavior(push)
    }
    
    func addItem(_ item: UIDynamicItem) {
        collissionBehaviour.addItem(item)
        itemBehaviour.addItem(item)
        push(item)
    }
    
    override init() {
        super.init()
        addChildBehavior(collissionBehaviour)
        addChildBehavior(itemBehaviour)
    }
    
    convenience init(in animator: UIDynamicAnimator) {
        self.init()
        animator.addBehavior(self)
    }
}
