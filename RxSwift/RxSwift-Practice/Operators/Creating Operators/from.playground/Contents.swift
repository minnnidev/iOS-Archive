import UIKit
import RxSwift

// from: 여러 데이터 타입을 Observable로 변환

let disposeBag = DisposeBag()

Observable.from([1, 2, 3, 4])
    .subscribe { event in
        print(event)
    }
    .disposed(by: disposeBag)

/*
 next(1)
 next(2)
 next(3)
 next(4)
 completed
 */
