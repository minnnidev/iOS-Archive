//
//  Repository.swift
//  MVC-MVVM
//
//  Created by 김민 on 2/20/24.
//

import Foundation

// Entity를 가져오는 역할
class Repository {

    func fetchNow(completionHandler: @escaping (UtcTimeModel) -> ()) {
        let url = "http://worldtimeapi.org/api/timezone/Asia/Seoul"

        URLSession.shared.dataTask(with: URL(string: url)!) { data, _, _ in
            guard let data = data else { return }
            guard let model = try? JSONDecoder().decode(UtcTimeModel.self, from: data) else { return }
            completionHandler(model)
        }
        .resume()
    }
}
