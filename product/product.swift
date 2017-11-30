//
//  product.swift
//  anwstream
//
//  
//  
//

import Foundation
import XCTest

class product : NSObject {

    let app = utils().app;
    
    func waitForViewDisplays(_ xcTestCase:XCTestCase, _ label: String) {
        let labelControl = app.staticTexts[label];
        utils().waitForElementToAppear(xcTestCase, labelControl, timeout: 10);
    }

    /**
     * verify cell value, layout structure should like below
     * [Cell]
     *     [StaticText] - cellName
     *     [StaticText] - value
     */
    func verifyCellValue(_ cellName:String, _ value: String) {
        app.tables.cells.containing(.staticText, identifier: cellName).staticTexts[value].verifyExists("\(cellName) value \(value) is not correct");
    }
    
}

