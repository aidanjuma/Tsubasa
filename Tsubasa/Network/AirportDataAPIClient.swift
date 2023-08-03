//
//  AirportDataAPIClient.swift
//  Tsubasa
//
//  Created by Aidan Juma on 02/08/2023.
//

import ComposableArchitecture
import Foundation

struct AirportDataAPIClient {
    var fetchAirports: @Sendable () async throws -> [Airport]

    struct Failure: Error {}
}

extension AirportDataAPIClient {
    static let live = Self(
        fetchAirports: {
            let (data, _) = try await URLSession.shared
                .data(from: URL(string: "https://raw.githubusercontent.com/aidanjuma/iata-airports/master/iata-airports.json")!)
            let airports = try JSONDecoder().decode([Airport].self, from: data)
            return airports
        }
    )

    static let test = Self(
        fetchAirports: {
            let data = """
            {
                "icao": "WSSS",
                "iata": "SIN",
                "name": "Singapore Changi International Airport",
                "city": "Singapore",
                "state": "North-East",
                "country": "SG",
                "elevation": 22,
                "lat": 1.3501900434,
                "lon": 103.9940032959,
                "tz": "Asia/Singapore"
            }
            """.data(using: .utf8)!
            let airports = try JSONDecoder().decode([Airport].self, from: data)
            return airports
        }
    )
}

private enum AirportDataAPIClientKey: DependencyKey {
    static let liveValue = AirportDataAPIClient.live
}

private enum AirportDataAPIClientTestKey: DependencyKey {
    static let liveValue = AirportDataAPIClient.test
}

extension DependencyValues {
    var airportDataApiClient: AirportDataAPIClient {
        get { self[AirportDataAPIClientKey.self] }
        set { self[AirportDataAPIClientKey.self] = newValue }
    }

    var testAirportDataApiClient: AirportDataAPIClient {
        get { self[AirportDataAPIClientTestKey.self] }
        set { self[AirportDataAPIClientTestKey.self] = newValue }
    }
}
