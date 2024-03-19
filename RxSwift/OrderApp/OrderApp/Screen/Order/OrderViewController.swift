//
//  ViewController.swift
//  OrderApp
//
//  Created by 김민 on 3/6/24.
//

import UIKit
import RxSwift
import RxCocoa

class OrderViewController: BaseViewController<OrderView> {
    var disposeBag = DisposeBag()
    let viewModel = OrderViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
        setTableView()
        setUpBindings()
    }

    func setUpBindings() {
        // 전체 메뉴 바인딩
        viewModel.menuItems
            .bind(to: baseView.tableView.rx.items(cellIdentifier: "ItemTableViewCell",
                                                  cellType: ItemTableViewCell.self)) 
        { idx, item, cell in
            cell.dataBind(item.menu, item.count)

                cell.onCountChanged = { [weak self] changedCnt in
                    guard let self = self else { return }

                    var cnt = item.count + changedCnt
                    if cnt < 0 { cnt = 0 }

                    var menus = self.viewModel.menuItems.value
                    menus[idx] = (item.menu, cnt)
                    self.viewModel.menuItems.accept(menus)
                }
            }
            .disposed(by: disposeBag)

        // 전체 선택 아이템 개수
        viewModel.itemsCount
            .map { "\($0) items" }
            .bind(to: baseView.itemCountLabel.rx.text)
            .disposed(by: disposeBag)

        // 선택 상품 total price
        viewModel.totalPrice
            .map { $0.currencyKR() }
            .bind(to: baseView.priceLabel.rx.text)
            .disposed(by: disposeBag)

        // 선택 제품 삭제
        baseView.clearButton.rx.tap
            .bind { [weak self] in
                self?.viewModel.clearItems()
            }
            .disposed(by: disposeBag)

        /*
         주문 버튼 눌렀을 때
         주문한 개수가 0개이면 alert 띄우기
         1개 이상이면 detailView로 이동
         */
        baseView.orderButton.rx.tap
            .withLatestFrom(viewModel.menuItems)
            .map { $0.map { $0.count }.reduce(0, +) }
            .do(onNext: { [weak self] totalCnt in
                if totalCnt <= 0 {
                    self?.showAlert("주문 실패", "아무것도 주문하지 않았습니다")
                }
            })
            .filter { $0 > 0 }
            .map { _ in }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.pushToDetailViewController()
            })
            .disposed(by: disposeBag)
    }

    func setNavigation() {
        navigationItem.title = "Bear Fired Center"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func setTableView() {
        baseView.tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: "ItemTableViewCell")
    }

    func showAlert(_ title: String?, _ message: String?) {
        let alertVC = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertVC, animated: true)
    }

    // MARK: - methods

    private func pushToDetailViewController() {
        let detailVC = DetailViewController()
        let orderedItems = viewModel.menuItems.value.filter { $0.count > 0 }
        detailVC.orderedItems.accept(orderedItems)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
