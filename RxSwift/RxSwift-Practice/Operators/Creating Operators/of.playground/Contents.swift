import UIKit
import RxSwift

// of: 여러 개의 항목을 방출하는 Observable을 생성

let disposeBag = DisposeBag()

Observable.of(1, 2, 3, 4)
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

Observable.of([1, 2], [3, 4])
    .subscribe { event in
        print(event)
    }
    .disposed(by: disposeBag)

/*
 next([1, 2])
 next([3, 4])
 completed
 */

Observable.of([1, 2, 3, 4])
    .subscribe { event in
        print(event)
    }
    .disposed(by: disposeBag)

/*
 next([1, 2, 3, 4])
 completed
 */
