//
//  ObservableObjectSettable.swift
//  ChattingApp
//
//  Created by 김민 on 6/28/24.
//

import SwiftUI
import Combine

protocol ObservableObjectSettable: AnyObject {
    var objectWiilChange: ObservableObjectPublisher? { get set }

    func setObjectWillChange(_ objectWillChange: ObservableObjectPublisher)
}

extension ObservableObjectSettable {

    func setObjectWillChange(_ objectWillChange: ObservableObjectPublisher) {
        self.objectWiilChange = objectWillChange
    }
}
