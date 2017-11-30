//
//  activity.swift
//  anwstream
//
//  Created by Lu, Luis on 09/11/2016.
//  
//

import Foundation
import XCTest

class activity: NSObject{
    
    let app = utils().app
    
    //header
    var backBtnOnCreateView: XCUIElement {
        return app.navigationBars["Add Activity"].buttons.element(boundBy: 0)
    }
    
    var doneBtnOnCreateView: XCUIElement {
        return app.buttons["create_confirm_btn"]
    }
    
    var backBtnOnEditView: XCUIElement {
        return app.buttons["edit_cancel_btn"]
    }
    
    var doneBtnOnEditView: XCUIElement {
        return app.buttons["edit_confirm_btn"]
    }
    
    var currentType: XCUIElement {
        return app.tables.cells.containing(.staticText, identifier: "Type").staticTexts.element(boundBy: 1)

    }
    
    func switchType(_ type:String){
        currentType.tap()
        app.pickerWheels.element.adjust(toPickerWheelValue: type)
        app.toolbars.buttons.element.tap()
    }
        
    func typeDetails(_ comments: String){
        app.tables.element(boundBy: 0).swipeUp()
        let textView = app.tables.cells.containing(.staticText, identifier: "Details").textViews.element
        textView.clearAndEnterText(comments, tapType: "forceTap", vector: CGVector.init(dx: 0.9, dy: 0.9))
        utils().handleKeyboard("Done")
    }
    
    func verifyType(_ type: String) {
        XCTAssertTrue(type == currentType.label, "Current type \(type) is not correct")
    }
}
