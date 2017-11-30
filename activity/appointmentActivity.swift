//
//  appointmentActivity.swift
//  anwstream
//
//  Created by Lu, Luis on 09/11/2016.
//  
//

import Foundation
import XCTest

class appointmentActivity: activity{
    
    var subjectField: XCUIElement {
        return app.tables.cells.containing(.staticText, identifier: "Subject").textFields.element
    }
    
    var startDateSelector:XCUIElement{
        return app.tables.cells.containing(.staticText, identifier: "Start Date").staticTexts.element(boundBy: 1)
    }
    
    var endDatesSelector:XCUIElement{
        return app.tables.cells.containing(.staticText, identifier: "End Date").staticTexts.element(boundBy: 1)
    }
    
    var reminderMeSelector:XCUIElement{
        return app.tables.cells.containing(.staticText, identifier: "Remeber me").staticTexts.element(boundBy: 1)
    }
    
    var addAttendeeBtn:XCUIElement{
        return app.tables.buttons["Add Attendee"]
    }
    
    var confirmAddressBtn:XCUIElement{
        return app.buttons["confirm_address"]
    }
    
    var addLocationBtn:XCUIElement{
        return app.tables.buttons["Add Location"]
    }
    
    func typeSubject(_ subjectInfo:String){
        utils().swipeUp()
        subjectField.tap()
        subjectField.typeText(subjectInfo)
        utils().handleKeyboard("Done")
    }
    
    func selectReminderMe(_ reminderRule:String){
        reminderMeSelector.tap()
        app.pickerWheels.element.adjust(toPickerWheelValue: reminderRule)
    }
    
    func addAttendee(_ attendeeList:Array<String>){
        addAttendeeBtn.tap()
        if (!app.textFields["anwSearchField"].exists) {
            addAttendeeBtn.tap()
        }
        for attendee in attendeeList{
            app.textFields["anwSearchField"].clearAndEnterText(attendee)
            app.tables.cells.containing(.staticText, identifier: attendee).element.forceTap()
        }
        addressBook().createBtn.tap()
        snapshot("addAttendeeScreen")
        verifyAttendeeDisplays(attendeeList)
    }
    
    func addLocation(_ locationInfo:String){
        app.tables.element.swipeUp()
        addLocationBtn.tap()
        
        if (!app.textFields["Enter the location"].exists) {
            addLocationBtn.tap()
        }
        app.textFields["Enter the location"].tap()
        app.textFields["Enter the location"].typeText(locationInfo)
        //utils().handleKeyboard("Done")
        confirmAddressBtn.tap()
        verifyLocationDisplays(locationInfo)
    }
    
    func add(_ subject:String, _ details:String, startDate:String?=nil, endDate:String?=nil, reminderMeRule:String?=nil, attendeeList:Array<String>?=nil, location:String?=nil){
        self.switchType("Appointment")
        snapshot("addAppointmentActivityScreen1")
        typeSubject(subject)
        if startDate != nil {
            utils().handleDateTimePicker(startDateSelector, dateTime: startDate!)
        }
        if endDate != nil {
            utils().handleDateTimePicker(endDatesSelector,dateTime: endDate!)
        }
        if reminderMeRule != nil {
            selectReminderMe(reminderMeRule!)
        }
        if attendeeList != nil {
            utils().swipeDown()
            addAttendee(attendeeList!)
        }
        if let realLocation=location {
            addLocation(realLocation)
        }
        self.typeDetails(details)
        snapshot("addAppointmentActivityScreen2")
        self.doneBtnOnCreateView.tap()
        app.navigationBars.element.tap() // workaround to interact with the app again for the alert handler to fire
    }
    
    /**
     - parameter attendeeList: attendee list need verify in activity page
     */
    func verifyAttendeeDisplays(_ attendeeList:Array<String>){
        for attendee in attendeeList{
            let attendeePartialValue = NSPredicate(format: "label CONTAINS[CD] %@",attendee)
            app.tables.staticTexts.matching(attendeePartialValue).element.verifyExists("Can't found expected \(attendee) attendee ");
        }
    }
    
    func verifyLocationDisplays(_ location:String){
        let locationPartialValue = NSPredicate(format: "label CONTAINS[CD] %@",location)
        app.tables.staticTexts.matching(locationPartialValue).element.verifyExists("Can't found expected \(location) location ")
    }
    
}
