//
//  DetailAView.swift
//  SwiftUI-NavigationStack
//
//  Created by 김민 on 6/18/24.
//

import SwiftUI

struct DetailAView: View {
    @EnvironmentObject private var pathModel: PathModel

    var body: some View {
        ZStack {
            Color.green

            VStack {
                Text("Detail A")

                Button(action: {
                    pathModel.paths.append(.detailA2)
                }, label: {
                    Text("Go to Detail A2")
                })

                Button(action: {
                    pathModel.paths.removeLast()
                }, label: {
                    Text("Go back")
                })
            }
        }
    }
}

#Preview {
    DetailAView()
        .environmentObject(PathModel())
}
