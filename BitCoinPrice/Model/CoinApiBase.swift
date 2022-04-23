//
//  CoinApiBase.swift
//  BitCoinPrice
//
//  Created by Uchiha Paulo on 23/04/22.
//

import Foundation


class CoinApiBase {
    let baseUrl: String = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey: String = "7E4DD39A-69D8-4CD2-8A73-6ECE665721A8"
    var currencyCoinList: Array<String> = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var urlRequest: String {
        return "\(baseUrl)?apikey=\(apiKey)"
    }
    
    func updateCurrencyCoinList(list value: Array<String>) {
        self.currencyCoinList = value
    }
}
