//
//  PathModel.swift
//  SwiftUI-NavigationStack
//
//  Created by 김민 on 6/18/24.
//
import Foundation

enum PathType {
    case detailA
    case detailA2
    case detailB
}

class PathModel: ObservableObject {
  @Published var paths: [PathType]

  init(paths: [PathType] = []) {
    self.paths = paths
  }
}
