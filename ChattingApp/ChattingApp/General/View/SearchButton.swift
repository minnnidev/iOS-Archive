//
//  SearchButton.swift
//  ChattingApp
//
//  Created by 김민 on 6/26/24.
//

import SwiftUI

struct SearchButton: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.clear)
                .frame(height: 36)
                .background(Color.greyCool)
                .cornerRadius(5)

            HStack {
                Text("검색")
                    .font(.system(size: 12))
                    .foregroundStyle(Color.greyLightVer2)
                Spacer()
            }
            .padding(.leading, 20)
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    SearchButton()
}
