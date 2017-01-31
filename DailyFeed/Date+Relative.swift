//
//  Date+Relative.swift
//  DailyFeed
//
//  Created by LittleBiteOfCocoa on 23/01/17.
//  Copyright © littlebitesofcocoa.com. All rights reserved.
//

import Foundation

extension Date {

    func relativelyFormatted(short: Bool) -> String {

        let now = Date()
        let components = Calendar.autoupdatingCurrent.dateComponents([.year,
                                                                      .month,
                                                                      .weekOfYear,
                                                                      .day,
                                                                      .hour,
                                                                      .minute,
                                                                      .second],
                                                                     from: self,
                                                                     to: now)

        if let years = components.year, years > 0 {
            return short ? " • \(years)y ago" : "\(years) year\(years == 1 ? "" : "s") ago"
        }

        if let months = components.month, months > 0 {
            return short ? " • \(months)mo ago" : "\(months) month\(months == 1 ? "" : "s") ago"
        }

        if let weeks = components.weekOfYear, weeks > 0 {
            return short ? " • \(weeks)w ago" : "\(weeks) week\(weeks == 1 ? "" : "s") ago"
        }
        if let days = components.day, days > 0 {
            guard days > 1 else { return short ? " • Y'day" : "Yesterday" }

            return short ? " • \(days)d ago" : "\(days) day\(days == 1 ? "" : "s") ago"
        }

        if let hours = components.hour, hours > 0 {
            return short ? " • \(hours)h ago" : "\(hours) hour\(hours == 1 ? "" : "s") ago"
        }

        if let minutes = components.minute, minutes > 0 {
            return short ? " • \(minutes) min ago" : "\(minutes) minute\(minutes == 1 ? "" : "s") ago"
        }

        if let seconds = components.second, seconds > 30 {
            return short ? " • \(seconds)s ago" : "\(seconds) second\(seconds == 1 ? "" : "s") ago"
        }

        return "Just now"
    }
}

extension String {
    var dateFromTimestamp: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let date = dateFormatter.date(from: self)
        return date

    }
}