//
//  callActivity.swift
//  anwstream
//
//  Created by Lu, Luis on 09/11/2016.
//  
//

import Foundation
import XCTest

class callActivity: activity{
    
    var durationField: XCUIElement {
        return app.tables.cells.containing(.staticText, identifier: "Duration").textFields.element
    }
    
    var dateSelector: XCUIElement {
        return app.tables.cells.containing(.staticText, identifier: "Date").staticTexts.element(boundBy: 1)
    }
    
    func create(_ details:String, dateTime:String?=nil, durationTime:String="15"){
        self.switchType("Call")
        self.input(details, dateTime: dateTime, durationTime: durationTime)
        self.doneBtnOnCreateView.tap()
    }
    
    func verifyType() {
        self.verifyType("Call")
    }
    
    func edit(_ details:String, dateTime:String?=nil, durationTime:String="15") {
        self .input(details, dateTime: dateTime, durationTime: durationTime)
        self.doneBtnOnEditView.tap()
    }
    
    func input(_ details:String, dateTime:String?=nil, durationTime:String="15") {
        if dateTime != nil{
            utils().handleDateTimePicker(dateSelector, dateTime: dateTime!)
        }
        if durationTime != "15"{
            durationField.clearAndEnterText(durationTime)
        }
        self.typeDetails(details)
        snapshot("addCallActivityScreen")
    }
}
