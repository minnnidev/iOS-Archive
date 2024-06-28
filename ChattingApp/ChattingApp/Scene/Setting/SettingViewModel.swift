//
//  SettingViewModel.swift
//  ChattingApp
//
//  Created by 김민 on 6/28/24.
//

import Foundation

class SettingViewModel: ObservableObject {

    @Published var sectionItems: [SectionItem] = []

    init() {
        self.sectionItems = [
            .init(label: "모드 설정", settings: AppearanceType.allCases.map { .init(item: $0) })
        ]
    }
}
