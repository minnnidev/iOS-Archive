//
//  ViewModel.swift
//  ViewModel_Actions
//
//  Created by 김민 on 6/19/24.
//

import Foundation

class ViewModel: ObservableObject {
    
    enum Action {
        case add
        case delete
    }

    func send(_ action: Action) {
        switch action {
        case .add:
            print("add action")
        case .delete:
            print("delete action")
        }
    }
}
