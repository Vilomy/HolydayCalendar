//
//  Holyday.swift
//  HolydayCalendar
//
//  Created by Gleb Zadonskiy on 05.07.2020.
//  Copyright © 2020 Gleb Zadonskiy. All rights reserved.
//

import Foundation


struct HolidayResponse: Decodable {
    var response: Holidays
}


struct Holidays: Decodable {
    var holiday: [HolidayDetail]
}


struct HolidayDetail: Decodable {
    var name: String
    var description: String
    var date: DateInfo
    var type: String
    var location: String
    var sates: String
    
}

struct DateInfo: Decodable {
    var iso: String
    
}
