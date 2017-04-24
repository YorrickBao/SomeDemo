//
//  Person.swift
//  ChartsDemo
//
//  Created by YorrickBao on 2017/4/24.
//  Copyright © 2017年 YorrickBao. All rights reserved.
//

import Foundation
import RealmSwift

class Person: Object {
    dynamic var name = "unnamed"
    dynamic var count = 0
    
    func save() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(self)
            }
        } catch let err as NSError {
            fatalError(err.localizedDescription)
        }
    }
}
