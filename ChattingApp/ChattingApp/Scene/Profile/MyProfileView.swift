//
//  MyProfileView.swift
//  ChattingApp
//
//  Created by 김민 on 6/23/24.
//

import SwiftUI
import PhotosUI

struct MyProfileView: View {
    @Environment(\.dismiss) var dismiss

    @StateObject var viewModel: MyProfileViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                Image("profile_bg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea(edges: .vertical)

                VStack(spacing: 0) {
                    Spacer()

                    profileView
                        .padding(.bottom, 16)

                    nameView
                        .padding(.bottom, 26)

                    descriptionView

                    Spacer()

                    menuView
                        .padding(.bottom, 58)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image("close")
                    }
                }
            }
            .task {
                await viewModel.getUser()
            }
        }
    }

    private var profileView: some View {
        PhotosPicker(selection: $viewModel.imageSelection, matching: .images) {
            AsyncImage(url: URL(string: viewModel.userInfo?.imageURL ?? "")) { image in
                image.resizable()
            } placeholder: {
                Image("person")
                    .resizable()
            }
            .frame(width: 80, height: 80)
            .clipShape(Circle())
        }
    }

    private var nameView: some View {
        Text(viewModel.userInfo?.name ?? "이름")
            .font(.system(size: 24, weight: .bold))
            .foregroundStyle(Color.bgWh)
    }

    private var descriptionView: some View {
        Button {
            viewModel.isPresentedDescriptionEditView.toggle()
        } label: {
            Text(viewModel.userInfo?.description ?? "상태 메세지를 입력해 주세요.")
                .font(.system(size: 14))
                .foregroundStyle(Color.bgWh)
        }
        .sheet(isPresented: $viewModel.isPresentedDescriptionEditView) {
            MyProfileDescriptionEditView(description: viewModel.userInfo?.description ?? "") { willBeDesc in
                Task {
                    await viewModel.updateDescription(description: willBeDesc)
                }
            }
        }
    }

    private var menuView: some View {
        HStack(alignment: .top, spacing: 27) {
            ForEach(MyProfileMenuType.allCases, id: \.self) { menu in
                Button {
                } label: {
                    VStack(alignment: .center) {
                        Image(menu.imageName)
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text(menu.description)
                            .font(.system(size: 10))
                            .foregroundColor(.whiteFix)
                    }
                }
            }
        }
    }
}

#Preview {
    MyProfileView(viewModel: MyProfileViewModel(container: DIContainer(services: StubServices()), userId: "user1_id"))
}
