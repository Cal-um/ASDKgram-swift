//
//  Date.swift
//  ASDKgram-Swift
//
//  Created by Calum Harris on 16/01/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import Foundation

extension Date {

	static let iso8601Formatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.calendar = Calendar(identifier: .iso8601)
		formatter.locale = Locale(identifier: "en_US_POSIX")
		formatter.timeZone = TimeZone(secondsFromGMT: 0)
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
		return formatter
	}()
}
