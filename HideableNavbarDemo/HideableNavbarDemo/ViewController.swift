//
//  ViewController.swift
//  HideableNavbarDemo
//
//  Created by 鲍的Mac on 2017/3/15.
//  Copyright © 2017年 YorrickBao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBarTintColor = .red
        self.navBarBgAlpha = 0
        tableView.delegate = self
        tableView.dataSource = self
        
    }




}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let imageView = UIImageView(image: #imageLiteral(resourceName: "doctor"))
        imageView.contentMode = .scaleAspectFill
        imageView.frame = cell.bounds
        cell.backgroundView = imageView
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let alpha = max(min((offset / 200), 1), 0)
        let newColor = offset > 200 ? UIColor.black : UIColor.red
        self.navBarBgAlpha = alpha
        self.navBarTintColor = newColor
    }
}

