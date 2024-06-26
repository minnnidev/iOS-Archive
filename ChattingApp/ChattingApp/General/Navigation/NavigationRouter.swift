//
//  NavigationRouter.swift
//  ChattingApp
//
//  Created by 김민 on 6/26/24.
//

import Foundation

class NavigationRouter: ObservableObject {

    @Published var destinations: [NavigationDestination] = []

    func push(to view: NavigationDestination) {
        destinations.append(view)
    }

    func pop() {
        _ = destinations.popLast()
    }

    func popToRootView() {
        destinations = []
    }
}
