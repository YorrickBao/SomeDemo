//
//  SecondViewController.swift
//  HeroDemo
//
//  Created by 鲍的Mac on 2017/3/16.
//  Copyright © 2017年 YorrickBao. All rights reserved.
//

import UIKit
import Hero
import ChameleonFramework
import Lottie

class SecondViewController: UIViewController {

    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var maskView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.textColor = UIColor.init(randomFlatColorOf: .dark)
        view.backgroundColor = UIColor(randomFlatColorOf: .light)
        avatarView.heroID = "avatarView"
        nameLabel.heroID = "nameLabel"
        maskView.heroModifiers = [.translate(y: 200), .fade, .cascade, .scale(0.5)]
        isHeroEnabled = true
        avatarView.isUserInteractionEnabled = true
        avatarView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panHandler(_:))))
        
    }
    
    func panHandler(_ sender: UIPanGestureRecognizer) {
        let offset = sender.translation(in: nil).y
        switch sender.state {
        case .began:
            dismiss(animated: true, completion: nil)
        case .changed:
            Hero.shared.update(progress: Double(abs(offset) / 200))
        case .ended:
            if abs(offset) < 100 {
                Hero.shared.cancel(animate: true)
            } else {
                Hero.shared.end(animate: true)
            }
        default:
            Hero.shared.cancel(animate: true)
        }

    }

    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }


}
