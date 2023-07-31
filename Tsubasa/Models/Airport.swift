//
//  Airport.swift
//  Tsubasa
//
//  Created by Aidan Juma on 31/07/2023.
//
// Data obtainable from my repository "iata-airports" (https://raw.githubusercontent.com/aidanjuma/iata-airports/master/iata-airports.json)
// "state" field excluded in the below model due to being inaccurate outside of the USA.

import Foundation

struct Airport: Codable {
    let iataCode: String // 4 characters, e.g. WSSS
    let icaoCode: String // 3 characters, e.g. SIN
    let name: String // e.g. Singapore Changi International Airport
    let city: String // e.g. Singapore
    let country: String // 2 characters, e.g. SG
    let elevation: Int // Measured in feet, e.g. 22(ft)
    let latitude: Double // e.g. 1.3501900434
    let longitude: Double // e.g. 103.9940032959
    let timezone: String // e.g. Asia/Singapore

    enum CodingKeys: String, CodingKey {
        case iataCode = "iata"
        case icaoCode = "icao"
        case name
        case city
        case country
        case elevation
        case latitude = "lat"
        case longitude = "lon"
        case timezone = "tz"
    }
}
