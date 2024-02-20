//
//  MVCViewController.swift
//  MVC-MVVM
//
//  Created by 김민 on 2/20/24.
//

import UIKit

class MVCViewController: UIViewController {
    private let timeView = TimeView()

    private var currentDateTime = Date()

    override func viewDidLoad() {
        super.viewDidLoad()

        addTargets()
        fetchNow()
    }

    override func loadView() {
        self.view = timeView
    }

    // MARK: - Methods

    private func addTargets() {
        timeView.yesterdayButton.addTarget(self,
                                           action: #selector(tappedYesterdayButton),
                                           for: .touchUpInside)
        timeView.nowButton.addTarget(self,
                                     action: #selector(tappedNowButton),
                                     for: .touchUpInside)
        timeView.tomorrowButton.addTarget(self,
                                          action: #selector(tappedTomorrowButton),
                                          for: .touchUpInside)
    }

    private func updateDateTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
        timeView.dateTimeLabel.text = formatter.string(from: currentDateTime)
    }

    // MARK: - Network Methods

    private func fetchNow() {
        let url = "http://worldclockapi.com/api/json/utc/now"

        timeView.dateTimeLabel.text = "loading..."

        URLSession.shared.dataTask(with: URL(string: url)!) { [weak self] data, response, error in
            guard let data = data else { return }
            guard let model = try? JSONDecoder().decode(UtcTimeModel.self, from: data) else { return }

            // formatter 형식 설정
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm'Z'"

            // model의 currentDateTime을 변환
            guard let now = formatter.date(from: model.currentDateTime) else { return }

            self?.currentDateTime = now

            DispatchQueue.main.async { // UI 업데이트
                self?.updateDateTime()
            }
        }
        .resume()
    }

    // MARK: - @objc

    @objc private func tappedYesterdayButton() {
        guard let yesterday = Calendar.current.date(byAdding: .day,
                                                    value: -1,
                                                    to: currentDateTime) else {
            return
        }
        currentDateTime = yesterday
        updateDateTime()
    }

    @objc private func tappedNowButton() {
        fetchNow()
    }

    @objc private func tappedTomorrowButton() {
        guard let tomorrow = Calendar.current.date(byAdding: .day,
                                                    value: +1,
                                                    to: currentDateTime) else {
            return
        }
        currentDateTime = tomorrow
        updateDateTime()
    }
}

// MARK: - Model
struct UtcTimeModel: Codable {
    let id: String
    let currentDateTime: String
    let utcOffset: String
    let isDayLightSavingsTime: Bool
    let dayOfTheWeek: String
    let timeZoneName: String
    let currentFileTime: Int
    let ordinalDate: String
    let serviceResponse: String?

    enum CodingKeys: String, CodingKey {
        case id = "$id"
        case currentDateTime, utcOffset, isDayLightSavingsTime, dayOfTheWeek, timeZoneName, currentFileTime, ordinalDate, serviceResponse
    }
}

