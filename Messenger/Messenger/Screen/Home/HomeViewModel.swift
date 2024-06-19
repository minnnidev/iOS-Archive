//
//  HomeViewModel.swift
//  Messenger
//
//  Created by 김민 on 6/19/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var myUser: User?
    @Published var users: [User] = [.stub1, .stub2]
}
