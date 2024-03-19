import UIKit
import RxSwift

// Operators

let disposeBag = DisposeBag()

// filtering Operators
// 📌 filter
Observable.of(1, 2, 3)
    .filter { $0 >= 2 }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
/*
--- 출력 ---
 2
 3
 */

// 📌 skip
Observable.of(1, 2, 3, 4, 5, 6)
    .skip(2)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

/*
--- 출력 ---
 3
 4
 5
 6
 */

//// 📌 elementAt
Observable.of(1, 2, 3, 4, 5, 6)
    .element(at: 3)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

/*
--- 출력 ---
4
 */

// Transforming Operators
// 📌 scan
Observable.of(1, 2, 3, 4)
    .scan(Int()) { sum, elem in
        return sum + elem
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

/*
--- 출력 ---
 1
 3
 6
 10
 */

// 📌 map
Observable.of(1, 2, 3, 4)
    .map { $0 * 2 }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

/*
--- 출력 ---
 2
 4
 6
 8
 */

// Combining Operators
// 📌 startWith
Observable.of(1, 2)
    .startWith(-1, 0)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

/*
--- 출력 ---
 -1
 0
 1
 2
 */

// 📌 zip
let ob1 = Observable.of(1, 2)
let ob2 = Observable.of("a", "b", "c")
Observable.zip(ob1, ob2)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

/*
--- 출력 ---
 (1, "a")
 (2, "b")
 */

// 📌 merge
let ob3 = Observable.of(1, 2)
let ob4 = Observable.of(30, 40, 50)
Observable.merge(ob3, ob4)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

///*
//--- 출력 ---
// 1
// 30
// 2
// 40
// 50
// */

// 📌 reduce
Observable.of(1, 2, 3, 4, 5)
    .reduce(0) { sum, elem in
        return sum + elem
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

/*
--- 출력 ---
15
 */
