//
//  BView.swift
//  SwiftUI-NavigationStack
//
//  Created by 김민 on 6/18/24.
//

import SwiftUI

struct BView: View {
    @EnvironmentObject private var pathModel: PathModel

    var body: some View {
        ZStack {
            Color.orange

            VStack {
                Text("B")

                Button(action: {
                    pathModel.paths.append(.detailB)
                }, label: {
                    Text("Go to DetailB")
                })
            }
        }
    }
}

#Preview {
    BView()
        .environmentObject(PathModel())
}
