import UIKit
import RxSwift

struct Joke: Codable {
    let type: String
    let setup: String
    let punchline: String
    let id: Int
}

enum NetworkError: Error {
    case decodingError
    case serverError
    case commonError
}

let disposeBag = DisposeBag()

// Single
func getQuotes() -> Single<String> {
    return Single.create { single in
        let task = URLSession.shared.dataTask(with: URL(string: "https://official-joke-api.appspot.com/jokes/random")!) { data, response, error in
            if let error = error {
                single(.failure(error))
                return
            }
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                single(.failure(NetworkError.serverError))
                return
            }

            do {
                let result = try JSONDecoder().decode(Joke.self, from: data)
                single(.success(result.punchline))
            } catch {
                single(.failure(NetworkError.decodingError))
            }
        }

        task.resume()

        return Disposables.create {
            task.cancel()
        }
    }
}

getQuotes()
    .subscribe { event in
        switch event {
        case .success(let joke):
            print("🤣", joke) // 🤣 Because he didn't get arrays.
        case .failure(_):
            print("error")
        }
    }
    .disposed(by: disposeBag)

// 출력: 🤣 Because he didn't get arrays.

func generateString() -> Maybe<String> {
    return Maybe<String>.create { maybe in
        maybe(.success("Hello"))
        maybe(.completed)
        maybe(.error(NetworkError.commonError))
        return Disposables.create()
    }
}
let maybe = Maybe<String>.create { maybe in
    maybe(.success("Hello"))
//    maybe(.completed)
//    maybe(.error(NetworkError.commonError))
    return Disposables.create()
}

maybe
    .subscribe { maybe in
        switch maybe {
        case .success(let word):
            print(word)
        case .error(_):
            print("🚨 Error")
        case .completed:
            print("☑️ Completed")
        }
    }
    .disposed(by: disposeBag)
