//
//  RxBindingViewController.swift
//  Binding
//
//  Created by 김민 on 2/6/24.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class RxBindingViewController: UIViewController {

    private let textField = UITextField().then {
        $0.borderStyle = .roundedRect
    }
    private let textLabel = UILabel()

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.addSubview(textField)
        view.addSubview(textLabel)

        textField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }

        textLabel.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }

        // binding
        textField.rx.text
            .bind(to: textLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
