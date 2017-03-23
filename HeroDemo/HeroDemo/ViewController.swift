//
//  ViewController.swift
//  HeroDemo
//
//  Created by 鲍的Mac on 2017/3/14.
//  Copyright © 2017年 YorrickBao. All rights reserved.
//

import UIKit
import Lottie
import ChameleonFramework
import Hero

class ViewController: UIViewController {

    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(randomFlatColorOf: UIShadeStyle.light)
        avatarView.heroID = "avatarView"
        nameLabel.heroID = "nameLabel"
        isHeroEnabled = true
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let color = UIColor(randomFlatColorOf: UIShadeStyle.light)
        view.backgroundColor = color
        
        sender.backgroundColor = UIColor.init(contrastingBlackOrWhiteColorOn: color, isFlat: true)//UIColor(complementaryFlatColorOf: color)
        sender.tintColor = color?.darken(byPercentage: 0.05)
        
    }

}

