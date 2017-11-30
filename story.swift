//
//  Story.swift
//  anwstream
//
//  Created by Lu, Luis on 07/11/2016.
//  
//

import XCTest

class story: XCTestCase {
    
    var systemAlertMonitorToken: NSObjectProtocol? = nil

    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let app = utils().app
        app.launchArguments = ["UI-TESTING"]
        setupSnapshot(app)
        print(app.launchArguments)
        app.launch()
        systemAlertMonitorToken = self.addUIInterruptionMonitor(withDescription: "HandleAlert") { (alert) -> Bool in
            if alert.buttons["OK"].exists  {
                alert.buttons["OK"].tap()
                return true
            } else if  alert.buttons["Ok"].exists {
                alert.buttons["Ok"].tap()
                return true
            } else {
                return false
            }
        }
    }
    
    override func tearDown() {
        if let systemAlertMonitorToken = self.systemAlertMonitorToken {
            removeUIInterruptionMonitor(systemAlertMonitorToken)
        }
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    private func loginAndGoToList(_ listName:String) {
        //login
        login().normalLogin("Test")
        home().waitForViewDisplays(self)
        
        //navigate to list
        if(!listName.isEmpty){
            siderBar().navigateToBO(listName);
        }
    }
    
    private func logout() {
        siderBar().logout()
        login().waitForViewDisplays(self)
    }
    
    func testOpportunity() {
        self.loginAndGoToList("Opportunities")
        
        opportunitiesList().waitForViewDisplays(self)
        opportunitiesList().switchTimeInterval("All")
        opportunitiesList().clickOppFilterBtn()
        opportunitiesFilter().apply(["评估销售机会"], "James Leung", ["0","100"])
        opportunitiesList().goToDetailedView("James Leung")
        
        // Verify customer information in opportunity
        opportunity().verifyContactCall(["234567","123456"])
        opportunity().verifyContactEmail("test@126.com")
        opportunity().verifyContactLocate("chenhui road 1001")
        
        // Edit opportunity information
        opportunity().editInformation("10000", closingPercentage: "95")
        utils().app.tables.element.swipeUp()
        opportunity().verifyWeightAmount("¥9,500.00")
        
//        // Add one product
//        utils().app.tables.element.swipeUp()
//        opportunity().addProduct("abc", unitPrice: "10", quantity: "20", discount: "5")
//        opportunity().verifySKUsDisplay([["abc-Green","¥100"]])
//        opportunity().verifySKUTotal("¥100")
//        
//        // delete one product
//        opportunity().delProduct(["abc-Green"])
//        opportunity().verifySKUsDisapper(["abc-Green"])
        
        //Add one comment activity
        opportunity().scrollToCreateActivity()
        opportunity().addActivityBtn.tap()
        commentActivity().create("commentTest")
        opportunity().verifyActivityDisplays("commentTest")
        
        //Add one call activity
        opportunity().scrollToCreateActivity()
        opportunity().addActivityBtn.tap()
        callActivity().create("CallTest")
        opportunity().verifyActivityDisplays("CallTest")
        
        //Add one appointment activity
        opportunity().addActivityBtn.tap()
        appointmentActivity().add("11.11 meeting", "AppointmentTest",attendeeList:["Doe Jane"],location:"PVG03 B1.1")
        opportunity().verifyActivityDisplays("11.11 meeting")
        
        // Delete one activity
        opportunity().delActivity(["11.11 meeting"])
        opportunity().verifyActivityDisappers("11.11")
        
        //Edit opportunity stage, status 
        utils().app.tables.element.swipeDown()
        opportunity().changeStage("销售订单")
        opportunity().verifyStage("销售订单")
        opportunity().changeStatus("Won", reason: "None")
        opportunity().verifyStatus("Won")

        //Logout
        opportunity().leftMenuBtn.tap()
        self.logout()
    }
    
    
    /**
     * equals /api/mobile/Employees/v1/me => get me
     * equals /api/mobile/Employees/v1 => get all employees, for sync employee coredate
     * startsWith /api/mobile/Employees/v1/{10086} => get single employee by id, used by user
     */
    func testSettings() {
        self.loginAndGoToList("Settings")
        
        //change profile
        settings().navigate("My Profile");
        profile().editBtn.tap();
        profile().textFieldWithLabel("Position").inputText("UI Tester");
        let cellPhone = "123";
        profile().textFieldWithLabel("Cellphone").inputText(cellPhone);
        profile().saveBtn.tap()
        profile().textWithLabel("Cellphone").verifyLabel(label: cellPhone);
        profile().backBtn.tap()
        
        //change device sync settings
        //Navigate to settings view
        settings().navigate("Device Sync Settings");
        settings().toggleSwitch(key: "Sync appointments")
        settings().toggleSwitch(key: "Sync opportunities")
        settings().toggleSwitch(key: "Sync reminders")
        settings().backBtn.tap()
        
        //change default reminder time
        //verify in activity form
        settings().navigate("Default Reminder Time");
        settings().tapRow("30 minutes before");
        settings().backBtn.tap()
        
        //logout
        self.logout()
    }
    
    func testEditContact() {
        self.loginAndGoToList(addressBook.ADDRESS_BOOK_LIST_NAME)
        
        //search and navigate to contact detail form
        utils().swipeDown()
        addressBook().searchAndGoToDetail("Contact A")
        
        //click call btn
        contactEdit().callBtn.tap()
        contactEdit().cellOnInfoPickerView("23456789").tap()
//        //check if activity with type call generated
//        utils().app.tables.element.swipeUp()
//        let callMsg = "Called 23456789."
//        contactEdit().verifyActivityDisplay(callMsg)
//        //click to open activity to check activity type
//        contactEdit().tapOnActivity(callMsg)
//        //verify activity type
//        callActivity().verifyType()
//        callActivity().backBtnOnEditView.tap()
//        
//        //swipe up to click email btn
//        utils().swipeDown()
        contactEdit().emailBtn.tap()
        let emailCell = contactEdit().cellOnInfoPickerView("a.contact@126.com")
        emailCell.verifyExists("Email btn existed");
        contactEdit().infoPickerCancelView.tap()
        
        //check status of locate btn
        contactEdit().locateBtn.verifyDisabled()
        
        //go to company cell
        let companyCell = contactEdit().cell("xd@xd.com")
        companyCell.verifyExists("Company exists")
        companyCell.tap()
        customerEdit().leftMenuBtn.tap()
        
        //edit contact information
        let firstNameStr = "FirstNAME"
        contactEdit().editContactInformation(firstName: firstNameStr)
        contactEdit().firstName.verifyLabel(label: firstNameStr, message: "Firstname not match \(firstNameStr)")
        
        //add address
        contact().swipeToAddAddress()
        contact().addAddressBtn.smartTap()
        let recipient = "ABC"
        let street1 = "Street1"
        let street2 = "Street2"
        let city = "City"
        let state = "Beijing"
        let zipCode = "0"
        let country = "China"
        let cellphone = "1"
        let telephone = "2"
        let type = "Test"
        address().createAddress(recipient: recipient, street1: street1, street2: street2, city: city, state: state, zipCode: zipCode, country: country, cellphone: cellphone, telephone: telephone, type: type)
        contact().cell(type).verifyExists("New address added.")
        //open this address
        contact().cell(type).tap()
        address().verifyDisplay(recipient: recipient, street1: street1, street2: street2, city: city, state: state, zipCode: zipCode, country: country, cellphone: cellphone, telephone: telephone, type: type)
        //edit address
        let newType = "NEW"
        address().editAddress(type: newType)
        contact().cell(newType).verifyExists("Address editted.")
        
//        utils().swipeUp()
//        
//        //add activity
//        contactEdit().addActivityBtn.tap()
//        let commentDetail = "COMMENT"
//        commentActivity().create(commentDetail)
//        contactEdit().verifyActivityDisplay(commentDetail)
        
        //swipe down for 5 times
        utils().swipeDown(time: 5);
        
        //edit contact details
//        contactEdit().editStatus("Inactive")
//        contactEdit().status.verifyLabel(label: "Inactive")
        
        contact().leftMenuBtn.tap()
        addressBook().leftMenuBtn.tap()
        //logout
        self.logout()
    }
    
    func testCreateContact() {
        self.loginAndGoToList(addressBook.ADDRESS_BOOK_LIST_NAME)
        
        //click create contact btn
        addressBook().createBtn.tap()
        addressBook().createContactBtn.tap()
        
        //cannot save, stay on this view
        contactCreate().rightMenuBtn.tap()
        contactCreate().lastName.verifyExists()
        
        //select company
        contactCreate().selectCompany("XD")
        contactCreate().cell("XD").verifyExists()
        
        //cannot save, stay on this view
        contactCreate().rightMenuBtn.tap()
        contactCreate().lastName.verifyExists()
        
        //create address
        contact().swipeToAddAddress()
        contactCreate().addAddressBtn.smartTap()
        address().createAddress(recipient: "AAA", street1: "1", street2: "2",state: "Beijing", country: "China")
        
        utils().swipeUp()
        contactCreate().cell("Beijing").verifyExists("New address created.")
        
        //edit address
        contactCreate().cell("Beijing").tap()
        address().editAddress(type: "CreateContact")
        utils().swipeUp()
        contactCreate().cell("CreateContact").verifyExists("Address editted.")
        
        utils().swipeDown()
        //input last name
        let newContactLastName = "LastName"
        contactCreate().lastName.inputText(newContactLastName)
        addressBook().cellWithTextField(newContactLastName).verifyExists()
        
        contactCreate().rightMenuBtn.tap()
        contactEdit().leftMenuBtn.tap()

        //click create btn
        self.logout()
    }
    
    func testEditCorporate() {
        self.loginAndGoToList(addressBook.ADDRESS_BOOK_LIST_NAME)
        
        //search and go to detail
        utils().swipeDown()
        addressBook().searchAndGoToDetail("XD")
        
        //click call btn
        customerEdit().callBtn.tap()
        customerEdit().cellOnInfoPickerView("123123").tap()
        //check if activity with type call generated
        customer().swipeToActivity()
        let msg = "Called 123123."
        customerEdit().cell(msg).verifyExists()
        //click to open activity to check activity type
        customerEdit().cell(msg).smartTap()
        //verify activity type
        callActivity().verifyType()
        callActivity().backBtnOnEditView.tap()
        
        customerEdit().emailBtn.tap()
        let emailCell = customerEdit().cellOnInfoPickerView("xd@xd.com")
        emailCell.verifyExists("Email btn existed");
        customerEdit().infoPickerCancelView.tap()
        
        //check status of locate btn
        customerEdit().locateBtn.verifyDisabled()
        
        //check main contact cell
        customerEdit().mainContactCell("Contact A").verifyExists()
        //navigate to main contact cell
        customerEdit().mainContactCell("Contact A").smartTap()
        contactEdit().leftMenuBtn.tap()
        //navigate to related contects list
        customerEdit().relatedContactsCell.tap()
        relatedContacts().contactCell("Contact B").tap()
        contactEdit().leftMenuBtn.tap()
        relatedContacts().leftMenuBtn.tap()
        
        //change main contact
        customerEdit().changeMainContactTo("Contact B")
        customerEdit().mainContactCell("Contact B").verifyExists()
        
        //edit contact information
        customerEdit().editCorporateContactInfo(name: "NEW_NAME")
        customerEdit().textWithLabel(customer.CORPORATE_NAME).verifyLabel(label: "NEW_NAME")
        
        customerEdit().swipeToAddress()
        
        //add address
        let addressType = "testEditCorporate"
        customerEdit().addAddressBtn.smartTap()
        address().createAddress(type: addressType)
        customerEdit().cell(addressType).verifyExists()
        
        //edit address
        customerEdit().cell(addressType).smartTap()
        let addressNewType = "testEditCorporate_new"
        address().editAddress(type: addressNewType)
        customerEdit().cell(addressNewType).verifyExists()
        
        //delete address
        customerEdit().swipeToAddress()
        customerEdit().deleteCell(addressNewType)
        customerEdit().cell(addressNewType).verifyNotExists()
        
        customerEdit().swipeToActivity()
        
        //add activity
        customerEdit().addActivityBtn.smartTap()
        let commentDetail = "COMMENT"
        commentActivity().create(commentDetail)
        customerEdit().cell(commentDetail).verifyExists()
        
        //edit activity
        customerEdit().cell(commentDetail).smartTap()
        let newCommentDetail = "newCommentDetail"
        commentActivity().edit(newCommentDetail)
        snapshot("Edit activity")
        customerEdit().cell(newCommentDetail).verifyExists()
        
        customerEdit().swipeToActivity()
        
        //delete activity
        customerEdit().deleteCell(newCommentDetail)
        customerEdit().cell(newCommentDetail).verifyNotExists()
        
        //create opportunity
        customerEdit().createOpportunity()
        opportunity().leftMenuBtn.tap()
        
        //edit details
//        customerEdit().editStatus("Inactive")
//        customerEdit().textWithLabel(customer.STATUS).verifyLabel(label: "Inactive")
        
        //back and logout
        customerEdit().leftMenuBtn.tap()
        addressBook().leftMenuBtn.tap()
        self.logout()
    }
    
    func testCreateCorporate() {
        self.loginAndGoToList(addressBook.ADDRESS_BOOK_LIST_NAME)
        
        //click create corporate btn
        addressBook().createBtn.tap()
        addressBook().createCorporateBtn.tap()
        
        //input corporate name
        let corproateName = "ACorporateName"
        customerCreate().corporateName.inputText(corproateName)
        
        //add address
        customerCreate().swipeToAddress()
        customerCreate().addAddressBtn.tap()
        let addressType = "testCreateCorporate"
        address().createAddress(type: addressType)
        customerCreate().cell(addressType).verifyExists()
        
        //edit address
        customerCreate().cell(addressType).tap()
        let addressNewType = "testCreateCorporate_new"
        address().editAddress(type: addressNewType)
        customerCreate().cell(addressNewType).verifyExists()
        
        //delete address
        customerCreate().deleteCell(addressNewType)
        customerCreate().cell(addressNewType).verifyNotExists()
        
        //click save btn
        customerCreate().rightMenuBtn.tap()
        //check go to edit form
        customerEdit().cell(corproateName).verifyExists()
        
        addressBook().cellWithText(corproateName).verifyExists()
        
        //logout
        addressBook().leftMenuBtn.tap()
        self.logout()
    }
    
    func testEditIndividual() {
        self.loginAndGoToList(addressBook.ADDRESS_BOOK_LIST_NAME)
        
        //search and go to detail
        utils().swipeDown()
        addressBook().searchAndGoToDetail("James Leung")
        
        //click call btn
        customerEdit().callBtn.tap()
        customerEdit().cellOnInfoPickerView("234567").tap()
        //check if activity with type call generated
        customerEdit().swipeToActivity()
        let msg = "Called 234567."
        customerEdit().cell(msg).verifyExists()
        //click to open activity to check activity type
        customerEdit().cell(msg).tap()
        //verify activity type
        callActivity().verifyType()
        callActivity().backBtnOnEditView.tap()
        
        //swipe up to click email btn
        customerEdit().emailBtn.tap()
        let emailCell = customerEdit().cellOnInfoPickerView("test@126.com")
        emailCell.verifyExists("Email btn existed");
        customerEdit().infoPickerCancelView.tap()
        
        //click locate btn
        customerEdit().locateBtn.tap()
        customerEdit().infoPickerCancelView.tap()
        
        utils().swipeDown(time: 8)
        //edit contact information
        let lastName = "NEW_NAME"
        customerEdit().editIndividualGeneralInfo(lastName: lastName)
        customerEdit().textWithLabel(customer.LAST_NAME).verifyLabel(label: lastName)
        
        customerEdit().swipeToAddress()
        
        //verify existed address
        customerEdit().cell("chenhui road 1001").verifyExists()
        //add address
        let addressType = "testEditIndividual"
        customerEdit().addAddressBtn.smartTap()
        address().createAddress(type: addressType)
        customerEdit().cell(addressType).verifyExists()
        
        //edit address
        sleep(1)
        customerEdit().cell(addressType).tap()
        snapshot("TapOnAddress")
        let addressNewType = "testEditIndividual_new"
        address().editAddress(type: addressNewType)
        customerEdit().cell(addressNewType).verifyExists()
        
        customerEdit().swipeToAddress()
        //delete address
        customerEdit().deleteCell(addressNewType)
        customerEdit().cell(addressNewType).verifyNotExists()
        
        customerEdit().swipeToActivity()
        
        //add activity
        customerEdit().addActivityBtn.tap()
        let commentDetail = "COMMENT"
        commentActivity().create(commentDetail)
        customerEdit().cell(commentDetail).verifyExists()
        
        //edit activity
        customerEdit().cell(commentDetail).tap()
        let newCommentDetail = "newCommentDetail"
        commentActivity().edit(newCommentDetail)
        customerEdit().cell(newCommentDetail).verifyExists()
        
        customerEdit().swipeToActivity()
        //delete activity
        customerEdit().deleteCell(newCommentDetail)
        customerEdit().cell(newCommentDetail).verifyNotExists()
        
        //create opportunity
        customerEdit().createOpportunity()
        opportunity().leftMenuBtn.tap()
        
        utils().swipeDown(time:8)
        //edit details
        customerEdit().editStatus("Inactive")
        utils().swipeUp()
        customerEdit().status.verifyLabel(label: "Inactive")
        
        //back and logout
        customerEdit().leftMenuBtn.tap()
        addressBook().leftMenuBtn.tap()
        self.logout()
    }
    
    func testCreateIndividual() {
        self.loginAndGoToList(addressBook.ADDRESS_BOOK_LIST_NAME)
        
        //click create corporate btn
        addressBook().createBtn.tap()
        addressBook().createIndividualBtn.tap()
        
        //input corporate name
        let lastName = "ALastName"
        customerCreate().textFieldWithLabel(customer.LAST_NAME).inputText(lastName)
        
        customerCreate().swipeToAddress()
        //add address
        customerCreate().addAddressBtn.tap()
        //add address
        let addressType = "testCreateIndividual"
        address().createAddress(type: addressType)
        utils().swipeUp()
        customerCreate().cell(addressType).verifyExists()
        
        //edit address
        customerCreate().cell(addressType).tap()
        let addressNewType = "testCreateIndividual_new"
        address().editAddress(type: addressNewType)
        utils().swipeUp()
        customerCreate().cell(addressNewType).verifyExists()
        
        //delete address
        customerCreate().deleteCell(addressNewType)
        customerCreate().cell(addressNewType).verifyNotExists()
        
        //click save btn
        customerCreate().rightMenuBtn.tap()
        addressBook().cellWithText(lastName).verifyExists()
        
        //logout
        addressBook().leftMenuBtn.tap()
        self.logout()
    }
    
    func testHomeCards() {
        self.loginAndGoToList("");
        
        //verify card
        home().verifyCardExisting("Opportunity Due");
        home().verifyCardExisting("Your Current Pipeline");
        
        //logout
        siderBar().homeMenuBtnInHome.forceTap();
        self.logout();
    }
    
    func testProductList() {
        self.loginAndGoToList("Products");
        
        //play filter
        productList().clickFilterBtn();
        productFilter().apply("MyCategory", "MyBrand", ["0","100"]);
        productList().verifyProductExisting("MyCategory", false); //doesn't existing
        
        productList().clickFilterBtn();
        productFilter().apply(nil, nil, ["1","86"]); // 1 to 10086
        productList().verifyProductExisting("MyCategory", true);
        productList().goToDetailedView("abc"); //product name abc
        
        //verify product
        product().waitForViewDisplays(self, "abc"); //abc is title
        product().verifyCellValue("Product Category", "MyCategory");
        utils().swipeUp()
        product().verifyCellValue("Brand", "MyBrand");
        
        //logout
        productList().leftMenuBtn.tap();
        self.logout();
    }
    
    func testLeadsList() {
        self.loginAndGoToList("Leads")
        
        //filter and sort
        leadsList().filterBtn.tap()
        leadsFilter().applyFilter(owner: "All", statuses: ["Qualified", "Unqualified"], qualification: "Hot")
        leadsList().filterBtn.tap()
        leadsFilter().sortTabBtn.tap()
        leadsFilter().sortTable.cells.element(boundBy: 1).tap()
        leadsList().cellWithText("D C").tap()
        
        lead().leftMenuBtn.tap()
        
        //search
        leadsList().searchAndGoToDetail("James Leung");
        
        lead().cell("James Leung").verifyExists()
    }
    
    func testEditLead() {
        self.loginAndGoToList("Leads")
        
        leadsList().newQuickFilterBtn.tap()
        
        leadsList().cellWithText("A B").tap()
        
        //check header action btn
        lead().contactCall.tap()
        lead().cellOnInfoPickerView("Cellphone").tap()
        //check if activity with type call generated
        lead().swipeToActivity()
        let msg = "Called"
        lead().cell(msg).verifyExists()
        //click to open activity to check activity type
        lead().cell(msg).smartTap()
        //verify activity type
        callActivity().verifyType()
        callActivity().backBtnOnEditView.tap()
        
        lead().contactEmail.tap()
        lead().cellOnInfoPickerView("a@nelson.com").verifyExists()
        lead().infoPickerCancelView.tap()
        
        //click locate btn
        lead().contactLocate.verifyDisabled()
        
        //change status
        lead().changeStatus("In Process")
        lead().status.verifyLabel(label: "In Process")
        
        lead().descriptionField.inputText("New Lead Description")
        
        let newQualification = "Cold"
        let newRemark = "Edit Lead Remark"
        lead().editGeneralInfo(qualification: newQualification, remarks: newRemark)
        lead().textWithLabel(lead.QUALIFICATION).verifyLabel(label: newQualification)
        lead().textWithLabel(lead.REMARKS).verifyLabel(label: newRemark)
        
        utils().swipeUp()
        let newPhone = "1"
        let newEmail = "2@test.com"
        lead().editContactInfo(phone: newPhone, email: newEmail)
        lead().textWithLabel(lead.PHONE).verifyLabel(label: newPhone)
        lead().textWithLabel(lead.EMAIL).verifyLabel(label: newEmail)
        
        utils().swipeUpUntilElementVisible(element: lead().addAddressBtn)
        //create address
        lead().addAddressBtn.smartTap()
        let newAddress = "street1"
        address().createAddress(street1: newAddress)
        lead().cell(newAddress).verifyExists()
        lead().addAddressBtn.verifyNotExists()
        //edit address
        lead().cell(newAddress).tap()
        let editAddress = "edit_street1"
        address().editAddress(street1: editAddress)
        lead().cell(editAddress).verifyExists()
        //delete address
        lead().deleteCell(newAddress)
        lead().addAddressBtn.verifyExists()
        
        utils().swipeUpUntilElementVisible(element: lead().addActivityBtn)
        //add activity
        lead().addActivityBtn.smartTap()
        let commentDetail = "COMMENT"
        commentActivity().create(commentDetail)
        lead().cell(commentDetail).verifyExists()
        //edit activity
        lead().cell(commentDetail).tap()
        let newCommentDetail = "newCommentDetail"
        commentActivity().edit(newCommentDetail)
        lead().cell(newCommentDetail).verifyExists()
        //delete activity
        lead().deleteCell(newCommentDetail)
        lead().cell(newCommentDetail).verifyNotExists()
        
        //convert to customer
        lead().rightMenuBtn.tap()
        lead().buttonWithText("Cancel").tap()
        lead().changeStatus("Copied")
        customerEdit().leftMenuBtn.tap()
        
        lead().leftMenuBtn.tap()
        leadsList().leftMenuBtn.tap()
        self.logout()
    }
    
    func testCreateLead() {
        self.loginAndGoToList("Leads")
        
        leadsList().createBtn.tap()
        
        let newDesc = "Create Lead"
        lead().descriptionField.inputText(newDesc)
        var newPhone = "a"
        var newEmail = "1"
        lead().textFieldWithLabel(lead.PHONE).inputText(newPhone)
        lead().textFieldWithLabel(lead.EMAIL).inputText(newEmail)
        lead().rightMenuBtn.tap()
        newPhone = "1"
        newEmail = "1@126.com"
        lead().textFieldWithLabel(lead.PHONE).inputText(newPhone)
        lead().textFieldWithLabel(lead.EMAIL).inputText(newEmail)
        
        lead().rightMenuBtn.tap()
        
        leadsList().cellWithText(newEmail).verifyExists()
        
        leadsList().leftMenuBtn.tap()
        self.logout()
        
    }
    
    func testReports() {
        self.loginAndGoToList("Reports")
        
        reportsList().navigate("Pipeline Overview")
        
        overview().setFilter("Weighted", "Weighted amount")
        overview().setFilter("Mine", "My opportunities")
        
        reportsList().backBtn.tap()
        
        reportsList().navigate("Opportunities Outlook")
        
        outlook().setFilter("Weighted", "Potential amount")
        outlook().setFilter("Weekly", "Monthly")
        outlook().setFilter("Mine", "All opportunities")
                
        reportsList().backBtn.tap()
        
        reportsList().navigate("Sales Summary")
        
        summary().pullDownMenu("Channels(3)")
        summary().multiSelect("Unselect All", ["Central_Park", "默认渠道"])
        summary().applyBtn.tap()
        
        summary().setFilter("Weekly", "Monthly")
        summary().setFilter("Mine", "My Sales Orders")
        
        reportsList().backBtn.tap()
        
        self.logout()
    }
 
    func testSalesOrders() {
        self.loginAndGoToList("Sales Orders")
        
        salesOrdersList().filterBtn.tap()
        salesOrdersFilter().applyFilter(owner: "All", customerTypes: ["Individual", "Corporate"])
        
        salesOrders().goToDetailedView("21") //product name 21
        salesOrders().navigate("Amount")
        utils().swipeDown()
        utils().swipeUp()
        
        //click call btn
        salesOrders().callBtn.tap()
        salesOrders().cellOnInfoPickerView("234567").tap()

        //click email btn
        salesOrders().emailBtn.tap()
        salesOrders().cellOnInfoPickerView("test@126.com").tap()
        
        //click locate btn
        salesOrders().locateBtn.tap()
        salesOrders().infoPickerCancelView.tap()
        salesOrdersList().backBtn.tap()
        
        salesOrdersList().filterBtn.tap()
        salesOrdersFilter().sortTabBtn.tap()
        salesOrdersFilter().sortTable.cells.element(boundBy: 1).tap()
        
        self.logout()
    }
}
