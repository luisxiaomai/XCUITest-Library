//
//  home.swift
//  anwstream
//
//  Created by Lu, Luis on 08/11/2016.
//  
//

import Foundation
import XCTest

class home: NSObject{
    let app = utils().app
    
    var searchButton: XCUIElement {
        return app.navigationBars.buttons.element(boundBy: 1)
        //return app.buttons["search_button"]
    }
    
    var homeTitle: XCUIElement {
        return app.navigationBars["home_nav_bar"]
    }

    func waitForViewDisplays(_ xcTestCase:XCTestCase) {
        utils().waitForElementToAppear(xcTestCase, homeTitle, timeout: 10)
        snapshot("homeScreen")
    }

    func verifyCardExisting(_ label: String) {
        let card = app.staticTexts[label];
        XCTAssertNotNil(card);
    }
    
}
