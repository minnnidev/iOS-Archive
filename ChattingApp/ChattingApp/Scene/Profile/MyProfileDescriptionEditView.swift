//
//  MyProfileDescriptionEditView.swift
//  ChattingApp
//
//  Created by 김민 on 6/26/24.
//

import SwiftUI

struct MyProfileDescriptionEditView: View {
    @Environment(\.dismiss) var dismiss

    @State var description: String

    var onCompleted: (String) -> Void

    var body: some View {
        NavigationStack {
            VStack {
                TextField("상태 메세지를 입력해 주세요", text: $description)
                    .multilineTextAlignment(.center)
            }
            .toolbar {
                Button {
                    dismiss()
                    onCompleted(description)
                } label: {
                    Text("완료")
                }
                .disabled(description.isEmpty)
            }
        }
    }
}

#Preview {
    MyProfileDescriptionEditView(description: "") { _ in

    }
}
