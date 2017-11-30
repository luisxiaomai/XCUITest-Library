//
//  opportunitiesList.swift
//  anwstream
//
//  Created by Lu, Luis on 08/11/2016.
//  
//

import Foundation
import XCTest

class opportunitiesList: NSObject{
    let app = utils().app
    
    var createOppBtn: XCUIElement {
        //return app.navigationBars["Opportunities"].buttons.element(boundBy: 1)
        return app.navigationBars["Opportunities"].buttons["opportunityCreateBtn"]
    }
    
    var oppFilterBtn: XCUIElement {
        //return app.navigationBars["Opportunities"].buttons.element(boundBy: 1)
        return app.navigationBars["Opportunities"].buttons["opportunityFilterBtn"]
    }
    
    var opportunitiesTitle: XCUIElement {
        return app.staticTexts["Opportunities"]
    }
    
    
    func clickCreateOppBtn(){
        createOppBtn.tap()
    }

    func clickOppFilterBtn(){
        oppFilterBtn.tap()
    }

    /**
     - parameter timeOption: Week, Month, All
    */
    func switchTimeInterval(_ timeOption:String){
        app.buttons[timeOption].tap()
    }
    
    func waitForViewDisplays(_ xcTestCase:XCTestCase) {
        utils().waitForElementToAppear(xcTestCase, opportunitiesTitle, timeout: 10)
        snapshot("opportunitiesListScreen")
    }
    
    /**
     - parameter identifier: partial matching any value displays in opportunity card
     */
    func goToDetailedView(_ identifier: String){
        let oppPartialValue = NSPredicate(format: "label CONTAINS[CD] %@",identifier)
        app.tables.cells.containing(.staticText, identifier: "Stage updated today").staticTexts.matching(oppPartialValue).element.tap()
        snapshot("opportunityDetailsScreen")
    }
}
