import UIKit
import RxSwift
import RxCocoa
import RxRelay

// RxSwift - Traits

let disposeBag = DisposeBag()

// 📌 Single
let ob1 = Observable.just("hello")
ob1.asSingle()
    .subscribe {
        print($0)
    } onFailure: { error in
        print(error)
    } onDisposed: {
        print("disposed")
    }
    .disposed(by: disposeBag)

/*
 ---- 출력 ----
hello
 */

//let ob1 = Observable.of("hello", "hi")
//ob1.asSingle()
//    .subscribe {
//        print($0)
//    } onFailure: { error in
//        print(error)
//    } onDisposed: {
//        print("disposed")
//    }
//    .disposed(by: disposeBag)

/*
 ---- 출력 ----
 Sequence contains more than one element. 🚨
 disposed
 */

// 📌 Completable
Completable.empty()
    .subscribe {
        print("completed")
    } onError: { error in
        print(error)
    } onDisposed: {
        print("disposed")
    }

Completable.empty()

/*
 ---- 출력 ----
 completed
 disposed
 */


//
// 📌 Maybe
let ob2 = Observable.just("maybe.. hi!")
            .asMaybe()
let sb2 = ob2.subscribe {
    print($0)
} onError: { error in
    print(error)
} onCompleted: {
    print("completed")
} onDisposed: {
    print("disposed")
}
sb2.disposed(by: disposeBag)

/*
 ---- 출력 ----
 maybe.. hi!
 disposed
 */

