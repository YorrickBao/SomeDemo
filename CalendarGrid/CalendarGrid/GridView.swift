//
//  GridView.swift
//  GridView
//
//  Created by 鲍的Mac on 2017/1/12.
//  Copyright © 2017年 YorrickBao. All rights reserved.
//

import UIKit

protocol GridViewDelegate: class {
    func gridView(_ gridView: GridView, didTapCellAt indexPath: IndexPath)
}

protocol GridViewDataSource: class {
    var numberOfRow: Int { get }
    var numberOfCol: Int { get }
    func gridView(_ gridView: GridView, rowHeaderAt col: Int) -> UIView
    func gridView(_ gridView: GridView, colHeaderAt row: Int) -> UIView
    func gridView(_ gridView: GridView, cellAt indexPath: IndexPath) -> GridCell
}

enum GridCell {
    case empty
    case value(String, uiEnabled: Bool, backgroundColor: UIColor, textColor: UIColor)
}

@IBDesignable
class GridView: UIView {
    
    weak var delegate: GridViewDelegate?
    weak var dataSource: GridViewDataSource? {didSet{reloadData()}}
    
    private var labelArray: [(UIView, IndexPath)] = []
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor ?? UIColor.lightGray.cgColor)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    func reloadData() {
        guard let dataSource = dataSource else { return }
        
        subviews.forEach { $0.removeFromSuperview() }
        labelArray.removeAll()
        
        let group = DispatchGroup()
        
        let numberOfRow = dataSource.numberOfRow
        let numberOfCol = dataSource.numberOfCol
        
        // init grid
        let rowCount = max(numberOfRow, 0)
        let colCount = max(numberOfCol, 0)
        let cellWidth = bounds.width / CGFloat(colCount + 1)
        let cellHeight = bounds.height / CGFloat(rowCount + 1)
        
        let cell00 = UILabel(frame: CGRect(x: 0, y: 0, width: cellWidth, height: cellHeight))
        cell00.alpha = 0
        labelArray.append((cell00, IndexPath(row: 0, section: 0)))
        addSubview(cell00)
        
        for row in 0..<numberOfRow {
            for col in 0..<numberOfCol {
                group.enter()
                DispatchQueue.main.async { [weak self] in
                    defer { group.leave() }
                    guard let strongSelf = self else { return }
                    let indexPath = IndexPath(row: row + 1, section: col + 1)
                    let x = CGFloat(col + 1) * cellWidth
                    let y = CGFloat(row + 1) * cellHeight
                    let label = UILabel(frame: CGRect(x: x, y: y, width: cellWidth, height: cellHeight))
                    let cell = dataSource.gridView(strongSelf, cellAt: indexPath)
                    switch cell {
                    case .empty: break
                    case let .value(val, enabled, backgroundColor, textColor):
                        label.text = val
                        label.textAlignment = .center
                        label.adjustsFontSizeToFitWidth = true
                        label.textColor = textColor
                        label.backgroundColor = backgroundColor
                        label.isUserInteractionEnabled = enabled
                        label.addGestureRecognizer(UITapGestureRecognizer(target: strongSelf, action: #selector(strongSelf.tapped)))
                    }
                    label.layer.masksToBounds = true
                    label.alpha = 0
                    strongSelf.labelArray.append((label, indexPath))
                    strongSelf.addSubview(label)
                }
            }
        }
        
        //init row header
        for col in 0..<numberOfCol {
            group.enter()
            DispatchQueue.main.async { [weak self] in
                defer { group.leave() }
                guard let strongSelf = self else { return }
                let x = CGFloat(col + 1) * cellWidth
                let header = dataSource.gridView(strongSelf, rowHeaderAt: col)
                header.frame = CGRect(x: x, y: 0, width: cellWidth, height: cellHeight)
                header.alpha = 0
                strongSelf.labelArray.append((header, IndexPath(row: 0, section: col + 1)))
                strongSelf.addSubview(header)
            }
        }
        
        //init col header
        for row in 0..<numberOfRow {
            group.enter()
            DispatchQueue.main.async {[weak self] in
                defer { group.leave() }
                guard let strongSelf = self else { return }
                let y = CGFloat(row + 1) * cellHeight
                let header = dataSource.gridView(strongSelf, colHeaderAt: row)
                header.frame = CGRect(x: 0, y: y, width: cellWidth, height: cellHeight)
                header.alpha = 0
                strongSelf.labelArray.append((header, IndexPath(row: row + 1, section: 0)))
                strongSelf.addSubview(header)
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.setupBorder()
            self?.setupAutoLayout()
            UIView.animate(withDuration: 0.1) {
                self?.labelArray.forEach {$0.0.alpha = 1}
            }
        }
        
    }
    
    func setupBorder() {
        let width = borderWidth * 0.5
        let color = borderColor
        labelArray.forEach {
            $0.0.layer.borderWidth = width
            $0.0.layer.borderColor = color.cgColor
        }
    }
    
    func setupAutoLayout() {
        
        var viewMap = [String : UIView]()
        for (label, indexPath) in labelArray {
            viewMap["cell\(indexPath.row)_\(indexPath.section)"] = label
        }
        viewMap.values.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        guard let max = (labelArray.map{$0.1}.max()) else { return }
        
        //逐行 水平间距 等宽
        for row in 0...max.row {
            let format = "|-0-" + (0...max.section).map {"[cell\(row)_\($0)\($0 == 0 ? "" : "(==cell\(row)_0)")]"}.joined(separator: "-0-") + "-0-|"
            let constraints = NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: nil, views: viewMap)
            NSLayoutConstraint.activate(constraints)
        }
        
        //逐列 垂直间距 等高
        for col in 0...max.section {
            let format = "V:|-0-" + (0...max.row).map {"[cell\($0)_\(col)\($0 == 0 ? "" : "(==cell0_\(col))")]"}.joined(separator: "-0-") + "-0-|"
            let constraints = NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: nil, views: viewMap)
            NSLayoutConstraint.activate(constraints)
        }

        needsUpdateConstraints()
    }

    @objc private func tapped(_ sender: UITapGestureRecognizer) {
        for (label, index) in labelArray {
            if label.frame.contains(sender.location(in: self)) {
                delegate?.gridView(self, didTapCellAt: index.minus(1, 1))
                return
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

fileprivate extension IndexPath {
    func minus(_ _row: Int, _ _col: Int) -> IndexPath {
        return IndexPath(row: row - _row, section: section - _col)
    }
}
