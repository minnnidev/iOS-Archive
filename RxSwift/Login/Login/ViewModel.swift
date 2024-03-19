//
//  ViewModel.swift
//  Login
//
//  Created by 김민 on 3/17/24.
//

import Foundation
import RxSwift
import RxRelay

class ViewModel {
    let emailObserver = PublishRelay<String>()
    let pwObserver = PublishRelay<String>()

    // 이메일 형식 체크
    var isEmailValid: Observable<Bool> {
        return emailObserver
            .map { email in
                let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
                let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
                return emailPred.evaluate(with: email)
            }
    }

    // 대문자 하나 이상, 소문자 하나 이상, 숫자 하나 이상, 8자 이상 비밀번호 유효성 체크
    var isPWValid: Observable<Bool> {
        return pwObserver
            .map { pw in
                let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8,}$"
                    let pwPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
                return pwPred.evaluate(with: pw)
            }
    }

    var isValid: Observable<Bool> {
        return Observable
            .combineLatest(isEmailValid, isPWValid)
            .map { $0 && $1 }
            .startWith(false)
    }

    func login() {
        // email, login model 사용하여 통신하기
    }
}
