//
//  ViewModel.swift
//  MVC-MVVM
//
//  Created by 김민 on 2/20/24.
//

import Foundation

// model을 view에 보여질 형태로 변경하는 로직이 추가됨
class ViewModel {

    // 실제로 화면에서 보여줘야 할 값은 dateTime뿐
    var dateTime: String = "Loading..." {
        didSet {
            onUpdated()
        }
    }
    var onUpdated: () -> () = {}
    let service = Service()

    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
        return formatter.string(from: date)
    }

    // model -> viewModel (모델을 화면을 위한 뷰모델로)
    func loadCurrentTime() {
        service.fetchNow { [weak self] model in
            guard let self = self else { return }
            let dateString = self.dateToString(date: model.currentDateTime)
            self.dateTime = dateString
        }
    }

    func moveDay(_ day: Int) {
        service.moveDay(day: day)
        dateTime = dateToString(date: service.currentTimeModel.currentDateTime)
    }
}
