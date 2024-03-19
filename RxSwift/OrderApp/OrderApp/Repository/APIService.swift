//
//  APIService.swift
//  OrderApp
//
//  Created by 김민 on 3/7/24.
//

import Foundation
import RxSwift

class APIService {

//    func fetchMenus(_ completionHander: @escaping (Menus) -> ()) {
//        let url = "https://firebasestorage.googleapis.com/v0/b/rxswiftin4hours.appspot.com/o/fried_menus.json?alt=media&token=42d5cb7e-8ec4-48f9-bf39-3049e796c936"
//        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
//            guard error == nil else { return }
//
//            guard let data = data,
//                  let _ = response as? HTTPURLResponse else { return }
//
//            guard let result = try? JSONDecoder().decode(Menus.self, from: data) else { return }
//            completionHander(result)
//        }
//        .resume()
//    }
    static func fetchMenus() -> Observable<[Menu]> {
        return Observable.create { emitter in
            let url = "https://firebasestorage.googleapis.com/v0/b/rxswiftin4hours.appspot.com/o/fried_menus.json?alt=media&token=42d5cb7e-8ec4-48f9-bf39-3049e796c936"
            let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
                guard error == nil else {
                    emitter.onError(error!)
                    return
                }

                guard let data = data,
                      let _ = response as? HTTPURLResponse else { return }

                guard let result = try? JSONDecoder().decode(Menus.self, from: data) else { return }

                emitter.onNext(result.menus)
                emitter.onCompleted()
            }

            task.resume()

            return Disposables.create { task.cancel() }
        }
    }
}
