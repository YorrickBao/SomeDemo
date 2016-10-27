//
//  People+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by 鲍的Mac on 2016/10/19.
//  Copyright © 2016年 YorrickBao. All rights reserved.
//

import Foundation
import CoreData


extension People {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<People> {
        return NSFetchRequest<People>(entityName: "People");
    }

    @NSManaged public var name: String?
    
}
