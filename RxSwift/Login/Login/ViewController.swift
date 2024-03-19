//
//  ViewController.swift
//  Login
//
//  Created by 김민 on 3/17/24.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    let layoutView = LoginView()
    let viewModel = ViewModel()
    let disposeBag = DisposeBag()

    override func loadView() {
        self.view = layoutView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setBindings()
    }

    func setBindings() {
        layoutView.emailTextField.rx
            .text.orEmpty
            .bind(to: viewModel.emailObserver)
            .disposed(by: disposeBag)

        layoutView.pwTextField.rx
            .text.orEmpty
            .bind(to: viewModel.pwObserver)
            .disposed(by: disposeBag)

        viewModel.isEmailValid
            .map { $0 ? UIColor.systemBlue.cgColor : UIColor.systemRed.cgColor }
            .bind(to: layoutView.emailTextField.rx.borderColor)
            .disposed(by: disposeBag)

        viewModel.isPWValid
            .map { $0 ? UIColor.systemBlue.cgColor : UIColor.systemRed.cgColor }
            .bind(to: layoutView.pwTextField.rx.borderColor)
            .disposed(by: disposeBag)

        viewModel.isValid
            .map { $0 ? UIColor.black : UIColor.systemGray4 }
            .bind(to: layoutView.loginButton.rx.backgroundColor)
            .disposed(by: disposeBag)

        layoutView.loginButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.viewModel.login()
            })
            .disposed(by: disposeBag)
    }

    func presentAlert(_ title: String, _ message: String?) {
        let alertVC = UIAlertController(title: title,
                                        message: message,
                                        preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertVC.addAction(action)
        present(alertVC, animated: true)
    }
}

// borderColor bind를 위한 extension 추가
extension Reactive where Base: UIView {
    var borderColor: Binder<CGColor> {
        return Binder(self.base) { view, borderColor in
            view.layer.borderColor = borderColor
        }
    }
}
