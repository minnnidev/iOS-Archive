//
//  SettingView.swift
//  ChattingApp
//
//  Created by 김민 on 6/28/24.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var container: DIContainer
    @AppStorage(AppStorageType.appearance) var appearance: Int = UserDefaults.standard.integer(forKey: AppStorageType.appearance)
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: SettingViewModel

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.sectionItems) { section in
                    Section {
                        ForEach(section.settings) { setting in
                            Button {
                                if let a = setting.item as? AppearanceType {
                                    container.appearanceController.changeAppearance(a)
                                    appearance = a.rawValue
                                }
                            } label: {
                                Text(setting.item.label)
                                    .foregroundStyle(Color.bkText)
                            }
                        }
                    } header: {
                        Text(section.label)
                    }
                }
            }
            .navigationTitle("설정")
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Image("close_search")
                }
            }
        }
        .preferredColorScheme(container.appearanceController.appearance.colorScheme)
    }
}

#Preview {
    SettingView(viewModel: .init())
}
