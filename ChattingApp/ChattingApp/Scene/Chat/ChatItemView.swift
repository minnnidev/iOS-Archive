//
//  ChatItemView.swift
//  ChattingApp
//
//  Created by 김민 on 6/26/24.
//

import SwiftUI

struct ChatItemView: View {
    let message: String
    let direction: ChatItemDirection
    let date: Date

    var body: some View {
        HStack(alignment: .bottom) {
            if direction == .right {
                Spacer()
                dateView
            }

            Text(message)
                .font(.system(size: 14))
                .foregroundStyle(Color.bkText)
                .padding(.vertical, 9)
                .padding(.horizontal, 20)
                .background(direction.backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .overlay(alignment: direction.overlayAlignment) {
                    direction.overlayImage
                }

            if direction == .left {
                dateView
                Spacer()
            }
        }
        .padding(.horizontal, 35)
        .padding(.bottom)
    }

    private var dateView: some View {
        Text(date.toChatTime)
            .font(.system(size: 10))
            .foregroundStyle(Color.greyDeep)
    }
}

#Preview {
    VStack {
        ChatItemView(message: "메세지예용", direction: .right, date: Date())
        ChatItemView(message: "메세지예용", direction: .left, date: Date())
    }
}
