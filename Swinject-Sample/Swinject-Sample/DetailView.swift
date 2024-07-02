//
//  DetailView.swift
//  Swinject-Sample
//
//  Created by 김민 on 7/2/24.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    DetailView(viewModel: .init(useCase: StubUseCase()))
}
