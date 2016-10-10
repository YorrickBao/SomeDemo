//
//  imageView.swift
//  coreMotionDemo
//
//  Created by 鲍的Mac on 10/9/16.
//  Copyright © 2016 YorrickBao. All rights reserved.
//

import UIKit
import CoreMotion

class imageView: UIImageView {
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var rotating = false {
        didSet {
            rotate()
        }
    }
    
    let motionManager = CMMotionManager()
    
    private var gravityDirection = CGVector.zero {
        didSet {
            makeRotateTransform()
        }
    }
    
    func rotate() {
        if rotating {
            guard motionManager.isDeviceMotionAvailable && !motionManager.isDeviceMotionActive else { return }
            motionManager.deviceMotionUpdateInterval = 0.01
            motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { [unowned self] (data, error) in
                if let dx = data?.gravity.x, let dy = data?.gravity.y, (abs(dx) > 0.1 || abs(dy) > 0.1) {
                    self.gravityDirection = CGVector(dx: dx, dy: dy)
                }
            }
        } else {
            motionManager.stopDeviceMotionUpdates()
        }
//        if rotating {
//            guard motionManager.isAccelerometerAvailable && !motionManager.isAccelerometerActive else { return }
//            motionManager.accelerometerUpdateInterval = 1/60
//            motionManager.startAccelerometerUpdates(to: OperationQueue.main) { [unowned self] (data, error) in
//                if let dx = data?.acceleration.x, let dy = data?.acceleration.y, (abs(dx) > 0.1 || abs(dy) > 0.1) {
//                    self.gravityDirection = CGVector(dx: dx, dy: dy)
//                }
//            }
//        } else {
//            motionManager.stopAccelerometerUpdates()
//        }
    }
    
    func makeRotateTransform() {
        if gravityDirection != CGVector.zero {
            let x = -gravityDirection.dy
            let y = gravityDirection.dx

            var angel = CGFloat()
            switch (x, y) {
            case let (x, y) where x >= 0 :
                angel = -atan(y/x)
            case let (x, y) where x < 0 && y >= 0 :
                angel = -CGFloat(M_PI) - atan(y/x)
            case let (x, y) where x < 0 && y < 0 :
                angel = CGFloat(M_PI) - atan(y/x)
            default: break
            }
            
//            let animation = CABasicAnimation(keyPath: "transform.rotation")
//            animation.toValue = angel
//            animation.duration = 0.3
//            layer.add(animation, forKey: nil)
//            layer.transform = CATransform3DMakeRotation(angel, 0, 0, 1)
            
            UIView.animate(withDuration: 0.2) {
                self.layer.transform = CATransform3DMakeRotation(angel, 0, 0, 1)
            }
            


        }


    }

}
