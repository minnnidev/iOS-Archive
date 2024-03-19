//
//  TableViewCell.swift
//  JsonParsingToTV
//
//  Created by 김민 on 2/28/24.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class TableViewCell: UITableViewCell {
    private let nameLabel = UILabel()
    private var avatarImage = UIImageView()
    private let jobLabel = UILabel()
    private let ageLabel = UILabel()

    let disposeBag = DisposeBag()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setLayout() {
        [nameLabel, avatarImage, jobLabel, ageLabel].forEach {
            addSubview($0)
        }

        avatarImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(50)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(avatarImage.snp.top)
            $0.leading.equalTo(avatarImage.snp.trailing).offset(15)
        }

        ageLabel.snp.makeConstraints {
            $0.bottom.equalTo(avatarImage.snp.bottom)
            $0.leading.equalTo(nameLabel)
        }

        jobLabel.snp.makeConstraints {
            $0.bottom.equalTo(ageLabel)
            $0.leading.equalTo(ageLabel.snp.trailing).offset(15)
        }
    }

    func dataBind(_ avatar: Avatar) {
//        loadImage(for: avatar.avatar)
//            .observe(on: MainScheduler.instance)
//            .subscribe(onNext: { [weak self] in
//                self?.avatarImage.image = $0
//            })
//            .disposed(by: disposeBag)

        // bind를 통해 observeOn 메인스케쥴러와 구독하여 컴포넌트에 바인딩하기가 한번에 가능하다.
        loadImage(for: avatar.avatar)
            .bind(to: avatarImage.rx.image)
            .disposed(by: disposeBag)

        nameLabel.text = avatar.name
        jobLabel.text = avatar.job
        ageLabel.text = "\(avatar.age)"
    }

    private func loadImage(for url: String) -> Observable<UIImage?> {
        return Observable.create { emitter in
            let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, _, error in
                guard error == nil else {
                    emitter.onError(error!)
                    return
                }

                guard let data = data,
                      let image = UIImage(data: data) else {
                    emitter.onNext(nil)
                    emitter.onCompleted()
                    return
                }

                emitter.onNext(image)
                emitter.onCompleted()
            }

            task.resume()

            return Disposables.create() {
                task.cancel()
            }
        }
    }
}
