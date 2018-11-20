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
        if let referenceBounds = dynamicAnimator?.referenceView?.bounds {
            let center = CGPoint(x: referenceBounds.midX, y: referenceBounds.midY)
            push.angle = (CGFloat.pi/2).arc4random
            switch (item.center.x, item.center.y) {
            case let (x, y) where x < center.x && y > center.y:
                push.angle = -1 * push.angle
            case let (x, y) where x > center.x:
                push.angle = y < center.y ? CGFloat.pi-push.angle: CGFloat.pi+push.angle
            default:
                push.angle = (CGFloat.pi*2).arc4random
            }
        }
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
    func removeItem(_ item: UIDynamicItem) {
        collissionBehaviour.removeItem(item)
        itemBehaviour.removeItem(item)
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
