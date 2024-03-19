import UIKit
import RxSwift
import RxRelay

/*
Relay - Subject that never complete
- 따라서 next event만 방출
- completed나 error event를 방출하지 않도록 보장되어 있어, UI 관련 작업에 좋음
- next event 추가 위해서는 onNext 대신 accept 사용
*/

let disposeBag = DisposeBag()

// 📌 PublishRelay
let pr = PublishRelay<String>()
pr.accept("elem1")
pr.subscribe(onNext: {
    print($0)
})
// nothing printed

pr.accept("elem2")
// elem2

// 📌 BehaviorRelay
let br = BehaviorRelay<String>(value: "elem3")
br.subscribe(onNext: {
    print($0)
})
// elem3

br.accept("elem4")
// elem4
