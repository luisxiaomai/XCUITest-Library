//
//  leadsList.swift
//  anwstream
//
//   
//  
//

import Foundation
import XCTest

class leadsList : NSObject {
    let app = utils().app
    static let LIST_TITLE = "Leads"
    
    var leftMenuBtn : XCUIElement {
        return app.navigationBars.element.buttons.element(boundBy: 0)
    }
    
    var openQuickFilterBtn: XCUIElement {
        return app.buttons["Open"]
    }
    
    var newQuickFilterBtn: XCUIElement {
        return app.buttons["New"]
    }
    
    var allQuickFilterBtn : XCUIElement {
        return app.buttons["All"]
    }
    
    var filterBtn : XCUIElement {
        return app.navigationBars[leadsList.LIST_TITLE].buttons["filterBtn"];
    }
    
    var createBtn : XCUIElement {
        return app.navigationBars[leadsList.LIST_TITLE].buttons["createBtn"];
    }
    
    var searchField : XCUIElement {
        return app.searchFields.element
    }
    
    func cellWithText(_ identifier: String) -> XCUIElement{
        return app.tables.cells.staticTexts[identifier]
    }
    
    func searchAndGoToDetail(_ identifier:String) {
        self.searchField.tap()
        self.searchField.typeText(identifier)
        utils().handleKeyboard("Search")
        self.cellWithText(identifier).tap()
    }
}
