//
//  Todo.swift
//  RealmPractice
//
//  Created by 김민 on 4/10/24.
//

import Foundation
import RealmSwift

class Dog: Object {
    @Persisted var name: String
    @Persisted var age: Int
}
