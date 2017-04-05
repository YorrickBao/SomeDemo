//
//  ViewController.swift
//  longscreenshot
//
//  Created by YorrickBao on 2017/4/1.
//  Copyright © 2017年 YorrickBao. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PHPhotoLibrary.requestAuthorization { (status) in
            print(status)
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize.height = 600
        
        let someview = [0, 100, 200, 300, 400, 500].map {UIView.init(frame: CGRect.init(x: 0, y: $0, width: 100, height: 100))}
        someview[0].backgroundColor = UIColor.red
        someview[1].backgroundColor = UIColor.yellow
        someview[2].backgroundColor = UIColor.blue
        someview[3].backgroundColor = UIColor.black
        someview[4].backgroundColor = UIColor.gray
        someview[5].backgroundColor = UIColor.green
        
        for v in someview {
            scrollView.addSubview(v)
        }
        
    }
    
    @IBAction func buttontapped(_ sender: Any) {
        let image = cutImageWith(scrollView!)
        writeImageToAlbum(image: image)
    }
    
    func cutImageWith(_ scrollView: UIScrollView) -> UIImage {
        let currentContentOffset = scrollView.contentOffset
        scrollView.contentOffset = CGPoint.zero
        
        let currentFrame = scrollView.frame
        scrollView.frame = CGRect(origin: .zero, size: scrollView.contentSize)
        
        
        UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, true, UIScreen.main.scale)
        
        scrollView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        
        scrollView.contentOffset = currentContentOffset
        scrollView.frame = currentFrame
        
        UIGraphicsEndImageContext()
        return image
    }
    
    func writeImageToAlbum(image:UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(image:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafeRawPointer) {
        if let e = error as NSError? {
            print(e)
        } else {
            print("保存成功")
            UIAlertController(title: nil, message: "保存成功！", preferredStyle: .alert).show(self, sender: nil)
        }
    }


}

