//
//  TimeAgo.swift
//  Nanopool
//
//  Created by Alexandre Ricard on 17/08/2021.
//

import Foundation

public func timeAgoSince(_ date: Date) -> String {
    
    let calendar = Calendar.current
    let now = Date()
    let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
    let components = (calendar as NSCalendar).components(unitFlags, from: date, to: now, options: [])
    
    if let year = components.year, year >= 2 {
        return "\(year) years ago".translate()
    }
    
    if let year = components.year, year >= 1 {
        return "Last year".translate()
    }
    
    if let month = components.month, month >= 2 {
        return "\(month) months ago".translate()
    }
    
    if let month = components.month, month >= 1 {
        return "Last month".translate()
    }
    
    if let week = components.weekOfYear, week >= 2 {
        return "\(week) weeks ago".translate()
    }
    
    if let week = components.weekOfYear, week >= 1 {
        return "Last week".translate()
    }
    
    if let day = components.day, day >= 2 {
        return "\(day) days ago".translate()
    }
    
    if let day = components.day, day >= 1 {
        return "Yesterday".translate()
    }
    
    if let hour = components.hour, hour >= 2 {
        return "\(hour) hours ago".translate()
    }
    
    if let hour = components.hour, hour >= 1 {
        return "1 hour ago".translate()
    }
    
    if let minute = components.minute, minute >= 2 {
        return "\(minute) min ago".translate()
    }
    
    if let minute = components.minute, minute >= 1 {
        return "1 min ago".translate()
    }
    
    if let second = components.second, second >= 3 {
        return "\(second) secondes ago".translate()
    }
    
    return "Just now".translate()
    
}
