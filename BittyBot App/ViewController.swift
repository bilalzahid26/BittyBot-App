//
//  ViewController.swift
//  BittyBot App
//
//  Created by Bilal Zahid on 05/02/2018.
//  Copyright © 2018 Bilal Zahid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    


    @IBAction func buttonClick(sender: UIButton) {
        self.getHTML()
    }
    
    func getHTML(){
        let myURLString = "https://coinmarketcap.com"
        guard let myURL = URL(string: myURLString) else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
            return
        }
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
            var HTMLArr = myHTMLString.components(separatedBy:"<tr id")
            var tokens = [token]()
            HTMLArr[0] = ""
            let word = HTMLArr[HTMLArr.count-1]
            if let index = word.range(of:"></a></td>")?.lowerBound {
                let substring = word[..<index]
                let string = String(substring)
                HTMLArr[HTMLArr.count-1] = String(string)
            }
            for coin in HTMLArr{
                if coin != "" {
                    tokens.append(token(code: coin))
                }
                
            }
            for tokens in tokens{
                print(tokens.getTokenName())
                print(tokens.getTokenSymbol())
                print(tokens.getMktCap())
                print(tokens.getPrice())
                print(tokens.getChange())
                print(" ")
            }
        } catch let error {
            labelName.text = "Error: \(error)"
        }
    }
}

    class token {
        var tokenName: String
        var tokenSymbol: String
        var mktCap: String
        var price: String
        var change: String

        
        init(code: String) {
            var tokenName = code
            tokenName = String(tokenName.prefix(50))
            tokenName = tokenName.components(separatedBy: "=\"id-")[1]
            tokenName = tokenName.components(separatedBy: "\"  class")[0]
            self.tokenName = tokenName.uppercased()
            tokenName = ""
            
            var tokenSymbol = code
            tokenSymbol = tokenSymbol.components(separatedBy: "/\">")[1]
            tokenSymbol = tokenSymbol.components(separatedBy: "</a></")[0]
            self.tokenSymbol = tokenSymbol
            tokenSymbol = ""
            
            var mktCap = code
            mktCap = mktCap.components(separatedBy: "$")[1]
            mktCap = mktCap.components(separatedBy: "<")[0]
            mktCap = mktCap.replacingOccurrences(of: " ", with: "")
            let endIndex = mktCap.index(mktCap.endIndex, offsetBy: -2)
            let truncated = mktCap.substring(to: endIndex)
            mktCap = truncated
            self.mktCap = "$" + mktCap
            mktCap = ""
            
            
            var price = code
            price = price.components(separatedBy: "price\" data-usd=\"")[1]
            price = price.components(separatedBy: "\"")[0]
            price = price.trimmingCharacters(in: .whitespaces)
            self.price = "$" + price
            price = ""
            
            var change = code
            change = change.components(separatedBy: "change")[1]
            change = change.components(separatedBy: "data-btc")[0]
            change = change.components(separatedBy: "data-usd=")[1]
            change = change.replacingOccurrences(of: "\"", with: "")

            change = change.trimmingCharacters(in: .whitespaces)
            self.change = change + "%"
            change = ""
        }
        
        
        func getTokenName() -> String {
            return tokenName
        }
        func getChange() -> String {
            return change
        }
        func getPrice() -> String {
            return price
        }
        func getMktCap() -> String {
            return mktCap
        }
        func getTokenSymbol() -> String {
            return tokenSymbol
        }
}

