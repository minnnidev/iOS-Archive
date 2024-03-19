//
//  ViewController.swift
//  JsonParsingToTV
//
//  Created by 김민 on 2/28/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

struct Avatar: Codable {
    let id: Int
    let name: String
    let avatar: String
    let job: String
    let age: Int
}

class ViewController: UIViewController {
    private let tableView = UITableView()

    private let disposeBag = DisposeBag()
    private var avatars = [Avatar]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
        setTV()

        view.backgroundColor = .white

        _ = fetchAvatars()
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] in
                self?.avatars = $0
                self?.tableView.reloadData()
            }
            .disposed(by: disposeBag)
    }

    private func setLayout() {
        view.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }

    private func setTV() {
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
    }


    private func fetchAvatars() -> Observable<[Avatar]> {
        let url = "https://my.api.mockaroo.com/members_with_avatar.json?key=44ce18f0"

        return Observable.create { emitter in
            let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
                guard error == nil else {
                    emitter.onError(error!)
                    return
                }

                guard let data = data,
                      let avatars = try? JSONDecoder().decode([Avatar].self, from: data) else {
                    emitter.onCompleted()
                    return
                }

                emitter.onNext(avatars)
                emitter.onCompleted()
            }

            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }
}


extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return avatars.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell else { return UITableViewCell() }
        cell.dataBind(avatars[indexPath.row])
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
