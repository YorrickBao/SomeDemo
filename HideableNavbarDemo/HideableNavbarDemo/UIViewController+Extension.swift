//
//  UIViewController+Extension.swift
//  HideableNavbarDemo
//
//  Created by 鲍的Mac on 2017/3/15.
//  Copyright © 2017年 YorrickBao. All rights reserved.
//

import UIKit

extension UIViewController {
    
    fileprivate struct AssociatedKeys {
        static var navBarBgAlpha: CGFloat = 1.0
        static var navBarTintColor: UIColor = .black
    }
    
    var navBarBgAlpha: CGFloat {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.navBarBgAlpha) as? CGFloat ?? 1.0
        }
        set {
            let alpha = max(min(newValue, 1), 0)

            objc_setAssociatedObject(self, &AssociatedKeys.navBarBgAlpha, alpha, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            //设置导航栏透明度
            navigationController?.setNeedsNavigationBackground(alpha: alpha)
        }
    }
    
    var navBarTintColor: UIColor {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.navBarTintColor) as? UIColor ?? .black
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.navBarTintColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            navigationController?.navigationBar.tintColor = newValue
            navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: newValue]
        }
    }
}

extension UIViewController {
    open override class func initialize() {
        if self == UIViewController.self {
            let originalMethod1 = class_getInstanceMethod(self, #selector(UIViewController.viewDidLoad))
            let swizzledMethod1 = class_getInstanceMethod(self, #selector(UIViewController.aop_viewDidLoad))
            let originalMethod2 = class_getInstanceMethod(self, #selector(UIViewController.viewWillAppear(_:)))
            let swizzledMethod2 = class_getInstanceMethod(self, #selector(UIViewController.aop_viewWillAppear(_:)))
            let originalMethod3 = class_getInstanceMethod(self, #selector(UIViewController.viewDidAppear(_:)))
            let swizzledMethod3 = class_getInstanceMethod(self, #selector(UIViewController.aop_viewDidAppear(_:)))
            let originalMethod4 = class_getInstanceMethod(self, #selector(UIViewController.viewWillDisappear(_:)))
            let swizzledMethod4 = class_getInstanceMethod(self, #selector(UIViewController.aop_viewWillDisappear(_:)))
            let originalMethod5 = class_getInstanceMethod(self, #selector(UIViewController.viewDidDisappear(_:)))
            let swizzledMethod5 = class_getInstanceMethod(self, #selector(UIViewController.aop_viewDidDisappear(_:)))
            method_exchangeImplementations(originalMethod1, swizzledMethod1)
            method_exchangeImplementations(originalMethod2, swizzledMethod2)
            method_exchangeImplementations(originalMethod3, swizzledMethod3)
            method_exchangeImplementations(originalMethod4, swizzledMethod4)
            method_exchangeImplementations(originalMethod5, swizzledMethod5)
        }
    }
    
    func aop_viewDidLoad() {
        self.aop_viewDidLoad()
        print("aop_viewDidLoad")
    }
    
    func aop_viewWillAppear(_ animated: Bool) {
        self.aop_viewWillAppear(animated)
        print("aop_viewWillAppear \(animated)")
    }
    
    func aop_viewDidAppear(_ animated: Bool) {
        self.aop_viewDidAppear(animated)
        print("aop_viewDidAppear \(animated)")
    }
    
    func aop_viewWillDisappear(_ animated: Bool) {
        self.aop_viewWillDisappear(animated)
        print("aop_viewWillDisappear \(animated)")
    }
    
    func aop_viewDidDisappear(_ animated: Bool) {
        self.aop_viewDidDisappear(animated)
        print("aop_viewDidDisappear \(animated)")
    }
}

//MARK:- UINavigationController

extension UINavigationController {
    //Some other code
    fileprivate func setNeedsNavigationBackground(alpha:CGFloat) {
        let barBgView = navigationBar.value(forKey: "_barBackgroundView") as AnyObject
        let bgImageView = barBgView.value(forKey: "_backgroundImageView") as? UIImageView
        if navigationBar.isTranslucent && bgImageView?.image == nil {
            (barBgView.value(forKey: "_backgroundEffectView") as? UIView)?.alpha = alpha
        } else {
            (barBgView as? UIView)?.alpha = alpha
        }
        (barBgView.value(forKey: "_shadowView") as? UIView)?.alpha = alpha
    }
    
    open override class func initialize(){
        
        if self == UINavigationController.self {
            let originalSelectorArr = ["_updateInteractiveTransition:"]
            //method swizzling
            for ori in originalSelectorArr {
                print(ori)
                let originalSelector = NSSelectorFromString(ori)
                let swizzledSelector = NSSelectorFromString("et_\(ori)")
                let originalMethod = class_getInstanceMethod(self.classForCoder(), originalSelector)
                let swizzledMethod = class_getInstanceMethod(self.classForCoder(), swizzledSelector)
                method_exchangeImplementations(originalMethod, swizzledMethod)
            }
        }
    }
    
    func et__updateInteractiveTransition(_ percentComplete: CGFloat) {
        et__updateInteractiveTransition(percentComplete)
        
        guard let topVC = self.topViewController else { return }
        //transitionCoordinator带有两个VC的转场上下文
        guard let coor = topVC.transitionCoordinator else { return }
        //fromVC 的导航栏透明度
        let fromAlpha = coor.viewController(forKey: .from)?.navBarBgAlpha
        //toVC 的导航栏透明度
        let toAlpha = coor.viewController(forKey: .to)?.navBarBgAlpha
        //计算当前的导航栏透明度
        let nowAlpha = fromAlpha! + (toAlpha! - fromAlpha!) * percentComplete
        //设置导航栏透明度
        self.setNeedsNavigationBackground(alpha: nowAlpha)
        
        let toColor = coor.viewController(forKey: .to)?.navBarTintColor ?? .black
        let fromColor = coor.viewController(forKey: .from)?.navBarTintColor ?? .black
        let targetColor = percentComplete > 0.5 ? toColor : fromColor
        
        self.navigationBar.tintColor = targetColor
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: targetColor]
        
    }
}

extension UINavigationController: UINavigationBarDelegate {
    
    func handlePop() {
        guard let coor = topViewController?.transitionCoordinator else { return }
        
        //添加对返回交互的监控
        if #available(iOS 10.0, *) {
            coor.notifyWhenInteractionChanges { context in
                self.dealInteractionChanges(context)
            }
        } else {
            coor.notifyWhenInteractionEnds { context in
                self.dealInteractionChanges(context)
            }
        }
    }
    
    //处理返回手势中断对情况
    private func dealInteractionChanges(_ context: UIViewControllerTransitionCoordinatorContext) {
        var duration = context.transitionDuration
        if context.isCancelled {
            //自动取消了返回手势
            let nowAlpha = context.viewController(forKey: .from)?.navBarBgAlpha ?? 1.0
            let targetColor = context.viewController(forKey: .from)?.navBarTintColor ?? .black
            duration *= TimeInterval(context.percentComplete)
            UIView.animate(withDuration: duration) {
                self.setNeedsNavigationBackground(alpha: nowAlpha)
                self.navigationBar.tintColor = targetColor
                self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: targetColor]
            }
        } else {
            //自动完成了返回手势
            let nowAlpha = context.viewController(forKey: .to)?.navBarBgAlpha ?? 1.0
            let targetColor = context.viewController(forKey: .to)?.navBarTintColor ?? .black
            duration *= TimeInterval(1 - context.percentComplete)
            UIView.animate(withDuration: duration) {
                self.setNeedsNavigationBackground(alpha: nowAlpha)
                self.navigationBar.tintColor = targetColor
                self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: targetColor]
            }
        }
    }
    
    public func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        handlePop()
        if viewControllers.count >= navigationBar.items!.count {
            //点击返回按钮
            let popToVC = viewControllers[viewControllers.count - 2]
            setNeedsNavigationBackground(alpha: popToVC.navBarBgAlpha)
            navigationBar.tintColor = popToVC.navBarTintColor
            navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: popToVC.navBarTintColor]
            _ = self.popViewController(animated: true)
        }
        return true
    }
    
    public func navigationBar(_ navigationBar: UINavigationBar, shouldPush item: UINavigationItem) -> Bool {
        //push到一个新界面
        setNeedsNavigationBackground(alpha: topViewController?.navBarBgAlpha ?? 1.0)
        navigationBar.tintColor = topViewController?.navBarTintColor ?? .black
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: topViewController?.navBarTintColor ?? .black]
        return true
    }
    
}

extension UIViewController {
    
}
