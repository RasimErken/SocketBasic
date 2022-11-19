//
//  socketBasicUITests.swift
//  socketBasicUITests
//
//  Created by rasim rifat erken on 7.10.2022.
//  Copyright © 2022 mac-0005. All rights reserved.
//

import XCTest

class socketBasicUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        
        
        
        let join = app/*@START_MENU_TOKEN@*/.staticTexts["JOIN"]/*[[".buttons[\"JOIN\"].staticTexts[\"JOIN\"]",".staticTexts[\"JOIN\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(join.exists)
        
        join.tap()
        app.typeText("rasim")
        
        let ok = app.alerts["Socket"].scrollViews.otherElements.buttons["OK"]
        XCTAssertTrue(ok.exists)
        
        ok.tap()
        
        let c = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textView).element
        XCTAssertTrue(c.exists)
        
        c.tap()
        
        app.typeText("merhaba")
        
        let sende = app.buttons["send"]
        XCTAssertTrue(sende.exists)
        sende.tap()
        
        let nav = app.navigationBars["socketBasic.ChatDetailView"].buttons["Back"]
        XCTAssertTrue(nav.exists)
        nav.tap()
        
        
        
       
        
        
        
                
    }

    func testLaunchPerformance() throws {
        
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
