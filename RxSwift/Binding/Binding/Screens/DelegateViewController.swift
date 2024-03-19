//
//  DelegateViewController.swift
//  Binding
//
//  Created by 김민 on 2/6/24.
//

import UIKit
import SnapKit
import Then

class DelegateViewController: UIViewController {

    private let textField = UITextField().then {
        $0.borderStyle = .roundedRect
    }
    private let textLabel = UILabel()
    
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

        textField.delegate = self
    }

    @objc private func textFieldDidChange() {
        textLabel.text = textField.text
    }
}

extension DelegateViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, 
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        let finalText = (currentText as NSString).replacingCharacters(in: range, with: string)
        textLabel.text = finalText

        return true
    }
}
