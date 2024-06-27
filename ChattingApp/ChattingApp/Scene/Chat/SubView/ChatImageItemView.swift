//
//  ChatImageItemView.swift
//  ChattingApp
//
//  Created by 김민 on 6/27/24.
//

import SwiftUI

struct ChatImageItemView: View {
    let urlString: String
    let direction: ChatItemDirection

    var body: some View {
        HStack(alignment: .bottom) {
            if direction == .right {
                Spacer()
            }

            URLImageView(urlString: urlString)
                .frame(width: 146, height: 146)
                .clipShape(RoundedRectangle(cornerRadius: 10))

            if direction == .left {
                Spacer()
            }
        }
        .padding(.horizontal, 35)
        .padding(.bottom)
    }
}

#Preview {
    ChatImageItemView(urlString: "", direction: .right)
}
