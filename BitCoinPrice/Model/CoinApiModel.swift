//
//  CoinModel.swift
//  BitCoinPrice
//
//  Created by Uchiha Paulo on 23/04/22.
//

import Foundation

struct CoinApiModel: Decodable {
    let asset_id_base: String
    let rates: Array<Rate>
}

struct Rate: Decodable {
    let time: String
    let asset_id_quote: String
    let rate: Double
}
