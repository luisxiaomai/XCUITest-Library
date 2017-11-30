//
//  leadsFilter.swift
//  anwstream
//
//   
//  
//

import Foundation
import XCTest

class leadsFilter : NSObject {
    let app = utils().app
    
    var filterBtn : XCUIElement {
        return app.buttons["Filter"]
    }
    
    var sortTabBtn : XCUIElement {
        return app.buttons["Sort"]
    }
    
    var filterTable : XCUIElement {
        return app.tables["filterTable"]
    }
    
    var sortTable : XCUIElement {
        return app.tables["sortTable"]
    }
    
    var resetBtn : XCUIElement {
        return app.buttons["Reset"]
    }
    
    var applyBtn : XCUIElement {
        return app.buttons["Apply"]
    }
    
    func filterValue(_ categoryName: String, value: String) -> XCUIElement {
        return self.filterTable.cells.containing(.staticText, identifier: categoryName).staticTexts[value]
    }
    
    func applyFilter(owner: String?=nil, statuses: NSArray?=nil, qualification: String?=nil) {
        if (owner != nil) {
            filterValue("Owner", value: owner!).tap()
        }
        
        if (statuses != nil) {
            for statusValue in statuses! {
                filterValue("Status", value: statusValue as! String).tap()
            }
        }
        
        if (qualification != nil) {
            filterValue("Qualification", value: qualification!).tap()
        }
        
        self.applyBtn.tap()
    }
}
