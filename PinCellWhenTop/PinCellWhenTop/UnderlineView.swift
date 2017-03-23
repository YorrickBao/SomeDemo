//
//  UnderlineView.swift
//  SlideNavBarDemo
//
//  Created by 鲍的Mac on 2016/11/14.
//  Copyright © 2016年 YorrickBao. All rights reserved.
//

import UIKit

class UnderlineView: UIView {

    var lineColor: UIColor
    var margin: CGFloat
    var lineWidth: CGFloat
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        let path = UIBezierPath()
        path.move(to: CGPoint(x: margin, y: bounds.height - 5))
        path.addLine(to: CGPoint(x: bounds.width - margin, y: bounds.height - 5))
        path.lineWidth = 2
        lineColor.setStroke()
        path.stroke()
    }
    fileprivate override init(frame: CGRect) {
        lineColor = UIColor.red
        lineWidth = 2
        margin = 5
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    fileprivate init() {
        lineColor = UIColor.red
        lineWidth = 2
        margin = 5
        super.init(frame: CGRect.zero)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UnderlineView {

    convenience init(lineColor: UIColor, lineWidth: CGFloat, margin: CGFloat, frame: CGRect) {
        self.init(frame: frame)
        self.lineColor = lineColor
        self.lineWidth = lineWidth
        self.margin = margin
        self.backgroundColor = UIColor.clear
    }
}
