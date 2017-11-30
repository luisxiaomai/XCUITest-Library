//
//  utils.swift
//  anwstream
//
//  Created by Lu, Luis on 07/11/2016.
//  
//

import Foundation
import XCTest

class utils: NSObject{
    
    
    let app = XCUIApplication()
    
    /**
     - parameter dateElement:  locate dateTime element
     - parameter dateTime: match specified format like Dec 12-10-10-PM
     */
    func handleDateTimePicker(_ dateElement:XCUIElement, dateTime:String) {
        dateElement.tap()
        let dateTimeArray = dateTime.components(separatedBy: "-")
        app.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: dateTimeArray[0])
        app.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: dateTimeArray[1])
        app.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: dateTimeArray[2])
        app.pickerWheels.element(boundBy: 3).adjust(toPickerWheelValue: dateTimeArray[3])
        app.toolbars.buttons.element(boundBy: 0).tap()
    }

    
    
    /**
     - parameter dateElement:  locate dateTime element
     - parameter date: match specified format like December-12-2018
     */
    func handleDatePicker(_ dateElement:XCUIElement, date:String) {
        dateElement.tap()
        let dateArray = date.components(separatedBy: "-")
        app.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: dateArray[0])
        app.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: dateArray[1])
        app.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: dateArray[2])
        app.toolbars.buttons.element(boundBy: 0).tap()
    }
    
    func handleSelectorPicker(_ identifier:String) {
        app.pickerWheels.element.adjust(toPickerWheelValue: identifier)
        app.toolbars.buttons.element(boundBy: 0).tap()
    }
    
    func handleKeyboard(_ key:String){
        if app.keyboards.buttons[key].exists {
            app.keyboards.buttons[key].tap()
        }  else if app.keyboards.keys[key].exists {
           app.keyboards.keys[key].tap()
        } else {
            app.toolbars.buttons["Done"].tap()
        }
    }
    
//    func handleAlert(_ actionIdentifier:String){
//        let actionElement = app.alerts.buttons[actionIdentifier]
//        actionElement.tap()
//    }
    
//    func handleSystemAlert(_ xcTestCase:XCTestCase, _ actionIdentifier:String){
//        let monitorToken = xcTestCase.addUIInterruptionMonitor(withDescription: "Calender permission") { (alert) -> Bool in
//            alert.buttons[actionIdentifier].tap()
//            return true
//        }
//        app.tap() // need to interact with the app for the handler to fire
//    }
    
//    func verifyElementExists(_ element: XCUIElement, message: String = "Can not find related element"){
////        XCTAssert(element.exists,message)
//        element.verifyExists(message)
//    }
//    
//    func verifyElementDisappers(_ element: XCUIElement, message: String = "Related element still appears"){
//        XCTAssertTrue(!element.exists, message)
//    }
    
    func waitForElementToAppear(_ xcTestCase:XCTestCase, _ element: XCUIElement, timeout : Double = 5) {
        let existsPredicate = NSPredicate(format: "exists == true")
        xcTestCase.expectation(for: existsPredicate, evaluatedWith: element, handler: nil)
        xcTestCase.waitForExpectations(timeout: timeout) { (error) -> Void in
            XCTAssert(error == nil, "Failed to find \(element) after \(timeout) seconds.")
        }
    }
    //    func waitForElementToAppear(_ element: XCUIElement, timeout : Double = 5, file: String = #file, line: UInt = #line) {
    //        let existsPredicate = NSPredicate(format: "exists == true")
    //        expectation(for: existsPredicate, evaluatedWith: element, handler: nil)
    //        waitForExpectations(timeout: timeout) { (error) -> Void in
    //            if (error != nil) {
    //                let message = "Failed to find \(element) after \(timeout) seconds."
    //                self.recordFailure(withDescription: message, inFile: file, atLine: line, expected: true)
    //            }
    //        }
    //    }
    
    func swipeUp() {
        self.app.tables.element(boundBy: 0).swipeUp()
    }
    
    func swipeUpUntilElementVisible(element: XCUIElement) {
        self.app.tables.element(boundBy: 0).scrollUpToElement(element: element)
    }
    
    func swipeDown() {
        self.app.tables.element(boundBy: 0).swipeDown()
    }
    
    func swipeDownUntilElementVisible(element: XCUIElement) {
        self.app.tables.element(boundBy: 0).scrollDownToElement(element: element)
    }
    
    func swipeDown(time: Int){
        for _ in 0 ..< time {
            utils().swipeDown()
        }
    }
}


