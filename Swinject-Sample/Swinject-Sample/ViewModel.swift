//
//  ViewModel.swift
//  Swinject-Sample
//
//  Created by 김민 on 7/2/24.
//

import Foundation

class ViewModel: ObservableObject {
    let useCase: UseCaseType

    init(useCase: UseCaseType) {
        self.useCase = useCase
    }

    func hi() {
        print("hello")
    }
}
