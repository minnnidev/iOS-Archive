//
//  DBError.swift
//  ChattingApp
//
//  Created by 김민 on 6/23/24.
//

import Foundation

enum DBError: Error {
    case error(Error)
    case emptyValue
    case invalidatedType
}
