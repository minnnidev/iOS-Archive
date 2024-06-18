//
//  DetailBView.swift
//  SwiftUI-NavigationStack
//
//  Created by 김민 on 6/18/24.
//

import SwiftUI

struct DetailBView: View {
    @EnvironmentObject private var pathModel: PathModel

    var body: some View {
        ZStack {
            Color.pink

            VStack {
                Text("Detail B")
                    .font(.system(size: 20))

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
    DetailBView()
}
