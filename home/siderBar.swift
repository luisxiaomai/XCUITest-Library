//
//  siderBar.swift
//  anwstream
//
//  Created by Lu, Luis on 10/11/2016.
//  
//

import Foundation
import XCTest


class siderBar: NSObject{
    
    let app = utils().app
    
    var homeMenuBtn: XCUIElement {
        return app.navigationBars.buttons.element(boundBy: 0)
    }
    
    var homeMenuBtnInHome: XCUIElement {
        return app.buttons["home_menu"]
    }
    
    /**
     - parameter boName: Home, Contacts, Products, Opportunities, Activities, Pipeline Overview, Sales Outlook, Settings, Sync, Logout
     */
    func navigateToBO(_ boName: String) {
        homeMenuBtn.forceTap()
        snapshot("siderBarMenuScreen")
        app.tables.staticTexts[boName].tap()
    }
    
    func logout(){
        navigateToBO("Settings")
        settings().navigate("My Profile")
        settings().btnWithText("Log Out")
        app.tap() // workaround to interact with the app again for the alter handler to fire
    }

}
