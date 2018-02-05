//
//  ViewController.swift
//  BittyBot App
//
//  Created by Bilal Zahid on 05/02/2018.
//  Copyright © 2018 Bilal Zahid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var labelName: UILabel!
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
                tokens.append(token(tokenCode: coin))
                }
            }
            for tokens in tokens{
                print(tokens.getTokenName())
            }
            
            print(HTMLArr[1])
        } catch let error {
            labelName.text = "Error: \(error)"
        }
    }
}

class token {
    var tokenName: String
    init(tokenCode: String) {

        tokenName = String(tokenCode.prefix(30))
    }
    func getTokenName() -> String {
        return tokenName
    }
}

