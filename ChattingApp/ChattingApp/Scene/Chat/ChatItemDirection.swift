//
//  ChatItemDirection.swift
//  ChattingApp
//
//  Created by 김민 on 6/26/24.
//

import Foundation
import SwiftUI

enum ChatItemDirection {
    case left
    case right

    var backgroundColor: Color {
        switch self {
        case .left:
            return Color.chatColorOther
        case .right:
            return Color.chatColorMe
        }
    }

    var overlayAlignment: Alignment {
        switch self {
        case .left:
            return .topLeading
        case .right:
            return .topTrailing
        }
    }

    var overlayImage: Image {
        switch self {
        case .left:
            return Image("bubble_tail-left")
        case .right:
            return Image("bubble_tail-right")
        }
    }
}
