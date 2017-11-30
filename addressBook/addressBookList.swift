//
//  addressBookList.swift
//  anwstream
//
//   on 2/8/17.
//  
//

import Foundation
import XCTest

class addressBook : NSObject {
    
    static let ADDRESS_BOOK_LIST_NAME : String = "Address Book"
    
    let app = utils().app;
    
    var leftMenuBtn : XCUIElement {
        return app.navigationBars.element.buttons.element(boundBy: 0)
    }
    
    var createBtn : XCUIElement {
        return app.navigationBars.matching(identifier: addressBook.ADDRESS_BOOK_LIST_NAME).buttons.element(boundBy: 1)
    }
    
    var createCorporateBtn : XCUIElement {
        return self.btnWithText("Corporate")
    }
    
    var createIndividualBtn : XCUIElement {
        return self.btnWithText("Individual")
    }
    
    var createContactBtn : XCUIElement {
        return self.btnWithText("Contact")
    }
    
    var cancelBtn : XCUIElement {
        return self.btnWithText("Cancel")
    }
    
    var searchField : XCUIElement {
        return app.searchFields.element
    }
    
    func cellWithText(_ identifier: String) -> XCUIElement{
        return app.tables.cells.staticTexts[identifier]
    }
    
    func cellWithTextField(_ identifier: String) -> XCUIElement{
        return app.tables.cells.textFields[identifier]
    }
    
    func btnWithText(_ text: String) -> XCUIElement {
        return app.buttons[text]
    }
    
    func selectCell(_ identifier: String) {
        let cell = self.cellWithText(identifier)
        cell.tap()
    }
    
    func searchAndGoToDetail(_ identifier:String) {
        self.searchField.tap()
        self.searchField.typeText(identifier)
        utils().handleKeyboard("Search")
        self.cellWithText(identifier).tap()
    }
}
