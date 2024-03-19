import UIKit
import RxSwift

Completable.empty()
    .debug("completable")
    .subscribe {
        print("completed")
    } onError: { error in
        print(error)
    } onDisposed: {
        print("disposed")
    }
    .disposed(by: DisposeBag())

