//
//  Entity.swift
//  MVC-MVVM
//
//  Created by 김민 on 2/20/24.
//

import Foundation


struct UtcTimeModel: Codable {
    let abbreviation: String
    let clientIp: String
    let dateTime: String
    let dayOfWeek: Int
    let dayOfYear: Int
    let dst: Bool
    let dstFrom: String?
    let dstOffset: Int
    let dstUntil: String?
    let rawOffset: Int
    let timezone: String
    let unixTime: Int
    let utcDatetime: String
    let utcOffset: String
    let weekNumber: Int

    enum CodingKeys: String, CodingKey {
        case clientIp = "client_ip"
        case dateTime = "datetime"
        case dayOfWeek = "day_of_week"
        case dayOfYear = "day_of_year"
        case dstFrom = "dst_from"
        case dstOffset = "dst_offset"
        case dstUntil = "dst_until"
        case rawOffset = "raw_offset"
        case unixTime = "unixtime"
        case utcDatetime = "utc_datetime"
        case utcOffset = "utc_offset"
        case weekNumber = "week_number"
        case abbreviation, dst, timezone
    }
}
