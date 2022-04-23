//
//  ViewController.swift
//  BitCoinPrice
//
//  Created by Uchiha Paulo on 23/04/22.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var currencyCoinListPicker: UIPickerView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var coinLabel: UILabel!
    let httpClientService: HttpClientService = HttpClientService()
    let coinApiBase = CoinApiBase()
    var coinApiModel: CoinApiModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.httpClientService.delegate = self
        self.currencyCoinListPicker.delegate = self
        self.currencyCoinListPicker.dataSource = self
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.httpClientService.getApi()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.coinApiModel?.rates.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.coinApiModel?.rates[row].asset_id_quote
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let rateList = self.coinApiModel?.rates {
            var currentCoinRate: Rate = rateList[row]
            for item in rateList {
                if item.asset_id_quote == rateList[row].asset_id_quote {
                    currentCoinRate = item
                }
            }
            self.priceLabel.text = String(currentCoinRate.rate)
            self.coinLabel.text = currentCoinRate.asset_id_quote.uppercased()
        }
    }
}

extension ViewController: HttpClientServiceDelegate {
    func didUpdate(_ httpClientService: HttpClientService, coinApiModel: CoinApiModel) {
        DispatchQueue.main.async {
            self.coinApiModel = coinApiModel
            let actualCurrencyCoinList: Array<String> = coinApiModel.rates.map({(coin: Rate) -> String in
                return coin.asset_id_quote
            })
            self.coinApiBase.updateCurrencyCoinList(list: actualCurrencyCoinList)
            self.currencyCoinListPicker.reloadAllComponents()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
