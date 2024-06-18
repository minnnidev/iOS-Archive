//
//  AView.swift
//  SwiftUI-NavigationStack
//
//  Created by 김민 on 6/18/24.
//

import SwiftUI

struct AView: View {
    @EnvironmentObject private var pathModel: PathModel

    var body: some View {
        ZStack {
            Color.red

            VStack {
                Text("A")
                    .font(.system(size: 20))

                Button(action: {
                    pathModel.paths.append(.detailA)
                }, label: {
                    Text("Go to DetailA")
                })
            }
        }
    }
}

#Preview {
    AView()
        .environmentObject(PathModel())
}
