//
//  LoginView.swift
//  Login
//
//  Created by 김민 on 3/17/24.
//

import UIKit

class LoginView: UIView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Login valid check\nwith RxSwift"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 5
        tf.placeholder = "이메일을 입력해 주세요"
        return tf
    }()

    let pwTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 5
        tf.placeholder = "비밀번호를 입력해 주세요"
        return tf
    }()

    let loginButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("로그인", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 5
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setLayout() {
        [titleLabel, emailTextField, pwTextField, loginButton].forEach {
            addSubview($0)
        }

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])

        NSLayoutConstraint.activate([
            emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            emailTextField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20),
            emailTextField.heightAnchor.constraint(equalToConstant: 50)
        ])

        NSLayoutConstraint.activate([
            pwTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            pwTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            pwTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 12),
            pwTextField.heightAnchor.constraint(equalToConstant: 50)
        ])

        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            loginButton.topAnchor.constraint(equalTo: pwTextField.bottomAnchor, constant: 12),
            loginButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
