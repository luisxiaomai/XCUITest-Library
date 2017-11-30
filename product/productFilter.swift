//
//  productFilter.swift
//  anwstream
//
//  
//  
//

import Foundation
import XCTest

class productFilter: NSObject{
    let app = utils().app;
    
    func clickResetBtn(){
        app.buttons["resetBtn"].tap()
    }
    
    func clickApplyBtn(){
        app.buttons["applyBtn"].tap()
    }
    
    func apply(_ category:String?=nil, _ brand:String?=nil, _ priceRange:Array<String>?=nil) {
        if category != nil {
            selectCategory(category!);
        }
        if brand != nil {
            selectBrand(brand!);
        }
        if priceRange != nil {
            setPriceRange(priceRange!);
        }
        clickApplyBtn();
    }

    func selectCategory(_ category:String) {
        app.tables.cells.containing(.staticText, identifier: "Category").staticTexts[category].tap();
    }
    
    func selectBrand(_ brand:String) {
        app.tables.cells.containing(.staticText, identifier: "Brand").staticTexts[brand].tap();
    }
    
    func setPriceRange(_ priceRange:Array<String>){
        app.tables.cells.containing(.staticText, identifier: "Price Range").textFields.element(boundBy: 0).tap();
        app.tables.cells.containing(.staticText, identifier: "Price Range").textFields.element(boundBy: 0).typeText(priceRange[0]);
        app.tables.cells.containing(.staticText, identifier: "Price Range").textFields.element(boundBy: 1).tap();
        app.tables.cells.containing(.staticText, identifier: "Price Range").textFields.element(boundBy: 1).typeText(priceRange[1]);
        utils().handleKeyboard("Done");
    }
    
}
