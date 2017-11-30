//
//  productList
//  anwstream
//
//  
//  
//

import Foundation
import XCTest

class productList : NSObject {
    
    let app = utils().app;
    
    var leftMenuBtn : XCUIElement {
        return app.navigationBars.element.buttons.element(boundBy: 0)
    }
    
    var filterBtn: XCUIElement {
        return app.navigationBars["Products"].buttons["productFilterBtn"];
    }
    
    func clickFilterBtn(){
        filterBtn.tap();
    }
    
    func findProductCell(_ identifier: String) -> XCUIElementQuery {
        return app.tables.cells.containing(.staticText, identifier: identifier);
    }
    
    func goToDetailedView(_ name: String) {
        app.staticTexts[name].forceTap();
    }
    
    func verifyProductExisting(_ identifier:String, _ isExisting:Bool) {
        let productCell = productList().findProductCell(identifier);
        if(isExisting == true){
            XCTAssertNotEqual(productCell.count, 0);
        }else{
            XCTAssertEqual(productCell.count, 0);
        }
        
    }

}
