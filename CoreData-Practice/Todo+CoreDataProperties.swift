//
//  Todo+CoreDataProperties.swift
//  CoreData-Practice
//
//  Created by 김민 on 4/8/24.
//
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var isDone: Bool
    @NSManaged public var title: String?

}

extension Todo : Identifiable {

}
