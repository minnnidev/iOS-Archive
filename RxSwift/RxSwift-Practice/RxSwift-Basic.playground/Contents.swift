import UIKit
import RxSwift
import RxCocoa

/*
 메모리 leak을 피하기 위해서는 disposed 메소드를 사용해 줘야 함
 ex. sb1.disposed()
 하지만 이런식으로 각각의 subscription을 관리하는 것은 비효율적이므로,
 RxSwift는 dispose bag라는 것을 제공함.
 이 bag은 deallocated 되기 전에 disposed 메서드를 알아서 호출함.
 */
let disposeBag = DisposeBag()

// 📌 create
let obCreate = Observable.create { emitter in
    emitter.onNext("Hello")
    return Disposables.create {
        print("disposed")
    }
}

let sbCreate = obCreate.subscribe(onNext: {
    print($0)
})

// 📌 just operator
let ob1 = Observable.just("Hello!")
let sb1 = ob1.subscribe { word in
    print(word)
} onError: { error in
    print("error")
} onCompleted: {
    print("completed")
} onDisposed: {
    print("disposed")
}
 

//sb1.disposed()
//sb1.disposed(by: disposeBag)



/*
 ---- 출력 ----
 Hello!
 completed
 disposed
 */


// 📌 from operator
let ob2 = Observable.from([1, 2, 3])
_ = ob2.subscribe(onNext: {
    print($0)
})
.disposed(by: disposeBag)

/*
 ---- 출력 ----
1
2
3
 */

//// 📌 of operator
Observable.of("apple", "banana", "grape")
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

/*
 ---- 출력 ----
 apple
 banana
 grape
 */
