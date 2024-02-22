//
//  Service.swift
//  MVC-MVVM
//
//  Created by 김민 on 2/20/24.
//

import Foundation

// 앱의 핵심 비즈니스 로직
class Service {
    let repository = Repository()
    var currentTimeModel = Model()

    func fetchNow(completionHandler: @escaping (Model) -> ()) {
        // Entity 를 model로 map
        repository.fetchNow { [weak self] entity in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSX"

            guard let now = formatter.date(from: entity.utcDatetime) else { return }

            let model = Model(currentDateTime: now)
            self?.currentTimeModel = model
            completionHandler(model)
        }
    }


    func moveDay(day: Int) {
        guard let movedDay = Calendar.current.date(byAdding: .day,
                                                    value: day,
                                                   to: currentTimeModel.currentDateTime) else { return }
        currentTimeModel.currentDateTime = movedDay
    }
}
