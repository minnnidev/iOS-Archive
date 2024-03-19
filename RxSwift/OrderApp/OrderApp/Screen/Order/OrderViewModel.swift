//
//  OrderViewModel.swift
//  OrderApp
//
//  Created by 김민 on 3/13/24.
//

import Foundation
import RxSwift
import RxRelay

// view에 보여질 모델을 가공
class OrderViewModel {
    let menuItems: BehaviorRelay<[(menu: Menu, count: Int)]> = BehaviorRelay(value: [])
    var disposeBag = DisposeBag()

    init() {
        APIService.fetchMenus()
            .map { $0.map { ($0, 0) } }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.menuItems.accept($0)
            })
            .disposed(by: disposeBag)
    }

    lazy var itemsCount = menuItems.map {
        $0.map { $0.count }.reduce(0, +)
    }

    lazy var totalPrice = menuItems.map {
        $0.map { $0.count * $0.menu.price }.reduce(0, +)
    }

    func clearItems() {
        menuItems
            .map { $0.map { ($0.menu, 0) } }
            .observe(on:MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] in
                self?.menuItems.accept($0)
            })
            .disposed(by: disposeBag)
    }
}
