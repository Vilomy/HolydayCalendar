//
//  HolydayRequest.swift
//  HolydayCalendar
//
//  Created by Gleb Zadonskiy on 05.07.2020.
//  Copyright © 2020 Gleb Zadonskiy. All rights reserved.
//

import Foundation
enum HolidayError: Error {
    case noDataAvaible
    case catNotProcessData
}


struct HolidayRequest{
    let resourceURL: URL
    let API_KEY = "f724905d934c5fa9f7fe3fbbbbcf122e2cea52a6"
    
    init(countryCode: String) {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let currentYear = format.string(from: date)
        let resourceString = "https://calendarific.com/api/v2/holidays?api_key=\(API_KEY)&country=\(countryCode)&year=\(currentYear))"
        
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceURL
    }
    
    func getHolidays(completion: @escaping(Result<[HolidayDetail], HolidayError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL){data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvaible))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let holidayResponse = try decoder.decode(HolidayResponse.self, from: jsonData)
                let holidayDetails = holidayResponse.response.holiday
                completion(.success(holidayDetails))
            }catch {
                completion(.failure(.catNotProcessData))
            }
        }
        dataTask.resume()
    }
    
    
    
}
