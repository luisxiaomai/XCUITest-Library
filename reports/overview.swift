//
//  overview.swift
//  anwstream
//
//   on 2017/8/2.
//  
//

import Foundation
import XCTest

class overview : NSObject {
    
    let app = utils().app
    
    static let PIPELINE_OVERVIEW_TITLE :String = "Pipeline Overview"
        
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
