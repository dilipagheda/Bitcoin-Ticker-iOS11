//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Angela Yu on 23/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    

    
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let symbol = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    var finalURL = ""

    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
        //get the price for first currency in the array
        finalURL = baseURL + currencyArray[0]
        getBitcoinPrice(url:finalURL,symbol:symbol[0])
        
    }

    
    //TODO: Place your 3 UIPickerView delegate methods here
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        finalURL = baseURL + currencyArray[row]
        getBitcoinPrice(url:finalURL, symbol:symbol[row])
    }
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
    func getBitcoinPrice(url: String, symbol:String) {
        
        Alamofire.request(url, method: .get).responseJSON {
            response in
                if response.result.isSuccess {
                   let bitcoinJSON:JSON = JSON(response.result.value!)
                    
                    self.updateBitcoinPrice(json: bitcoinJSON, symbol:symbol)
                } else {
                   
                }
            }

    }

    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    func updateBitcoinPrice(json : JSON, symbol:String) {
        
        let price = json["ask"].doubleValue
        bitcoinPriceLabel.text = symbol+String(format: "%.2f", price)
      
    
    }



}

