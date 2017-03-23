//
//  TopScrollView.swift
//  SlideNavBarDemo
//
//  Created by 鲍的Mac on 2016/11/14.
//  Copyright © 2016年 YorrickBao. All rights reserved.
//

import UIKit

protocol TopScrollViewDelegate: AnyObject {
    func scrollToView(_ index: Int)

}

class TopScrollView: UIScrollView {
    
    let nameArray = Array<String>.init(repeating: "2017-1-1", count: 15)// ["预约状态", "预约详情", "预约详情", "预约详情", "预约详情", "预约详情", "预约详情", "预约详情"]
    let shadowImageView: UIView
    
    weak var topScrollViewDelegate: TopScrollViewDelegate?
    
    var userSelectedChannelID = 100
    
    var initOffsetX: CGFloat {
        return max((bounds.width - (CGFloat(nameArray.count) * Const.buttonWidth)) / 2, 0)
    }
    
    struct Const {
        static let buttonWidth: CGFloat = 100.0
        static let buttonHeight: CGFloat = 44.0
        //static let buttonGap: CGFloat = 5.0
        private init(){}
    }
    
    required init?(coder aDecoder: NSCoder) {
        shadowImageView = UnderlineView(lineColor: .red, lineWidth: 2, margin: 5, frame: CGRect(x: 0, y: 0, width: Const.buttonWidth, height: Const.buttonHeight))
        super.init(coder: aDecoder)
        self.bounces = false
        self.isPagingEnabled = false
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.contentSize = CGSize(width: Const.buttonWidth * CGFloat(nameArray.count),
                                  height: self.bounds.height)
        initWithNameButtons()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        print("bounds.width: \(bounds.width)")
        print("initOffsetX: \(initOffsetX)")
        self.setContentOffset(CGPoint(x: -initOffsetX, y: 0), animated: false)
    }
    
    func initWithNameButtons() {
        self.addSubview(shadowImageView)
        for i in 0 ..< nameArray.count {
            let button = UIButton(type: UIButtonType.custom)
            button.frame = CGRect(x: Const.buttonWidth * CGFloat(i),
                                  y: 0.0,
                                  width: Const.buttonWidth,
                                  height: Const.buttonHeight)
            button.tag = i + 100
            if i == 0 {
                button.isSelected = true
            }
            button.setTitle(nameArray[i], for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            button.titleLabel?.textAlignment = .center
            button.setTitleColor(UIColor.red, for: .selected)
            button.setTitleColor(UIColor.black, for: .normal)
            button.addTarget(self, action: #selector(selectNameButton(_:)), for: .touchUpInside)
            self.addSubview(button)
        }
    }
    
    func selectNameButton(_ sender: UIButton) {
        selectNameButton(sender, isFromDelegate: false)
    }
    
    func selectNameButton(_ sender: UIButton, isFromDelegate: Bool) {
        self.adjustScrollViewContentX(sender)
        //如果更换按钮
        if sender.tag != userSelectedChannelID {
            //取之前的按钮
            let lastButton = self.viewWithTag(userSelectedChannelID) as! UIButton
            lastButton.isSelected = false
            //赋值按钮ID
            userSelectedChannelID = sender.tag
        }
        //按钮选中状态
        if !sender.isSelected {
            sender.isSelected = true
            //设置新闻页出现
            if !isFromDelegate {
                UIView.animate(withDuration: 0.25, animations: {
                    self.shadowImageView.frame.origin.x = sender.frame.origin.x
                })
                self.topScrollViewDelegate?.scrollToView(sender.tag - 100)
            }
        }
    }
    
    func adjustScrollViewContentX(_ sender: UIButton) {
        let offsetMin = CGFloat(0)
        let offsetMax = contentSize.width - bounds.width
        let btnCenterX = sender.frame.midX
        let offset = min(max(btnCenterX - bounds.width / 2, offsetMin), offsetMax)
        let point = CGPoint(x: initOffsetX + offset, y: 0)
        self.setContentOffset(point, animated: false)
    }

}

extension TopScrollView//: RootScrollViewDelegate
{
    func scrollToButtonWith(_ tag: Int) {
        let targetButton = viewWithTag(tag) as! UIButton
        self.selectNameButton(targetButton, isFromDelegate: true)
    }
    func shadowViewScrollTo(_ percent: CGFloat) {
        self.shadowImageView.frame.origin.x = self.contentSize.width * percent
    }
}
