//
//  Price.swift
//  Tsubasa
//
//  Created by Aidan Juma on 15/08/2023.
//

import Foundation

struct Price: Equatable {
    let currency: String
    let amount: Double
}

extension Price { func stringify() throws -> String { return "\(amount)\(currency)" } }
