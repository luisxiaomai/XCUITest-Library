//
//  opportunitiesFilter.swift
//  anwstream
//
//  Created by Lu, Luis on 05/12/2016.
//  
//

import Foundation
import XCTest

class opportunitiesFilter: NSObject{
    let app = utils().app
    
    func selectStages(_ stagesList:Array<String>){
        //expand stags section if needed
//        var btn = app.tables.cells.containing(.staticText, identifier: "Stage").buttons.element(boundBy: 0).tap()
        for stage in stagesList{
            app.tables.cells.containing(.staticText, identifier: "Stage").staticTexts[stage].tap()
        }
    }
    
//    func selectStatus(_ status:String){
//        app.tables.cells.staticTexts[status].tap()
//    }
//    
    func selectCustomer(_ customer:String){
        app.tables.cells.containing(.staticText, identifier: "Customer").staticTexts[customer].tap()
    }
    
    func selectPotentialAmountRange(_ minMaxPotentialAmount:Array<String>){
        app.tables.cells.containing(.staticText, identifier: "Potential Amount").textFields.element(boundBy: 0).tap()
        app.tables.cells.containing(.staticText, identifier: "Potential Amount").textFields.element(boundBy: 0).typeText(minMaxPotentialAmount[0])
        app.tables.cells.containing(.staticText, identifier: "Potential Amount").textFields.element(boundBy: 1).tap()
        app.tables.cells.containing(.staticText, identifier: "Potential Amount").textFields.element(boundBy: 1).typeText(minMaxPotentialAmount[1])
        utils().handleKeyboard("Done")
    }
    
    func clickResetBtn(){
        app.buttons["resetBtn"].tap()
    }
    
    func clickApplyBtn(){
        app.buttons["applyBtn"].tap()
    }
    
    func apply(_ stageList:Array<String>?=nil,_ customer:String?=nil,_ minMaxPotentialAmount:Array<String>?=nil ) {
        if stageList != nil {
            selectStages(stageList!)
        }
//        if status != nil {
//            selectStatus(status!)
//        }
        if customer != nil {
            selectCustomer(customer!)
        }
        if minMaxPotentialAmount != nil {
            selectPotentialAmountRange(minMaxPotentialAmount!)
        }
        clickApplyBtn()
    }
   
}
