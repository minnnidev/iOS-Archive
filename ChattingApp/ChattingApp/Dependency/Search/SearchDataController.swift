//
//  SearchDataController.swift
//  ChattingApp
//
//  Created by 김민 on 6/28/24.
//

import Foundation
import CoreData

protocol DataControllable {
    var persistantContainer: NSPersistentContainer { get set }
}

class SearchDataController: ObservableObject, DataControllable {

    var persistantContainer = NSPersistentContainer(name: "Search")

    init() {
        persistantContainer.loadPersistentStores { description, error in
            if let error {
                print("core data failed: ", error)
            }
        }
    }
}
