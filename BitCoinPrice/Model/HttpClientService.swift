//
//  HttpClientService.swift
//  BitCoinPrice
//
//  Created by Uchiha Paulo on 23/04/22.
//

import Foundation

protocol HttpClientServiceDelegate {
    func didUpdate(_ httpClientService: HttpClientService, coinApiModel: CoinApiModel)
    func didFailWithError(error: Error)
}

class HttpClientService {
    var delegate: HttpClientServiceDelegate?
    
    func getApi() {
        let baseUrl = CoinApiBase()
        if let url = URL(string: baseUrl.urlRequest) {
            let urlSession: URLSession = URLSession(configuration: .default)
            let urlTask = urlSession.dataTask(with: url, completionHandler: self.urlSessionHandler)
            urlTask.resume()
        }
    }
    
   private func urlSessionHandler(data: Data?, response: URLResponse?, error: Error?) -> Void {
        if error != nil {
            self.delegate?.didFailWithError(error: error!)
            return
        }
        if let safeData = data {
            if let coinData = self.parseJson(coinApiModel: safeData) {
                self.delegate?.didUpdate(self, coinApiModel: coinData)
            }
        }
    }
    
    private func parseJson(coinApiModel model: Data) -> CoinApiModel? {
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(CoinApiModel.self, from: model)            
            return result
        } catch let error {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
