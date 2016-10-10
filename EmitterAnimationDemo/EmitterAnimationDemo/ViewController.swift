//
//  ViewController.swift
//  EmitterAnimationDemo
//
//  Created by 鲍的Mac on 2016/10/10.
//  Copyright © 2016年 YorrickBao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var emitter: CAEmitterLayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(pan(_:)))
        view.addGestureRecognizer(gesture)
        
        emitter = CAEmitterLayer()
        emitter.frame = view.frame
        view.layer.addSublayer(emitter)
        
        emitter.emitterShape = kCAEmitterLayerPoint
        emitter.emitterPosition = CGPoint(x: 100, y: 100)
        emitter.birthRate = 0
        
        let emitterCell = CAEmitterCell()
        emitterCell.contents = UIImage(named: "snowflake1")!.cgImage
        
        emitterCell.birthRate = 1
        emitterCell.lifetime = 1
        emitter.emitterCells = [emitterCell]
        
        emitterCell.yAcceleration = 0
        emitterCell.xAcceleration = 200
        emitterCell.velocity = 50.0
        emitterCell.emissionLongitude = CGFloat(-M_PI)
        emitterCell.velocityRange = 100.0
        emitterCell.emissionRange = CGFloat(M_PI)
        emitterCell.color = UIColor(red:0.43, green:0.97, blue:1.00, alpha:1.00).cgColor
        emitterCell.redRange   = 0.2
        emitterCell.greenRange = 0.1
        emitterCell.blueRange  = 0.1
        emitterCell.scale = 0.2
        emitterCell.scaleRange = 0.8
        emitterCell.scaleSpeed = -0.15
        emitterCell.alphaRange = 0.75
        emitterCell.alphaSpeed = -0.15
        emitterCell.lifetimeRange = 1.0
        
    }
    
    func pan(_ gesture: UIPanGestureRecognizer) {
        let point = gesture.location(in: view)
        switch gesture.state {
        case .began:
            emitter.birthRate = 300
            fallthrough
        case .changed:
            emitter.emitterPosition = point
        case .ended:
            emitter.birthRate = 0
        default: break
        }
        
    }




}

