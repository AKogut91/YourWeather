//
//  DataService.swift
//  YourWeather
//
//  Created by AlexanderKogut on 11/19/18.
//  Copyright © 2018 AlexanderKogut. All rights reserved.
//

import Foundation

class DataService {
    
    enum KindTime: String {
        case hoursMinut = "h:mm a"
        case monthDay = "MMM d"
        case day = "EEEE"
        case yearMonthDayHHmm = "yyyy-MM-dd HH:mm"
    }
    
   static func timeStamp(unixTimestamp: Int, timeFormat: KindTime) -> String {
        
        let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") 
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = timeFormat.rawValue
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
}
