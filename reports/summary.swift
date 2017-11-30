//
//  summary.swift
//  anwstream
//
//   
//  
//

import Foundation
import XCTest

class summary : NSObject {
    
    let app = utils().app
    
    static let SALES_SUMMARY_TITLE :String = "Sales Summary"
    
    func pullDownMenu(_ itemName: String){
        app.buttons[itemName].tap()
    }
    
    func tapRow(_ text: String){
        app.buttons[text].tap()
    }
    
    func unselectAll(_ unselectAll:String){
        app.buttons["multi_option_select_all"].tap()
    }

    func select(_ text: String){
        app.buttons[text].tap()
    }
    
    func setFilter(_ itemName: String, _ text: String){
        self.pullDownMenu(itemName)
        self.tapRow(text)
    }

    func multiSelect(_ unselectText: String, _ selectBtn: Array<String>){
        self.unselectAll(unselectText)
        
        for text: String in selectBtn {
            self.select(text)
        }
        
    }
    
    var applyBtn : XCUIElement {
        return app.buttons["Apply"]
    }

}
