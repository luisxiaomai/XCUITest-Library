//
//  contact.swift
//  anwstream
//
//   on 2/9/17.
//  
//

import Foundation
import XCTest

class contact : NSObject {
    static let FIRST_NAME_LABEL : String = "First Name"
    static let LAST_NAME_LABEL : String = "Last Name"
    static let POSITION_LABEL : String = "Position"
    static let CELLPHONE_LABEL : String = "Cellphone"
    static let OFFICEPHONE_LABEL : String = "Phone"
    static let EMAIL_LABEL : String = "Email"
    static let STATUS_LABEL : String = "Status"
    
    let app = utils().app
    
    var leftMenuBtn : XCUIElement {
        return app.navigationBars.element.buttons.element(boundBy: 0)
    }
    
    var rightMenuBtn : XCUIElement {
        return app.navigationBars.matching(identifier: "Address Book").buttons.element(boundBy: 1)
    }
    
    var addAddressBtn : XCUIElement {
        return app.tables.buttons["Add Address"]
    }
    
    func cell(_ identifier: String, tableIdentifier:String? = nil) -> XCUIElement {
        let predicate = NSPredicate(format: "label CONTAINS[CD] %@",identifier)
        var table : XCUIElement;
        if (tableIdentifier == nil) {
            table = app.tables.element
        } else {
            table = app.tables[tableIdentifier!]
        }
        return table.staticTexts.matching(predicate).element
    }
    
    func btnWithText(_ text: String) -> XCUIElement{
        return app.buttons[text]
    }
    
    func swipeToAddAddress(){
        utils().swipeUpUntilElementVisible(element: contact().addAddressBtn)
        utils().swipeUp()
    }
}

class contactEdit: contact {
    var callBtn : XCUIElement {
        return self.btnWithText("Call")
    }
    
    var emailBtn : XCUIElement {
        return self.btnWithText("Email")
    }
    
    var locateBtn : XCUIElement {
        return self.btnWithText("Locate")
    }
    
    var contactInfoNavBtn : XCUIElement {
        return app.buttons["basicInfo-editBtn"]
    }
    
    var addActivityBtn : XCUIElement {
        return app.tables.buttons["Add Activity"]
    }
    
    var detailsNavBtn : XCUIElement {
        return app.otherElements["creationInfo"].buttons.element
    }
    
    var firstName : XCUIElement {
        return self.textWithLabel(contact.FIRST_NAME_LABEL)
    }
    
    var status : XCUIElement {
        return self.textWithLabel(contact.STATUS_LABEL)
    }
    
    var infoPickerCancelView : XCUIElement {
        return app.otherElements["infoPickerCancelView"]
    }
    
    func textWithLabel(_ label:String) -> XCUIElement {
        return app.tables.cells.containing(.staticText, identifier: label).staticTexts.element(boundBy: 1)
    }
    
    func verifyActivityDisplay(_ activityText:String) {
        let predicate = NSPredicate(format: "label CONTAINS[CD] %@",activityText)
        app.tables.staticTexts.matching(predicate).element.verifyExists("Can't found expected \(activityText) contact ")
    }
    
    func tapOnActivity(_ identifier: String) {
        app.tables.staticTexts[identifier].tap()
    }

    func editContactInformation(firstName:String?=nil, lastName:String?=nil, position:String?=nil, cellPhone:String?=nil, officePhone:String?=nil, email:String?=nil) {
        self.contactInfoNavBtn.tap()
        
        if ((firstName) != nil) {
            let field = app.tables.cells.containing(.staticText, identifier: contact.FIRST_NAME_LABEL).textFields.element
            field.tap()
            field.clearAndEnterText(firstName!)
            utils().handleKeyboard("Done")
        }
        
        if ((lastName) != nil) {
            let field = app.tables.cells.containing(.staticText, identifier: contact.LAST_NAME_LABEL).textFields.element
            field.tap()
            field.clearAndEnterText(lastName!)
            utils().handleKeyboard("Done")
        }
        
        if ((position) != nil) {
//            let field = app.tables.cells.containing(.staticText, identifier: "Last Name").textFields.element
//            field.tap()
//            field.typeText(lastName!)
//            utils().handleKeyboard("Done")
        }
        
        if ((cellPhone) != nil) {
            let field = app.tables.cells.containing(.staticText, identifier: contact.CELLPHONE_LABEL).textFields.element
            field.tap()
            field.clearAndEnterText(cellPhone!)
            utils().handleKeyboard("Done")
        }
        
        if ((officePhone) != nil) {
            let field = app.tables.cells.containing(.staticText, identifier: contact.OFFICEPHONE_LABEL).textFields.element
            field.tap()
            field.clearAndEnterText(officePhone!)
            utils().handleKeyboard("Done")
        }
        
        if ((email) != nil) {
            let field = app.tables.cells.containing(.staticText, identifier: contact.EMAIL_LABEL).textFields.element
            field.tap()
            field.clearAndEnterText(email!)
            utils().handleKeyboard("Done")
        }
        
        //save change
        app.buttons.element(boundBy: 1).tap()
    }
    
    func editStatus(_ status: String) {
        self.contactInfoNavBtn.tap()
        
        let statusSwitch = app.tables.cells.containing(.staticText, identifier: contact.STATUS_LABEL).staticTexts.element(boundBy: 1)
        statusSwitch.tap()
        app.pickerWheels.element.adjust(toPickerWheelValue: status)
        app.buttons["edit_confirm_btn"].tap()
        
        //save change
        app.buttons.element(boundBy: 1).tap()
    }
    
    func cellOnInfoPickerView(_ identifier: String) -> XCUIElement {
        return self.cell(identifier, tableIdentifier: "infoPickerTable")
    }
}

class contactCreate: contact {
    
    var lastName : XCUIElement {
        return self.textFieldWithLabel("Last Name")
    }
    
    override var rightMenuBtn : XCUIElement {
        return app.navigationBars.matching(identifier: "Add Contact").buttons.element(boundBy: 1)
    }
    
    func textFieldWithLabel(_ label:String) -> XCUIElement {
        return app.tables.cells.containing(.staticText, identifier: label).textFields.element
    }
    
    func selectCompany(_ identifier: String) {
        self.cell("Choose or add company").tap()
        addressBook().selectCell(identifier)
    }
    
}
