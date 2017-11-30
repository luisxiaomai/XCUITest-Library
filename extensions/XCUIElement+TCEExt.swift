//
//  XCUIElement+TCEExt.swift
//  anwstream
//
//  
//  
//

import Foundation
import XCTest

extension XCUIElement {
    /**
     Removes any current text in the field before typing in the new value
     - Parameter text: the text to enter into the field
     */
    func clearAndEnterText(_ text: String, tapType: String?=nil, vector:CGVector? = nil) -> Void {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }
        if tapType == "forceTap"{
            self.forceTap(vector)
        } else {
            self.tap()
        }
        let deleteString = stringValue.characters.map { _ in XCUIKeyboardKeyDelete }.joined(separator: "")
        self.typeText(deleteString)
        self.typeText(text)
    }
    
    func forceTap(_ vector:CGVector? = nil){
        let coordinate = self.coordinate(withNormalizedOffset: ((vector == nil) ? CGVector(dx: 0, dy: 0) : vector!))
        coordinate.tap()
    }
    
    func smartTap(){
        self.tap();
        if(self.visible()){
            self.tap()
        }
    }
    
    func verifyExists(_ message: String = "Can not find related element") {
        XCTAssert(self.exists,message)
    }
    
    func verifyNotExists(_ message: String = "Related element still appears") {
        XCTAssertTrue(!self.exists, message)
    }
    
    func verifyEnabled(_ message: String = "Element disabled") {
        XCTAssert(self.isEnabled, message)
    }
    
    func verifyDisabled(_ message: String = "Element enabled") {
        XCTAssert(!self.isEnabled, message)
    }
    
    func verifyLabel(label : String, message: String = "Do not match text") {
        XCTAssertTrue(label == self.label, message)
    }
    
    func verifyTextValue(value : String, message: String = "Do not match text") {
        XCTAssertTrue(value == self.value as! String)
    }
    
    func inputText(_ text:String) {
        self.tap()
        self.clearAndEnterText(text)
        utils().handleKeyboard("Done")
    }
}
