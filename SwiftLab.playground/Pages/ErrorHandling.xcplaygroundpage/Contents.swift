//: [Previous](@previous)

import Foundation

// custom 에러 정의
enum MyError: Error {
    case customError1
    case customError2
}

/*
 swift error handling 예시 - 은행 계좌
 계좌가 활성화되어 있는지, 잔액이 충분한지 에러 핸들링
*/

// Custom Error 정의
enum AccountError: Error {
    case accountInactive
    case insufficient
}

class BankAccount {
    var balance: Double
    var isActive: Bool

    init(initialBalance: Double, isActive: Bool) {
        self.balance = initialBalance
        self.isActive = isActive
    }

    // 인출하는 메소드
    func withdraw(amount: Double) throws {
        guard isActive else {
            throw AccountError.accountInactive
        }

        guard balance >= amount else {
            throw AccountError.insufficient
        }

        balance -= amount
        print("Withdrew \(amount). Remaining balance is \(balance).")
    }
}


let myAccount = BankAccount(initialBalance: 1000, isActive: true)
try! myAccount.withdraw(amount: 5000) // nil

//do {
//    try myAccount.withdraw(amount: 50000)
//} catch AccountError.accountInactive {
//    print("거래가 불가능한 계좌입니다." )
//} catch AccountError.insufficient {
//    print("잔액이 부족합니다.")
//}
//
