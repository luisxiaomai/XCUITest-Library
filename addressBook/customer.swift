//
//  corporateCustomer.swift
//  anwstream
//
//   on 2/9/17.
//  
//

import Foundation
import XCTest

class customer: NSObject {
    static let CORPORATE_NAME = "Corporate Name"
    static let OFFICE_PHONE = "Office Phone"
    static let EMAIL = "Email"
    static let WEBSITE = "Website"
    static let STATUS = "Status"
    static let FIRST_NAME = "First Name"
    static let LAST_NAME = "Last Name"
    static let POSITION = "Position"
    static let COMPANY = "Company"
    static let CELLPHONE = "Cellphone"
    
    let app = utils().app
    
    var leftMenuBtn: XCUIElement {
        return app.navigationBars.element.buttons.element(boundBy: 0)
    }
    
    var rightMenuBtn: XCUIElement {
        return app.navigationBars.element.buttons.element(boundBy: 1)
    }
    
    var addAddressBtn : XCUIElement {
        return app.tables.buttons["Add Address"]
    }
    
    var status: XCUIElement {
        return app.tables.cells.containing(.staticText, identifier: customer.STATUS).staticTexts.element(boundBy: 1)
    }
    
    func cell(_ identifier: String, tableIdentifier:String? = nil) -> XCUIElement {
        let predicate = NSPredicate(format: "label CONTAINS[CD] %@",identifier)
        var table : XCUIElement;
        if (tableIdentifier == nil) {
            table = app.tables.element
        } else {
            table = app.tables[tableIdentifier!]
        }
        return table.staticTexts.matching(predicate).element(boundBy: 0)
    }
    
    func textWithLabel(_ label:String) -> XCUIElement {
        return app.tables.cells.containing(.staticText, identifier: label).staticTexts.element(boundBy: 1)
    }
    
    func deleteCell(_ identifier:String) {
        self.cell(identifier).swipeLeft()
        snapshot("deleteCell")
        app.tables.cells.containing(.staticText, identifier: identifier).buttons["Delete"].tap()
    }
    
    func textFieldWithLabel(_ label:String) -> XCUIElement {
        return app.tables.cells.containing(.staticText, identifier: label).textFields.element
    }
    
    func swipeToActivity(){
        utils().swipeUpUntilElementVisible(element: customerEdit().addActivityBtn)
        utils().swipeUp()
    }
    
    func swipeToAddress(){
        utils().swipeUpUntilElementVisible(element: customerEdit().addAddressBtn)
        utils().swipeUp()
    }
}

class customerEdit: customer {
    
    var callBtn : XCUIElement {
        return self.btnWithText("Call")
    }
    
    var emailBtn : XCUIElement {
        return self.btnWithText("Email")
    }
    
    var locateBtn : XCUIElement {
        return self.btnWithText("Locate")
    }
    
    var relatedContactsCell : XCUIElement {
        return app.tables.staticTexts["Related Contacts"]
    }
    
    var generalInfoNavBtn : XCUIElement {
        return app.buttons["split1-editBtn"]
    }
    
    var contactInfoNavBtn : XCUIElement {
        return app.buttons["split2-editBtn"]
    }
    
    var addActivityBtn : XCUIElement {
        return app.tables.buttons["Add Activity"]
    }
    
    var detailsNavBtn : XCUIElement {
        return app.otherElements["creationInfo"].buttons.element
    }
    
    var infoPickerCancelView : XCUIElement {
        return app.otherElements["infoPickerCancelView"]
    }
    
    func mainContactCell(_ identifier:String) -> XCUIElement {
        let predicate = NSPredicate(format: "label CONTAINS[CD] %@",identifier)
        return app.tables.staticTexts.matching(predicate).element
    }

    func btnWithText(_ text: String) -> XCUIElement{
        return app.buttons[text]
    }
    
    func changeMainContactTo(_ identifier:String) {
//        self.relatedContactsCell.tap()
//        relatedContacts().setMainContact(identifier)
//        relatedContacts().leftMenuBtn.tap()
        self.rightMenuBtn.tap()
        app.buttons["Change Main Contact"].tap()
        relatedContacts().contactCell(identifier).tap()
    }
    
    func editCorporateContactInfo(name:String?=nil, officePhone:String?=nil, email:String?=nil, website:String?=nil) {
        self.generalInfoNavBtn.tap()
        
        if ((name) != nil) {
            let field = self.textFieldWithLabel(customer.CORPORATE_NAME)
            field.inputText(name!)
        }
        
        if ((officePhone) != nil) {
            let field = self.textFieldWithLabel(customer.OFFICE_PHONE)
            field.inputText(officePhone!)
        }
        
        if ((email) != nil) {
            let field = self.textFieldWithLabel(customer.EMAIL)
            field.inputText(email!)
        }
        
        if ((website) != nil) {
            let field = self.textFieldWithLabel(customer.WEBSITE)
            field.inputText(website!)
        }
        
        //save change
        app.buttons.element(boundBy: 1).tap()
    }
    
    func editIndividualGeneralInfo(firstName:String?=nil, lastName:String?=nil, position:String?=nil, company:String?=nil) {
        self.generalInfoNavBtn.tap()
        
        if ((firstName) != nil) {
            let field = self.textFieldWithLabel(customer.FIRST_NAME)
            field.inputText(firstName!)
        }
        
        if ((lastName) != nil) {
            let field = self.textFieldWithLabel(customer.LAST_NAME)
            field.inputText(lastName!)
        }
        
        if (position != nil) {
            
        }
        
        if ((company) != nil) {
            let field = self.textFieldWithLabel(customer.COMPANY)
            field.inputText(company!)
        }
        
        //save change
        app.buttons.element(boundBy: 1).tap()
    }
    
    func editIndividualContactInfo(cellPhone:String?=nil, officePhone:String?=nil, email:String?=nil, website:String?=nil) {
        self.contactInfoNavBtn.tap()
        
        if ((cellPhone) != nil) {
            let field = self.textFieldWithLabel(customer.CELLPHONE)
            field.inputText(cellPhone!)
        }
        
        if ((officePhone) != nil) {
            let field = self.textFieldWithLabel(customer.OFFICE_PHONE)
            field.inputText(officePhone!)
        }
        
        if ((email) != nil) {
            let field = self.textFieldWithLabel(customer.EMAIL)
            field.inputText(email!)
        }
        
        if ((website) != nil) {
            let field = self.textFieldWithLabel(customer.WEBSITE)
            field.inputText(website!)
        }
        
        //save change
        app.buttons.element(boundBy: 1).tap()
    }
    
    func editStatus(_ status: String) {
        self.generalInfoNavBtn.tap()
        
        let statusSwitch = app.tables.cells.containing(.staticText, identifier: customer.STATUS).staticTexts.element(boundBy: 1)
        statusSwitch.tap()
        app.pickerWheels.element.adjust(toPickerWheelValue: status)
        app.buttons["picker_confirm"].tap()
        
        //save change
        app.buttons["edit_confirm_btn"].tap()
    }
    
    func createOpportunity() {
        self.rightMenuBtn.tap()
        self.btnWithText("Create Opportunity").tap()
    }
    
    func cellOnInfoPickerView(_ identifier: String) -> XCUIElement {
        return self.cell(identifier, tableIdentifier: "infoPickerTable")
    }
}

class customerCreate : customer {
    var corporateName : XCUIElement {
        return self.textFieldWithLabel(customer.CORPORATE_NAME)
    }
}


