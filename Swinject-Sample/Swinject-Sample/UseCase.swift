//
//  UseCase.swift
//  Swinject-Sample
//
//  Created by 김민 on 7/2/24.
//

import Foundation

protocol UseCaseType {

}

class UseCase: UseCaseType {
    let repository: RepositoryType

    init(repository: RepositoryType) {
        self.repository = repository
    }
}

class StubUseCase: UseCaseType {

}
