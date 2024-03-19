import UIKit
import RxSwift

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

let greetings = PublishSubject<String>()
let languages = PublishSubject<String>()

Observable.combineLatest(greetings, languages) { lhs, rhs -> String in
    return "\(lhs) \(rhs)"
}
.subscribe { print($0) }
.disposed(by: disposeBag)

greetings.onNext("Hello")
// languages subject가 이벤트를 전달받지 못함 -> subscriber에게 전달되는 이벤트 없음
// 출력 없음
languages.onNext("World!")
// next(Hello World!)

greetings.onNext("Hi")
// next(Hi World!)
languages.onNext("RxSwift...")
// next(Hi RxSwift...)

//greetings.onCompleted()
// languages에 completed event가 전달되지 않음 -> subscriber에게 completed 이벤트 전달되지 않음
greetings.onError(MyError.error)
// error 이벤트 전달 시 subscriber에게 error 이벤트 전달 후 종료
languages.onNext("Swift")
// next(Hi Swift) 가장 최근에 방출된 항목과 결합

languages.onCompleted()
// 모든 Observable이 completed 이벤트를 전달하면, subscriber에게 completed 이벤트 전달
