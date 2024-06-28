//
//  AppearanceController.swift
//  ChattingApp
//
//  Created by 김민 on 6/28/24.
//

import SwiftUI
import Combine

protocol AppearanceControllerType {
    var appearance: AppearanceType { get set }

    func changeAppearance(_ willBeAppearance: AppearanceType?)
}

class AppearanceController: AppearanceControllerType, ObservableObjectSettable {

    var objectWiilChange: ObservableObjectPublisher?

    var appearance: AppearanceType = .automatic {
        didSet {
            objectWiilChange?.send()
        }
    }
    func changeAppearance(_ willBeAppearance: AppearanceType?) {
        appearance = willBeAppearance ?? .automatic
    }
}
