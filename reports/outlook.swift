//
//  outlook.swift
//  anwstream
//
//   on 2017/8/2.
//  
//

import Foundation
import XCTest

class outlook : NSObject {
    
    let app = utils().app
    
    static let OPPORTUNITIES_OUTLOOK_TITLE :String = "Opportunities Outlook"

    func pullDownMenu(_ itemName: String){
        app.buttons[itemName].tap()
    }
    
    func tapRow(_ text: String){
        app.buttons[text].tap()
    }
    
    func setFilter(_ itemName: String, _ text: String){
        self.pullDownMenu(itemName)
        self.tapRow(text)
    }

}
