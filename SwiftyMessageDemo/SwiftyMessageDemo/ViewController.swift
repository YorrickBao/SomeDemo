//
//  ViewController.swift
//  SwiftyMessageDemo
//
//  Created by 鲍的Mac on 2016/12/27.
//  Copyright © 2016年 YorrickBao. All rights reserved.
//

import UIKit
import SwiftMessages
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var myTabBarItem: UITabBarItem!
    
    let loadingImages = [#imageLiteral(resourceName: "load-C1"), #imageLiteral(resourceName: "load-C2"), #imageLiteral(resourceName: "load-C3"), #imageLiteral(resourceName: "load-C4"), #imageLiteral(resourceName: "load-C5"), #imageLiteral(resourceName: "load-C6")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    var configAndView: (config: SwiftMessages.Config, view: UIView) = {
        $0.duration = .seconds(seconds: 5)
        $0.dimMode = .gray(interactive: false)
        $1.configureTheme(.error, iconStyle: .default)
        $1.configureDropShadow()
        $1.configureContent(title: "网络不可用", body: "请检查您的网络设置", iconImage: Icon.Error.image, iconText: nil, buttonImage: nil, buttonTitle: "知道了") { _ in SwiftMessages.hide() }
        return ($0, $1)
    }(&SwiftMessages.defaultConfig, MessageView.viewFromNib(layout: .CardView))
    
    @IBAction func showMessage(_ sender: UIButton) {
        
//        SwiftMessages.show(config: configAndView.config, view: configAndView.view)
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        containerView.backgroundColor = .lightGray
        let aView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        aView.center = containerView.center
        aView.animationImages = loadingImages
        aView.animationDuration = 1
        aView.startAnimating()
        containerView.addSubview(aView)
        
        containerView.center = self.view.center
        
        var conf = SwiftMessages.Config()
        conf.duration = .forever
        conf.interactiveHide = false
        conf.presentationContext = .viewController(self)
            
        SwiftMessages.show(config: conf, view: containerView)

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { 
            SwiftMessages.hide()
        }
    }
   
    @IBAction func navgate(_ sender: UIButton) {
        let url = URL(string: "demoapp://yuyue?name=byy&age=18")!
        if UIApplication.shared.canOpenURL(url) {
            print("can open")
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("cannot open")
        }
    }
    
    @IBAction func toAppStore(_ sender: UIButton) {
        let url = URL.init(string: "itms-apps://itunes.apple.com/cn/app/fu-dan-da-xue-fu-shu-hua-shan/id1058207084?mt=8")!
        if UIApplication.shared.canOpenURL(url) {
            print("can nav")
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("cannot nav")
        }
    }

}

