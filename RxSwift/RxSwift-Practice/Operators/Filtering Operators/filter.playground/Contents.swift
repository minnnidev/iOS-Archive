import UIKit
import RxSwift

// filter: 조건을 통과하는 Observable의 요소만 방출

let disposeBag = DisposeBag()

Observable.from([1, 2, 3, 4, 5, 6])
    .filter { $0.isMultiple(of: 2) }
    .subscribe { event in
        print(event)
    }
    .disposed(by: disposeBag)

/*
 next(2)
 next(4)
 next(6)
 completed
 */
