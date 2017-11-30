//
//  address.swift
//  anwstream
//
//   
//  
//

import Foundation
import XCTest

class address: NSObject {
    let app = utils().app
    
    var doneBtnOnCreateView : XCUIElement {
        return app.navigationBars["Add Address"].buttons.element(boundBy: 1)
    }
    
    var doneBtnOnEditView : XCUIElement {
        return app.buttons["edit_confirm_btn"]
    }

    var recipient : XCUIElement {
        return app.tables.cells.containing(.staticText, identifier: "Recipient").textFields.element
    }
    
    var street1 : XCUIElement {
        return app.tables.cells.containing(.staticText, identifier: "Street 1").textFields.element
    }
    
    var street2 : XCUIElement {
        return app.tables.cells.containing(.staticText, identifier: "Street 2").textFields.element
    }
    
    var city : XCUIElement {
        return app.tables.cells.containing(.staticText, identifier: "City").textFields.element
    }
    
    var state : XCUIElement {
        return app.tables.cells.containing(.staticText, identifier: "State/Province/Region").staticTexts.element(boundBy: 2)
    }
    
    var zipCode : XCUIElement {
        return app.tables.cells.containing(.staticText, identifier: "Zip Code").textFields.element
    }
    
    var country : XCUIElement {
        return app.tables.cells.containing(.staticText, identifier: "Country/Region").staticTexts.element(boundBy: 2)
    }
    
    var cellphone : XCUIElement {
        return app.tables.cells.containing(.staticText, identifier: "Cellphone").textFields.element
    }
    
    var telephone : XCUIElement {
        return app.tables.cells.containing(.staticText, identifier: "Telephone").textFields.element
    }
    
    var type : XCUIElement {
        return app.tables.cells.containing(.staticText, identifier: "Type").textFields.element
    }
    
    func createAddress(recipient: String?=nil, street1:String?=nil, street2:String?=nil, city:String?=nil, state:String?=nil, zipCode:String?=nil, country:String?=nil, cellphone:String?=nil, telephone:String?=nil, type:String?=nil) {
        self .inputAddress(recipient: recipient, street1: street1, street2: street2, city: city, state: state, zipCode: zipCode, country: country, cellphone: cellphone, telephone: telephone, type: type)
        self.doneBtnOnCreateView.tap()
    }
    
    func editAddress(recipient: String?=nil, street1:String?=nil, street2:String?=nil, city:String?=nil, state:String?=nil, zipCode:String?=nil, country:String?=nil, cellphone:String?=nil, telephone:String?=nil, type:String?=nil) {
        self .inputAddress(recipient: recipient, street1: street1, street2: street2, city: city, state: state, zipCode: zipCode, country: country, cellphone: cellphone, telephone: telephone, type: type)
        self.doneBtnOnEditView.tap()
    }
    
    func inputAddress(recipient: String?=nil, street1:String?=nil, street2:String?=nil, city:String?=nil, state:String?=nil, zipCode:String?=nil, country:String?=nil, cellphone:String?=nil, telephone:String?=nil, type:String?=nil) {
        if (recipient != nil) {
            self.recipient.inputText(recipient!)
        }
        
        if (street1 != nil) {
            self.street1.inputText(street1!)
        }
        
        if (street2 != nil) {
            self.street2.inputText(street2!)
        }
        
        if (city != nil) {
            self.city.inputText(city!)
        }
        
        if (country != nil) {
            self.country.tap()
            app.pickerWheels.element.adjust(toPickerWheelValue: country!)
            app.toolbars.buttons.element.tap()
        }
        
        if (state != nil) {
            self.state.tap()
            app.pickerWheels.element.adjust(toPickerWheelValue: state!)
            app.toolbars.buttons.element.tap()
        }
        
        if (zipCode != nil) {
            self.zipCode.inputText(zipCode!)
        }
        
        if (cellphone != nil) {
            self.cellphone.inputText(cellphone!)
        }
        
        if (telephone != nil) {
            self.telephone.inputText(telephone!)
        }
        
        if (type != nil) {
            utils().swipeUp()
            self.type.inputText(type!)
        }
    }
    
    func verifyDisplay (recipient: String?=nil, street1:String?=nil, street2:String?=nil, city:String?=nil, state:String?=nil, zipCode:String?=nil, country:String?=nil, cellphone:String?=nil, telephone:String?=nil, type:String?=nil) {
        if (recipient != nil) {
            self.recipient.verifyTextValue(value: recipient!)
        }
        
        if (street1 != nil) {
            self.street1.verifyTextValue(value: street1!)
        }
        
        if (street2 != nil) {
            self.street2.verifyTextValue(value: street2!)
        }
        
        if (city != nil) {
            self.city.verifyTextValue(value: city!)
        }
        
        if (state  != nil) {
            self.state.verifyLabel(label: state!)
        }
        
        if (zipCode != nil) {
            self.zipCode.verifyTextValue(value: zipCode!)
        }
        
        if (country != nil) {
            self.country.verifyLabel(label: country!)
        }
        
        if (cellphone != nil) {
            self.cellphone.verifyTextValue(value: cellphone!)
        }
        
        if (telephone != nil) {
            self.telephone.verifyTextValue(value: telephone!)
        }
        
        if (type != nil) {
            self.type.verifyTextValue(value: type!)
        }
    }
}
