//
//  ExchangeRate.swift
//  Tsubasa
//
//  Created by Aidan Juma on 15/08/2023.
//

import Foundation

struct ExchangeRate: Equatable {
    let timestamp: TimeInterval
    let baseCurrency: String
    var data: [String: Double]
}

extension ExchangeRate: Decodable {
    enum ExchangeRateKeys: String, CodingKey {
        case timestamp
        case baseCurrency = "base"
        case data = "rates"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ExchangeRateKeys.self)
        self.timestamp = try container.decode(TimeInterval.self, forKey: .timestamp)
        self.baseCurrency = try container.decode(String.self, forKey: .baseCurrency)
        self.data = try container.decode([String: Double].self, forKey: .data)
    }

    func convert(from: String, to: String, amount: Double) throws -> Price? {
        guard let fromRate = data[from], let toRate = data[to] else {
            return nil
        }

        var result: Double?

        switch from {
        case "USD":
            result = toRate * amount
        default:
            if to == "USD" { result = toRate / amount } else { result = (fromRate / amount) * toRate }
        }

        if result == nil { return nil }

        return Price(currency: to, amount: result!)
    }
}
