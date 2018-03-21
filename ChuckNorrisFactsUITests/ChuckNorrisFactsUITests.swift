//
//  ChuckNorrisFactsUITests.swift
//  ChuckNorrisFactsUITests
//
//  Created by Tatiana Magdalena on 02/03/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import XCTest
import Nimble
import Swifter

class ChuckNorrisFactsUITests: XCTestCase {
    
    var app: XCUIApplication!
    let dynamicStubs = HTTPDynamicStubs()
    let testUrl = "/jokes/search?query=abc"
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        dynamicStubs.setUp()
        app = XCUIApplication()
        app.launchArguments += ["UI-TESTING"]
        app.launch()
    }
    
    override func tearDown() {
        app.terminate()
        app = nil
        dynamicStubs.tearDown()
        super.tearDown()
    }
    
    func test_InitialView() {
        let label = app.staticTexts["Pesquise por um termo para ver fatos do Chuck Norris"]
        let button = app.buttons["Pesquisar"]
        assertElementsExists([label, button],
                             caller: #function)
    }
    
    func test_InitialView_OpenAlert() {
        
        let button = app.buttons["Pesquisar"]
        assertElementsExists([button],
                             caller: #function)
        
        button.tap()
        let alert = app.alerts["Pesquisa"]
        let alertMessage = alert.staticTexts["Entre com o termo a ser pesquisado"]
        let searchTextField = alert.textFields["Digite o termo"]
        let cancelButton = alert.buttons["Cancel"]
        let okButton = alert.buttons["Ok"]
        
        assertElementsExists([alert, alertMessage, searchTextField, cancelButton, okButton],
                             caller: #function)
    }
    
    func test_CorrectResult() {
        
        dynamicStubs.setupStub(url: testUrl, filename: "query_correct_response", responseType: .ok)
        
        app.buttons["Pesquisar"].tap()

        let alert = app.alerts["Pesquisa"]
        alert.collectionViews.textFields["Digite o termo"].typeText("abc")
        alert.buttons["Ok"].tap()

        let table = app.tables.element
        let exists = NSPredicate(format: "exists == true")
        
        expectation(for: exists, evaluatedWith: table, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        let secondCell = table.cells.staticTexts["The Death Star's original name was Space Station Chuck Norris."]
        
        expectation(for: exists, evaluatedWith: secondCell, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        secondCell.swipeUp()
        secondCell.swipeDown()
    }
    
    func test_IncorrectJsonResponse() {
        performTest_ErrorResponse(jsonResponseFile: "query_error_response",
                                  responseType: .ok,
                                  errorText: "Por favor, tente novamente mais tarde.")
    }
    
    func test_ServerError() {
        performTest_ErrorResponse(jsonResponseFile: nil,
                                  responseType: .serverError,
                                  errorText: "Por favor, tente novamente mais tarde.")
    }
    
    func test_NotFound() {
        performTest_ErrorResponse(jsonResponseFile: nil,
                                  responseType: .notFound,
                                  errorText: "Não há resultados para o termo pesquisado. Entre com um novo termo para tentar novamente.")
    }
    
    func test_ClientError() {
        performTest_ErrorResponse(jsonResponseFile: nil,
                                  responseType: .clientError,
                                  errorText: "Não foi possível encontrar resultados com este termo. Entre com um novo termo para tentar novamente.")
    }
    
}

// MARK: - Aux methods

private extension ChuckNorrisFactsUITests {
    
    func assertElementsExists(_ elements: [XCUIElement], caller: String) {
        for element in elements {
            expect(element.exists).to(beTrue(), description: "Element \(element) doesn't exist on \(caller)")
        }
    }
    
    func performTest_ErrorResponse(jsonResponseFile: String?, responseType: HTTPResponseStub, errorText: String) {
        dynamicStubs.setupStub(url: testUrl, filename: jsonResponseFile, responseType: responseType)
        
        app.buttons["Pesquisar"].tap()
        
        let alert = app.alerts["Pesquisa"]
        alert.collectionViews.textFields["Digite o termo"].typeText("abc")
        alert.buttons["Ok"].tap()
        
        let errorLabel = app.staticTexts[errorText]
        
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: errorLabel, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }
}
