//
//  profile.swift
//  anwstream
//
//  
//  
//

import Foundation
import XCTest

class profile: NSObject{
    
    let app = utils().app
    
    var editBtn: XCUIElement {
        return app.navigationBars.buttons["profile_edit"];
    }
    var saveBtn: XCUIElement {
        return app.buttons["edit_confirm_btn"];
    }
    
    var backBtn: XCUIElement {
        return app.navigationBars.element.buttons.element(boundBy: 0)
    }
    
    func textWithLabel(_ label:String) -> XCUIElement {
        return app.tables.cells.containing(.staticText, identifier: label).staticTexts.element(boundBy: 1)
    }
    
    func textFieldWithLabel(_ label:String) -> XCUIElement {
        return app.tables.cells.containing(.staticText, identifier: label).textFields.element
    }
}
