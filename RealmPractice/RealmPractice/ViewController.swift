//
//  ViewController.swift
//  RealmPractice
//
//  Created by 김민 on 4/10/24.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let realm = try! Realm()

        let dog = Dog()
        dog.name = "헤헤"
        dog.age = 1

        // create
        try! realm.write {
            realm.add(dog)
        }

        // read
        let dogs = realm.objects(Dog.self)
        print(dogs)

        // update(first)
        if let first = dogs.first {
            try! realm.write {
                first.name = "수정"
            }
        }

        // delete(first)
        if let first = dogs.first {
            try! realm.write {
                realm.delete(first)
            }
        }
    }

}

