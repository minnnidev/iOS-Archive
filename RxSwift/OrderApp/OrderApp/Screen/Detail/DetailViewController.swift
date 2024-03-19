//
//  DetailViewController.swift
//  OrderApp
//
//  Created by 김민 on 3/6/24.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: BaseViewController<DetailView> {
    let orderedItems: BehaviorRelay<[(menu: Menu, count: Int)]> = BehaviorRelay(value: [])
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigation()
        setUpBindings()
    }

    func setUpBindings() {
        orderedItems
            .map { $0.map { "\($0.menu.name) \($0.count)개" }.joined(separator: "\n") }
            .bind(to: baseView.orderedItemsLabel.rx.text)
            .disposed(by: disposeBag)

        let itemsPriceAndVat = orderedItems
            .map { $0.map { $0.menu.price * $0.count}.reduce(0, +) }
            .map { (price: Int) -> (price: Int, vat: Int) in
                (price, Int(Float(price) * 0.1 / 10 + 0.5) * 10)
            }
            .share(replay: 1, scope: .whileConnected)

        // 주문한 아이템들의 가격
        itemsPriceAndVat
            .map { $0.price.currencyKR() }
            .bind(to: baseView.itemPriceLabel.rx.text)
            .disposed(by: disposeBag)

        // 주문한 아이템들의 vat
        itemsPriceAndVat
            .map { $0.vat.currencyKR() }
            .bind(to: baseView.vatPriceLabel.rx.text)
            .disposed(by: disposeBag)

        // 주문한 아이템들의 총합 가격
        itemsPriceAndVat
            .map { $0.price + $0.vat }
            .map { $0.currencyKR() }
            .bind(to: baseView.priceLabel.rx.text)
            .disposed(by: disposeBag)
    }

    func setNavigation() {
        navigationItem.title = "Receipt"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
