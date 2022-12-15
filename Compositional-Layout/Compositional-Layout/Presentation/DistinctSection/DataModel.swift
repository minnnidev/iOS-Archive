//
//  ListModel.swift
//  Compositional-Layout
//
//  Created by 김민 on 2022/12/12.
//

import Foundation

struct ListModel: Hashable {
    let name: String
    let id = UUID().uuidString
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

let listData = [ListModel(name: "김애플"), ListModel(name: "이애플"), ListModel(name: "성애플"), ListModel(name: "최애플"), ListModel(name: "유애플"), ListModel(name: "배애플"), ListModel(name: "배애플")]

struct GridModel: Hashable {
    let name: String
    
    let id = UUID().uuidString
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

let gridOneData = [GridModel(name: "a"), GridModel(name: "asd"), GridModel(name: "zz"), GridModel(name: "zzz"), GridModel(name: "adfa"), GridModel(name: "sadfa"), GridModel(name: "afds"), GridModel(name: "asdf"), GridModel(name: "13jfkeds")]


let gridTwoData = [GridModel(name: "22"), GridModel(name: "233"), GridModel(name: "1234"), GridModel(name: "1432d"), GridModel(name: "afsd")]
