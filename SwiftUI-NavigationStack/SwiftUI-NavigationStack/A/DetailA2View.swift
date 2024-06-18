//
//  DetailA2View.swift
//  SwiftUI-NavigationStack
//
//  Created by 김민 on 6/18/24.
//

import SwiftUI

struct DetailA2View: View {
    @EnvironmentObject private var pathModel: PathModel

    var body: some View {
        ZStack {
            Color.gray

            VStack {
                Text("Detail A2")

                Button(action: {
                    pathModel.paths.removeLast()
                }, label: {
                    Text("Go back")
                })

                Button(action: {
                    pathModel.paths.removeAll()
                }, label: {
                    Text("Go Home")
                })
            }
        }
    }
}

#Preview {
    DetailA2View()
        .environmentObject(PathModel())
}
