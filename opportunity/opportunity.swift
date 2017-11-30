     //
//  opportunitiesDetails.swift
//  anwstream
//
//  Created by Lu, Luis on 08/11/2016.
//  
//

import Foundation
import XCTest

class opportunity: NSObject{
    let app = utils().app
    
    var leftMenuBtn: XCUIElement {
        return app.navigationBars.element.buttons.element(boundBy: 0)
    }
    
    var rightMenuBtn: XCUIElement {
        return app.navigationBars.element.buttons.element(boundBy: 1)
    }
    
    var contactEmail: XCUIElement {
        return app.buttons["Email"]
    }
    var contactCall: XCUIElement {
        return app.buttons["Call"]
    }
    var contactLocate: XCUIElement {
        return app.buttons["Locate"]
    }
    
    var addActivityBtn: XCUIElement {
        return app.tables.buttons["Add Activity"]
    }
    
    var addProductBtn: XCUIElement {
        return app.tables.buttons["Add Product"]
    }
    var status: XCUIElement {
        return app.tables.cells.containing(.staticText, identifier: "Status").staticTexts.element(boundBy: 2)
    }
    
    var stage: XCUIElement {
        return app.tables.cells.containing(.staticText, identifier: "Stage").staticTexts.element(boundBy: 2)
    }
    
    var oppInformationNavBtn: XCUIElement {
        return app.otherElements.containing(.staticText, identifier: "Basic Information").children(matching: .button).element
    }
    
    var infoPickerCancelView : XCUIElement {
        return app.otherElements["infoPickerCancelView"]
    }
    
    func changeStage(_ stage:String){
        self.stage.tap()
        if (!app.tables.staticTexts.matching(identifier: stage).element.exists) {
            self.stage.tap()
        }
        app.tables.staticTexts.matching(identifier: stage).element(boundBy: 0).tap()
        app.buttons.element(boundBy: 1).tap()
    }
    
    func changeStatus(_ status:String, reason:String){
        self.status.tap()
        if (!app.tables.staticTexts.matching(identifier: status).element.exists) {
            self.status.tap()
        }
        app.tables.staticTexts.matching(identifier: status).element(boundBy: 0).tap()
        app.buttons.element(boundBy: 1).tap()
        app.tables.staticTexts.matching(identifier: reason).element(boundBy: 0).tap()
        app.buttons.element(boundBy: 1).tap()
    }
    
    func editInformation(_ potentialAmount:String?=nil, startDate:String?=nil, closingPercentage:String?=nil){
        self.oppInformationNavBtn.tap()
        if startDate != nil {
            utils().handleDatePicker(app.tables.cells.containing(.staticText, identifier: "Start Date").staticTexts.element(boundBy: 1) , date: startDate!)
        }
        if potentialAmount != nil {
            app.tables.cells.containing(.staticText, identifier: "Potential Amount").textFields.element.tap()
            app.tables.cells.containing(.staticText, identifier: "Potential Amount").textFields.element.typeText(potentialAmount!)
            utils().handleKeyboard("Done")
        }
        
        if closingPercentage != nil {
            app.tables.cells.containing(.staticText, identifier: "Closing Percentage").textFields.element.tap()
            app.tables.cells.containing(.staticText, identifier: "Closing Percentage").textFields.element.typeText(closingPercentage!)
            utils().handleKeyboard("Done")
        }
        app.buttons.element(boundBy: 1).tap()
    }
    

    func delActivity(_ activityList:Array<String>){
        opportunity().scrollToCreateActivity()
        for oneActivity in activityList {
            let activity = app.tables.cells.staticTexts[oneActivity]
            activity.swipeLeft()
            snapshot("deleteActivityScreen1")
//            let start = activity.coordinate(withNormalizedOffset:CGVector(dx: 0, dy: 0))
//            let finish = activity.coordinate(withNormalizedOffset:CGVector(dx: -60, dy: 0))
//            start.press(forDuration: 0, thenDragTo: finish)
            app.tables.cells.containing(.staticText, identifier: oneActivity).buttons["Delete"].tap()
        }
    }
    
    func delProduct(_ productList:Array<String>){
        for oneProduct in productList {
            let product = app.tables.cells.staticTexts[oneProduct]
            product.swipeLeft()
            app.tables.cells.containing(.staticText, identifier: oneProduct).buttons["Delete"].tap()
        }
    }
    

    
    func addProduct(_ productName:String, unitPrice:String?=nil, quantity:String?=nil, discount:String?=nil){
        addProductBtn.tap()
        //app.searchFields["Search"].forceTap()
        //app.searchFields["Search"].typeText(productName)
        //utils().handleKeyboard("Search")
        app.tables.cells.staticTexts[productName].forceTap()
//        
//        if unitPrice != nil {
//            app.textFields["unitPriceField"].clearAndEnterText(unitPrice!, tapType: "forceTap")
//            utils().handleKeyboard("Done")
//        }
//        
//        if quantity != nil {
//            app.textFields["quantityField"].forceTap()
//            app.textFields["quantityField"].clearAndEnterText(quantity!)
//            utils().handleKeyboard("Done")
//        }
//        
//        if discount != nil {
//            app.textFields["discountField"].forceTap()
//            app.textFields["discountField"].clearAndEnterText(discount!)
//            utils().handleKeyboard("Done")
//        }
//        
//        let expectedTotal:String = app.textFields["unitPriceField"].value as! String
//        XCTAssertTrue(expectedTotal == app.staticTexts["totalMoney"].label, "Total money \(status) is not correct")

        app.buttons["Add to Opportunity"].tap()
        app.navigationBars.buttons.element(boundBy: 0).tap()
        app.navigationBars.buttons.element(boundBy: 0).tap()
()
    }
    
    
    
    /**
     - parameter SKUsArrayList: format sku name + total as one array record in a multidimensional arrays.
     e.g [["abc","¥100"],["ddd","¥200"]]
     */
    func verifySKUsDisplay(_ SKUsArrayList:Array<Array<String>>){
        for sku in SKUsArrayList {
            for item in sku {
                app.tables.cells.staticTexts[item].verifyExists()
            }
        }
    }
    
    func verifySKUsDisapper(_ SKUList:Array<String>){
        for sku in SKUList{
            app.tables.staticTexts[sku].verifyNotExists("SKU \(sku) should not exists ")
        }
        
    }

    func verifySKUTotal(_ total:String){
        app.tables.cells.containing(.staticText, identifier: "Total").staticTexts[total].verifyExists("Total \(total) money is not correct ")
    }
    
    /**
     - parameter identifier: partial matching any value displays in opportunity detailed view
     */
    func verifyActivityDisplays(_ activityText:String){
        let activityPartialValue = NSPredicate(format: "label CONTAINS[CD] %@",activityText)
        app.tables.staticTexts.matching(activityPartialValue).element.verifyExists("Can't found expected \(activityText) opportunity ")
    }
    
    func verifyActivityDisappers(_ activityText:String){
        let activityPartialValue = NSPredicate(format: "label CONTAINS[CD] %@",activityText)
        app.tables.staticTexts.matching(activityPartialValue).element.verifyNotExists("Activity \(activityText) should not exists ")
    }

    
    func verifyWeightAmount(_ weightAmount:String){
        app.tables.cells.containing(.staticText, identifier: "Weighted Amount").staticTexts[weightAmount].verifyExists("WeightAmount \(weightAmount) is not correct")
    }
    
    
    func verifyStatus(_ status:String){
        XCTAssertTrue(status==self.status.label, "Current status \(status) is not correct")
    }
    
    func verifyStage(_ stage:String){
        XCTAssertTrue(stage==self.stage.label, "Current stage \(stage) is not correct")

    }
    
    private func cellOnInfoPickerView(_ identifier: String) -> XCUIElement {
        return self.cell(identifier, tableIdentifier: "infoPickerTable")
    }
    
    private func cell(_ identifier: String, tableIdentifier:String? = nil) -> XCUIElement {
        let predicate = NSPredicate(format: "label CONTAINS[CD] %@",identifier)
        var table : XCUIElement;
        if (tableIdentifier == nil) {
            table = app.tables.element
        } else {
            table = app.tables[tableIdentifier!]
        }
        return table.staticTexts.matching(predicate).element
    }
    
    func verifyContactCall(_ callList:Array<String>?=nil){
        if self.contactCall.isEnabled == true && callList != nil {
            self.contactCall.tap()
            for call in callList!{
                self.cellOnInfoPickerView(call).verifyExists("Call \(call) doesn't display")
            }
        }
        self.infoPickerCancelView.tap()
    }
    
    func verifyContactEmail(_ email:String?=nil){
        if self.contactEmail.isEnabled == true && email != nil {
            self.contactEmail.tap()
            self.cellOnInfoPickerView(email!).verifyExists("Email \(email) doesn't display")
        }
        self.infoPickerCancelView.tap()
    }
    
    func verifyContactLocate(_ locate:String?=nil){
        if self.contactLocate.isEnabled == true && locate != nil {
            self.contactLocate.tap()
            self.cellOnInfoPickerView(locate!).verifyExists("Locate \(locate) doesn't display")
        }
        self.infoPickerCancelView.tap()
    }
    
    func scrollToCreateActivity(){
        utils().swipeUpUntilElementVisible(element: opportunity().addActivityBtn)
        utils().swipeUp()
    }
    
   
}
