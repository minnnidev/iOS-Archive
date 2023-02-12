//
//  ViewController.swift
//  MoveViewWithKeyboard
//
//  Created by 김민 on 2023/02/09.
//

import UIKit

import SnapKit
import Then

class ViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let textField: UITextField = UITextField()
    private let bottomView: UIView = UIView()
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension ViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        view.backgroundColor = .white
        
        textField.do {
            $0.borderStyle = .line
            $0.placeholder = "내용 입력"
        }
        
        bottomView.do {
            $0.backgroundColor = .cyan
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        view.addSubview(textField)
        view.addSubview(bottomView)
        
        textField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
        }
        
        bottomView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
    }
    
    // MARK: - Methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - @objc Methods
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect) else { return }
        let height = keyboardFrame.size.height - view.safeAreaInsets.bottom
        bottomView.snp.updateConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-height)
        }
    }

    @objc private func keyboardWillHide(notification: Notification) {
        bottomView.snp.updateConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

//@objc private func keyboardWillShow(notification: Notification) {
//    guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect) else { return }
//    let height = keyboardFrame.size.height - view.safeAreaInsets.bottom
////        bottomView.snp.updateConstraints {
////            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-height)
////        }
//    bottomView.frame.origin.y -= height
//}
//
//@objc private func keyboardWillHide(notification: Notification) {
////        bottomView.snp.updateConstraints {
////            $0.bottom.equalTo(view.safeAreaLayoutGuide)
////        }
//    guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect) else { return }
//    let height = keyboardFrame.size.height - view.safeAreaInsets.bottom
//    bottomView.frame.origin.y += height
////}
