//
//  HomeModalDestination.swift
//  ChattingApp
//
//  Created by 김민 on 6/23/24.
//

import Foundation

enum HomeModalDestination: Hashable, Identifiable {
    case myProfile
    case otherProfile(String)
    case setting

    var id: Int { hashValue }
}

