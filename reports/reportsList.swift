//
//  reportsList.swift
//  anwstream
//
//   on 2017/8/1.
//  
//

import Foundation
import XCTest

class reportsList : NSObject {
    
    let app = utils().app
    
    static let REPORTS_LIST_TITLE :String = "Reports"
    
    var leftMenuBtn : XCUIElement {
        return app.navigationBars.element.buttons.element(boundBy: 0)
    }

    func navigate(_ itemName: String){
        app.tables.cells.containing(.staticText, identifier:itemName).element.tap()
    }

    var backBtn: XCUIElement {
        return app.navigationBars.element.buttons.element(boundBy: 0)
    }
    
}
