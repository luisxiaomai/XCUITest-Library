//
//  relatedContacts.swift
//  anwstream
//
//  
//  
//

import Foundation
import XCTest

class relatedContacts: NSObject {
    let app = utils().app
    
    var leftMenuBtn : XCUIElement {
        return app.navigationBars.element.buttons.element(boundBy: 0)
    }
    
    var rightMenuBtn : XCUIElement {
        return app.navigationBars.element.buttons.element(boundBy: 1)
    }
    
    func contactCell(_ identifier: String) -> XCUIElement {
        return app.tables.cells.staticTexts[identifier]
    }
    
    func setMainContact(_ identifier:String) {
        self.contactCell(identifier).tap()
        contactEdit().rightMenuBtn.tap()
        contactEdit().btnWithText("Set as Main Contact").tap()
    }
}
