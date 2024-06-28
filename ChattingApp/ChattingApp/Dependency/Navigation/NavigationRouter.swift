//
//  NavigationRouter.swift
//  ChattingApp
//
//  Created by 김민 on 6/26/24.
//

import Foundation
import Combine

protocol NavigationRoutable {
    var destinations: [NavigationDestination] { get set }

    func push(to view: NavigationDestination)
    func pop()
    func popToRootView()
}

class NavigationRouter: NavigationRoutable, ObservableObjectSettable {

    var objectWiilChange: ObservableObjectPublisher?

    var destinations: [NavigationDestination] = [] {
        didSet {
            objectWiilChange?.send()
        }
    }

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
