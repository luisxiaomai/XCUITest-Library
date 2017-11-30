//
//  lead.swift
//  anwstream
//
//   
//  
//

import Foundation
import XCTest

class lead: NSObject {
    static let STATUS = "Status"
    static let DESCRIPTION = "Description"
    static let SOURCE = "Source"
    static let QUALIFICATION = "Qualification"
    static let REMARKS = "Remarks"
    static let PHONE = "Phone"
    static let CELLPHONE = "Cellphone"
    static let EMAIL = "Email"
    
    let app = utils().app
    
    var leftMenuBtn: XCUIElement {
        return app.navigationBars.element.buttons.element(boundBy: 0)
    }
    
    var rightMenuBtn: XCUIElement {
        return app.navigationBars.element.buttons.element(boundBy: 1)
    }
    
    var contactEmail: XCUIElement {
        return self.buttonWithText("Email")
    }
    
    var contactCall: XCUIElement {
        return self.buttonWithText("Call")
    }
    
    var contactLocate: XCUIElement {
        return self.buttonWithText("Locate")
    }
    
    var addActivityBtn: XCUIElement {
        return self.buttonWithText("Add Activity")
    }
    
    var addAddressBtn : XCUIElement {
        return self.buttonWithText("Add Address")
    }
    
    var generalInfoNavBtn : XCUIElement {
        return self.buttonWithText("split1-editBtn")
    }
    
    var contactInfoNavBtn : XCUIElement {
        return self.buttonWithText("split2-editBtn")
    }
    
    var infoPickerCancelView : XCUIElement {
        return app.otherElements["infoPickerCancelView"]
    }
    
    var status: XCUIElement {
        return self.cell(lead.STATUS).staticTexts.element(boundBy: 2)
    }
    
    var descriptionField: XCUIElement {
        return self.textFieldWithLabel(lead.DESCRIPTION)
    }
    
    func textFieldWithLabel(_ identifier: String, index: UInt = 0) -> XCUIElement {
        return self.cell(identifier).textFields.element(boundBy: index)
    }
    
    func buttonWithText(_ identifier: String) -> XCUIElement {
        return app.buttons[identifier]
    }
    
    func swipeToActivity(){
        utils().swipeUpUntilElementVisible(element: lead().addActivityBtn)
        utils().swipeUp()
    }
    
    func swipeToAddress(){
        utils().swipeUpUntilElementVisible(element: lead().addAddressBtn)
        utils().swipeUp()
    }
    
    func cell(_ identifier: String, tableIdentifier:String? = nil) -> XCUIElement {
        let predicate = NSPredicate(format: "label CONTAINS[CD] %@",identifier)
        var table : XCUIElement;
        if (tableIdentifier == nil) {
            table = app.tables.element
        } else {
            table = app.tables[tableIdentifier!]
        }
        return table.cells.containing(predicate).element(boundBy: 0)
    }
    
    func deleteCell(_ identifier:String) {
        self.cell(identifier).swipeLeft()
        snapshot("deleteCell")
        self.cell(identifier).buttons["Delete"].tap()
    }
    
    func cellOnInfoPickerView(_ identifier: String) -> XCUIElement {
        return self.cell(identifier, tableIdentifier: "infoPickerTable")
    }
    
    func changeStatus(_ status: String) {
        self.status.tap()
        utils().handleSelectorPicker(status)
    }
    
    func textWithLabel(_ label:String) -> XCUIElement {
        return self.cell(label).staticTexts.element(boundBy: 1)
    }
    
    func editGeneralInfo(source: String?=nil, qualification: String?=nil, remarks: String?=nil
        ){
        self.generalInfoNavBtn.tap()
        if (source != nil) {
            self.cell(lead.STATUS).tap()
            utils().handleSelectorPicker(source!)
        }
        
        if (qualification != nil) {
            self.cell(lead.QUALIFICATION).tap()
            utils().handleSelectorPicker(qualification!)
        }
        
        if (remarks != nil) {
            let remarkTextView = self.cell(lead.REMARKS).textViews.element(boundBy: 0)
            remarkTextView.clearAndEnterText(remarks!, tapType: "forceTap", vector: CGVector.init(dx: 0.9, dy: 0.9))
            utils().handleKeyboard("Done")
        }
        
        //save change
        app.buttons.element(boundBy: 1).tap()
    }
    
    func editContactInfo(phone: String? = nil, cellPhone: String? = nil, email: String? = nil) {
        self.contactInfoNavBtn.tap()
        if (phone != nil) {
            let field = self.cell(lead.PHONE).textFields.element
            field.inputText(phone!)
        }
        
        if (cellPhone != nil) {
            let field = self.cell(lead.CELLPHONE).textFields.element
            field.inputText(cellPhone!)
        }
        
        if (email != nil) {
            let field = self.cell(lead.EMAIL).textFields.element
            field.inputText(email!)
        }
        
        //save change
        app.buttons.element(boundBy: 1).tap()
    }
}
