import UIKit
import RxSwift

let disposeBag = DisposeBag()

// 일반 Obsrvable
//let ob = Observable.create { emitter in
//    emitter.onNext("hello")
//    return Disposables.create()
//}
//
//ob.subscribe(onNext: {
//    print($0)
//})

/*
 --- 출력 ---
 hello
 */

// Subject
// ✅ PublishSubject
let sb = PublishSubject<String>()
sb.onNext("hi")

sb.subscribe(onNext: {
    print("첫 번째 구독", $0)
})
.disposed(by: disposeBag)

sb.onNext("1")
//
sb.subscribe(onNext: {
    print("두 번째 구독", $0)
})
.disposed(by: disposeBag)

sb.onNext("2")
sb.onNext("3")

sb.subscribe(onNext: {
    print("세 번째 구독", $0)
})
.disposed(by: disposeBag)

/*
 --- 출력 ---
 첫 번째 구독 1
 첫 번째 구독 2
 두 번째 구독 2
 첫 번째 구독 3
 두 번째 구독 3
 */

// ✅ BehaviorSubject
//let sb = BehaviorSubject(value: "default")
//
//sb.subscribe(onNext: {
//    print("첫 번째 구독", $0)
//})
//
//sb.onNext("2")
//
///*
// --- 출력 ---
// 첫 번째 구독 default
// 첫 번째 구독 2
// */

// ✅ AsyncSubject
//let sb = AsyncSubject<String>()
//sb.onNext("1")
//sb.onNext("2")
//sb.onCompleted()
//
//sb.subscribe(onNext: {
//    print("첫 번째 구독", $0)
//})
//
///*
// --- 출력 ---
// 첫 번째 구독 2
// */

// ✅ ReplaySubject
//let sb = ReplaySubject<String>.create(bufferSize: 3)
//sb.onNext("1")
//sb.onNext("2")
//sb.onNext("3")
//sb.onNext("4")
//
//sb.subscribe(onNext: {
//    print("첫 번째 구독", $0)
//})
//
//sb.onNext("5")
//
//sb.subscribe(onNext: {
//    print("두 번째 구독", $0)
//})


/*
 --- 출력 ---
 첫 번째 구독 2
 첫 번째 구독 3
 첫 번째 구독 4
 첫 번째 구독 5
 두 번째 구독 3
 두 번째 구독 4
 두 번째 구독 5
 */
