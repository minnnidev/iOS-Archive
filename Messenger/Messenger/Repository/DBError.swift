//
//  DBError.swift
//  Messenger
//
//  Created by 김민 on 6/19/24.
//

import Foundation

enum DBError: Error {
    case error(Error)
    case emptyValue
}
