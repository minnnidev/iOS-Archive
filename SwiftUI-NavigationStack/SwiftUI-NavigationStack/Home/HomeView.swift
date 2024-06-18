//
//  HomeView.swift
//  SwiftUI-NavigationStack
//
//  Created by 김민 on 6/18/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var pathModel = PathModel()
    
    var body: some View {
        NavigationStack(path: $pathModel.paths) {
            TabView(selection: .constant(1),
                    content:  {
                AView()
                    .tabItem { Image(systemName: "heart") }
                    .tag(1)
                BView()
                    .tabItem { Image(systemName: "star") }
                    .tag(2)
            })
            .background(Color.white)
            .navigationDestination(for: PathType.self) { pathType in
                switch pathType {
                case .detailA:
                    DetailAView()
                case .detailA2:
                    DetailA2View()
                case .detailB:
                    DetailBView()
                }
            }
        }
        .environmentObject(pathModel)
    }
}

#Preview {
    HomeView()
        .environmentObject(PathModel())
}
