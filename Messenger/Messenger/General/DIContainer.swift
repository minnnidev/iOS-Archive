//
//  DIContainer.swift
//  Messenger
//
//  Created by 김민 on 6/19/24.
//

import Foundation

class DIContainer: ObservableObject {
    var services: ServiceType

    init(services: ServiceType) {
        self.services = services
    }
}
