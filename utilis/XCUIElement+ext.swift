//
//  XCUIElement+ext.swift
//  anwstream
//
//  
//

import Foundation
import XCTest

extension XCUIElement {
    func scrollUpToElement(element: XCUIElement) {
        while !element.visible() {
            swipeUp()
        }
    }
    
    func scrollDownToElement(element: XCUIElement) {
        while !element.visible() {
            swipeDown()
        }
    }
    
    func visible() -> Bool {
        guard self.exists && !self.frame.isEmpty && self.isHittable else { return false }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(self.frame)
    }
}
