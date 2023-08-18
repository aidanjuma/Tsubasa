//
//  ExchangeRateAPIClient.swift
//  Tsubasa
//
//  Created by Aidan Juma on 18/08/2023.
//

import ComposableArchitecture
import Foundation

struct ExchangeRateAPIClient {
    var fetchExchangeRateData: @Sendable () async throws -> ExchangeRate
    var convertCurrency: @Sendable (_ from: String, _ to: String, _ amount: Double, _ exchangeRateData: ExchangeRate) async throws -> Price?

    struct Failure: Error {}
}

// TODO: static let test = Self(...)
extension ExchangeRateAPIClient {
    static let live = Self(
        fetchExchangeRateData: {
            let (data, _) = try await URLSession.shared.data(from: URL(string: "https://raw.githubusercontent.com/aidanjuma/currencies-against-usd/master/currency-rates.json")!)
            let exchangeRateData = try JSONDecoder().decode(ExchangeRate.self, from: data)
            return exchangeRateData
        },
        convertCurrency: { from, to, amount, exchangeRateData in
            let converted = try exchangeRateData.convert(from: from, to: to, amount: amount)
            return converted
        }
    )
}
