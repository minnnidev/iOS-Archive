//
//  ChatView.swift
//  ChattingApp
//
//  Created by 김민 on 6/26/24.
//

import SwiftUI

struct ChatView: View {
    @EnvironmentObject var navigationRouter: NavigationRouter
    @StateObject var viewModel: ChatViewModel
    @FocusState private var isFocused: Bool

    var body: some View {
        ScrollView {
            if viewModel.chatDataList.isEmpty {
                Color.chatBg
            } else {
                contentView
            }
        }
        .background(Color.chatBg)
        .navigationBarBackButtonHidden()
        .toolbarBackground(Color.chatBg, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    navigationRouter.pop()
                } label: {
                    Image("back")
                }

                Text(viewModel.otherUser?.name ?? "대화방 이름")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(Color.bkText)
            }

            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Image("search_chat")
                Image("bookmark")
                Image("settings")
            }
        }
        .keyboardToolbar(height: 50) {
            HStack(spacing: 10) {
                Button {
                } label: {
                    Image("other_add", label: Text("더보기"))
                }

                Button {
                } label: {
                    Image("image_add", label: Text("사진첨부"))
                }

                Button {
                } label: {
                    Image("photo_camera", label: Text("카메라"))
                }

                TextField("", text: $viewModel.message)
                    .font(.system(size: 16))
                    .foregroundStyle(Color.bkText)
                    .focused($isFocused)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 13)
                    .background(Color.greyCool)
                    .cornerRadius(20)

                Button {
                    viewModel.send(action: .addChat(viewModel.message))
                    isFocused = false
                } label: {
                    Image("send")
                }
                .disabled(viewModel.message.isEmpty)
            }
            .padding(.horizontal, 27)
        }
        .onAppear {
            viewModel.send(action: .load)
        }
    }

    private var contentView: some View {
        ForEach(viewModel.chatDataList) { chatData in
            Section {
                ForEach(chatData.chats) { chat in
                    ChatItemView(
                        message: chat.message ?? "",
                        direction: viewModel.getDirection(id: chat.userId),
                        date: chat.date
                    )
                }
            } header: {
                makeHeaderView(dateStr: chatData.dataStr)
            }
        }
    }

    private func makeHeaderView(dateStr: String) -> some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color.clear)
                .frame(width: 76, height: 20)
                .background(Color.chatNotice)
                .cornerRadius(50)

            Text(dateStr)
                .font(.system(size: 10))
                .foregroundStyle(Color.bgWh)
        }
        .padding(.top)
    }
}

#Preview {
    NavigationStack {
        ChatView(viewModel: .init(
            container: DIContainer(services: StubServices()),
                                  chatRoomId: "chatRoom1_id",
                                  myUserId: "user1_id",
                                  otherUserId: "user2_id")
        )
    }
}
