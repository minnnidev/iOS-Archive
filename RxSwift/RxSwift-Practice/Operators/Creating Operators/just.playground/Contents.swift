import UIKit
import RxSwift

// just: 하나의 항목 방출

let disposeBag = DisposeBag()

Observable.just("hello")
    .subscribe { event in
        print(event)
    }
    .disposed(by: disposeBag)

/*
 next(hello)
 completed
 */

Observable.just([1, 2, 3, 4])
    .subscribe { event in
        print(event)
    }
    .disposed(by: disposeBag)

/*
next([1, 2, 3, 4])
completed
*/
