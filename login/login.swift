//
//  login.swift
//  anwstream
//
//  Created by Lu, Luis on 07/11/2016.
//  
//


import Foundation
import XCTest

class login: NSObject{
    let app = utils().app
    
    var userNameField: XCUIElement {
        //return app.otherElements.matching(identifier: "user_email").children(matching: .textField).element
        return app.textFields.element
    }
    
    var passwordField: XCUIElement {
        //return app.otherElements.matching(identifier: "user_password").children(matching: .secureTextField).element
        return app.secureTextFields.element
    }
    
    var loginButton: XCUIElement {
        return app.buttons["Login"]
    }
    
    var switchServerLink: XCUIElement {
        return app.buttons["switch environment"]
    }
    
    func typeUserName(_ userName: String) {
        userNameField.clearAndEnterText(userName)
    }
    
    func typePassword(_ password: String) {
        passwordField.clearAndEnterText(password)
    }

    func switchServer(_ serverAddress: String){
        switchServerLink.tap()
        app.cells.staticTexts[serverAddress].tap()
    }
    
    func submitLogin(){
        loginButton.tap()
    }
    
    func normalLogin(_ serverAddress: String, _ userName: String?=nil, _ password: String?=nil){
        switchServer(serverAddress)
        snapshot("loginScreen")
        if serverAddress != "Test"{
            typeUserName(userName!)
            typePassword(password!)
        }
        submitLogin()
    }
    
    func waitForViewDisplays(_ xcTestCase:XCTestCase){
        utils().waitForElementToAppear(xcTestCase,userNameField)
    }
    
}
