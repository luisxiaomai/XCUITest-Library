//
//  activity.swift
//  anwstream
//
//  Created by Lu, Luis on 08/11/2016.
//  
//

import Foundation
import XCTest

class commentActivity: activity{
    
    var date: XCUIElement {
        return app.tables.cells.containing(.staticText, identifier: "Date").staticTexts.element(boundBy: 1)
    }
    
    func create(_ details:String, dateTime:String?=nil){
        self.input(details, dateTime: dateTime)
        self.doneBtnOnCreateView.tap()
    }
    
    func edit(_ details:String, dateTime:String?=nil){
        self.input(details, dateTime: dateTime)
        self.doneBtnOnEditView.tap()
    }
    
    func input(_ details:String, dateTime:String?=nil){
        if dateTime != nil{
//            utils().handleDateTimePicker(date, dateTime: dateTime!)
        }
        self.typeDetails(details)
        snapshot("commentActivityScreen")
    }
}
