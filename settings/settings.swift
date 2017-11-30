//
//  settings.swift
//  anwstream
//
//  
//  
//

import Foundation
import XCTest

class settings: NSObject{
    
    let app = utils().app
    
    var backBtn:XCUIElement{
        return app.buttons["setting_form_back"]
    }
    
    func navigate(_ itemName: String){
        app.tables.cells.containing(.staticText, identifier:itemName).element.tap()
    }
    
    func toggleSwitch(key: String){
//        NSLog("%@", app.tables.checkBoxes.element(boundBy: 0))
        app.tables.cells.containing(.staticText, identifier:key).switches.element(boundBy: 0).tap()
    }
    
    func tapRow(_ text: String){
        app.tables.cells.containing(.staticText, identifier:text).element.tap()
    }
    
    func btnWithText(_ text: String){
        app.buttons[text].tap()
    }
}
