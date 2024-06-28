//
//  DIContainer.swift
//  ChattingApp
//
//  Created by 김민 on 6/20/24.
//

import Foundation

class DIContainer: ObservableObject {
    var services: ServiceType
    var dataController: DataControllable
    var navigationRouter: NavigationRoutable & ObservableObjectSettable
    var appearanceController: AppearanceControllerType & ObservableObjectSettable

    init(
        services: ServiceType,
        dataController: DataControllable = SearchDataController(),
        navigationRouter: NavigationRoutable & ObservableObjectSettable = NavigationRouter(),
        appearanceController: AppearanceControllerType & ObservableObjectSettable = AppearanceController()
    ) {
        self.services = services
        self.dataController = dataController
        self.navigationRouter = navigationRouter
        self.appearanceController = appearanceController

        self.navigationRouter.setObjectWillChange(objectWillChange)
        self.appearanceController.setObjectWillChange(objectWillChange)
    }
}
