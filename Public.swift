//
//  Public.swift
//  JAM
//
//  Created by Dukhee Kang on 2017. 5. 29..
//  Copyright © 2017년 JAM. All rights reserved.
//

import Foundation

/**
 
 현재 시간을 문자열로 리턴
 @param nil
 @returns 현재 시간 : String
 @exception <#throws#>
 */

public func nowTimeString()->String{
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy.MM.dd HH:mm"
    let dateString = dateFormatter.string(from:date)
    return dateString
}

/**
 
 내일 시간을 문자열로 리턴
 @param nil
 @returns 현재 시간 : String
 @exception <#throws#>
 */

public func tomorrowTimeString()->String{
    var date = Date()
    date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy.MM.dd"
    let dateString = dateFormatter.string(from:date)
    return dateString
}


/**
 
 현재 요일을 문자열로 리턴
 @param nil
 @returns 현재 요일 : String
 @exception <#throws#>
 */
public func nowDateString()->String{
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy.MM.dd"
    let dateString = dateFormatter.string(from:date as Date)
    return dateString
}


///**
//
// 현재 요일을 기준으로 몇일 전 요일을 문자열로 리턴
// @param 몇 일전 : Int
// @returns 현재 요일 : String
// @exception <#throws#>
// */
//public func agoDateString(_ ago:Int)->String{
//    let date = NSDate(timeIntervalSinceNow:TimeInterval(-24 * 60 * 60 * ago))
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat =
//    let dateString = dateFormatter.string(from:date as Date)
//    return dateString
//}


/**
 
 현재 요일을 기준으로 몇일 전 요일을 형식에 맞춰 문자열로 리턴
 @param 몇 일전 : Int
 @returns 현재 요일 : String
 @exception
 */
public func agoDateString(_ ago:Int, _ dateFormat:String = "yyyy.MM.dd")->String{
    
    if ago >= 30 {
        let agoMonth = Int(ceil(Double(ago/30)))
        var date = Date()
        date = Calendar.current.date(byAdding: .month, value: -agoMonth, to: date)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let dateString = dateFormatter.string(from:date as Date)
        return dateString
    }
    else{
        let date = NSDate(timeIntervalSinceNow:TimeInterval(-24 * 60 * 60 * ago))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let dateString = dateFormatter.string(from:date as Date)
        return dateString
    }
}

/**
 
 현재 시간을 기준으로 몇 시간 전을 형식에 맞춰 문자열로 리턴
 @param 몇 일전 : Int
 @returns 현재 요일 : String
 @exception
 */
public func agoHourString(_ ago:Int, _ dateFormat:String = "yyyy.MM.dd HH:mm")->String{
    
    
    let date = NSDate(timeIntervalSinceNow:TimeInterval(-60 * 60 * ago))
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    let dateString = dateFormatter.string(from:date as Date)
    return dateString
}

/**
 
 Date문자열을 Date포멧형식에 맞게 Date로 리턴
 @param Date문자열:String Date포멧 : Int
 @returns Date : Date
 @exception <#throws#>
 */
public func dateToStringTime(_ dateString:String = "", _ dateFormat:String = "yyyy.MM.dd HH:mm") -> Date{
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    let date = dateFormatter.date(from:dateString)
    return date ?? Date()
    
}

/**
 
 Date 값을 Date포멧형식에 맞게 문자열로 리턴
 @param nil
 @returns 현재 요일 : String
 @exception <#throws#>
 */
public func stringToDateTime(_ date:Date = Date(), dateFormat:String = "yyyy.MM.dd HH:mm")->String{
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    let dateString = dateFormatter.string(from:date as Date)
    return dateString
}
