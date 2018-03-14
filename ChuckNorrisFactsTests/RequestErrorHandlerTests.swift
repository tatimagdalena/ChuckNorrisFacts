//
//  RequestErrorHandlerTests.swift
//  ChuckNorrisFactsTests
//
//  Created by Tatiana Magdalena on 08/03/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import XCTest
import Nimble
import RxSwift
import RxBlocking
import Alamofire
@testable import ChuckNorrisFacts

class RequestErrorHandlerTests: XCTestCase {
    
    var handlerUnderTest: RequestErrorHandler!
    let url = URL(string: "https://api.chucknorris.io/jokes/search?query=death_star")!
    let header = ["Content-Type":"application/json"]
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        handlerUnderTest = RequestErrorHandler()
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        handlerUnderTest = nil
        disposeBag = nil
        super.tearDown()
    }
    
    // MARK: - Status Code tests -
    
    func testSuccessfullRequest() {
        let response = HTTPURLResponse(url: url, statusCode: 202, httpVersion: nil, headerFields: header)!
        expect { try self.handlerUnderTest.handleHttpStatusCodeError(response: response) }.notTo(throwError())
    }
    
    func testGenericRequestError() {
        let response = HTTPURLResponse(url: url, statusCode: 300, httpVersion: nil, headerFields: header)!
        expect { try self.handlerUnderTest.handleHttpStatusCodeError(response: response) }.to(throwError(RequestError.generic))
    }
    
    func testBadRequest() {
        let response = HTTPURLResponse(url: url, statusCode: 400, httpVersion: nil, headerFields: header)!
        expect { try self.handlerUnderTest.handleHttpStatusCodeError(response: response) }.to(throwError(RequestError.client(.badRequest)))
    }
    
    func testUnauthorized() {
        let response = HTTPURLResponse(url: url, statusCode: 401, httpVersion: nil, headerFields: header)!
        expect { try self.handlerUnderTest.handleHttpStatusCodeError(response: response) }.to(throwError(RequestError.client(.unauthorized)))
    }
    
    func testGenericClientError() {
        let response = HTTPURLResponse(url: url, statusCode: 402, httpVersion: nil, headerFields: header)!
        expect { try self.handlerUnderTest.handleHttpStatusCodeError(response: response) }.to(throwError(RequestError.client(.generic)))
    }
    
    func testNotFound() {
        let response = HTTPURLResponse(url: url, statusCode: 404, httpVersion: nil, headerFields: header)!
        expect { try self.handlerUnderTest.handleHttpStatusCodeError(response: response) }.to(throwError(RequestError.client(.notFound)))
    }
    
    func testInternalServerError() {
        let response = HTTPURLResponse(url: url, statusCode: 500, httpVersion: nil, headerFields: header)!
        expect { try self.handlerUnderTest.handleHttpStatusCodeError(response: response) }.to(throwError(RequestError.server(.internalServerError)))
    }
    
    func testServiveUnavailable() {
        let response = HTTPURLResponse(url: url, statusCode: 503, httpVersion: nil, headerFields: header)!
        expect { try self.handlerUnderTest.handleHttpStatusCodeError(response: response) }.to(throwError(RequestError.server(.serviceUnavailable)))
    }
    
    func testGenericServerError() {
        let response = HTTPURLResponse(url: url, statusCode: 501, httpVersion: nil, headerFields: header)!
        expect { try self.handlerUnderTest.handleHttpStatusCodeError(response: response) }.to(throwError(RequestError.server(.generic)))
    }
    
    // MARK: - Thrown url request error tests -
    
    func test_URLError_NoConnectionError() {
        let urlError = createUrlError(errorCode: URLError.notConnectedToInternet)
        do {
            let response = try handlerUnderTest
                .handleCatchedRequestError(urlError)
                .toBlocking()
                .first()
            expect(response).to(beNil())
        } catch RequestError.url(.noConnection) {
            // expected error was thrown
        } catch {
            fail("The error was not correctly mapped to a no connection domain error.")
        }
    }
    
    private func createUrlError(errorCode: URLError.Code) -> URLError {
        let errorCode = errorCode.rawValue
        let nsError = NSError(domain: NSURLErrorDomain, code: errorCode, userInfo: nil)
        return URLError(_nsError: nsError)
    }
    
    // MARK: - Thrown alamofire request error tests -
    
    func test_AFError_InvalidURL() {
        let afError = AFError.invalidURL(url: URL(string: "test.com")!)
        do {
            let response = try handlerUnderTest
                .handleCatchedRequestError(afError)
                .toBlocking()
                .first()
            expect(response).to(beNil())
        } catch RequestError.request(.invalidUrl) {
            // expected error was thrown
        } catch {
            fail("The error was not correctly mapped to a no connection domain error.")
        }
    }
}
