//
//  NetworkRequestsTests.swift
//  ChuckNorrisFactsTests
//
//  Created by Tatiana Magdalena on 09/03/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import XCTest
import RxSwift
import RxBlocking
import OHHTTPStubs
import Nimble
@testable import ChuckNorrisFacts

class NetworkRequestsTests: XCTestCase {
    
    private var errorHandlerMock: MyMocks.RequestErrorHandler!
    private var networkingUnderTests: NetworkRequests!
    
    override func setUp() {
        super.setUp()
        errorHandlerMock = MyMocks.RequestErrorHandler()
        networkingUnderTests = NetworkRequests(errorHandler: errorHandlerMock)
        _ = stub(condition: isHost("mycorrectjsondata.com"), response: { _ in
            return OHHTTPStubsResponse(data: Dummy.queryCorrectJsonData, statusCode: 202, headers: Dummy.jsonHeader)
        })
        _ = stub(condition: isHost("badrequest.com"), response: { _ in
            return OHHTTPStubsResponse(data: Dummy.genericJsonResponse, statusCode: 400, headers: Dummy.jsonHeader)
        })
        _ = stub(condition: isHost("nointernet.com"), response: { _ in
            let nsError = NSError(domain: NSURLErrorDomain, code: URLError.notConnectedToInternet.rawValue, userInfo: nil)
            return OHHTTPStubsResponse(error: URLError(_nsError: nsError))
        })
    }
    
    override func tearDown() {
        networkingUnderTests = nil
        errorHandlerMock = nil
        OHHTTPStubs.removeAllStubs()
        super.tearDown()
    }
    
    func test_GetRequest_Json_Success() {
        do {
            _ = try networkingUnderTests.getHTTPRequestObservable(url: "http://mycorrectjsondata.com", parameters: Dummy.genericParameters, headers: Dummy.genericHeaders).toBlocking().first()!
            expect(self.errorHandlerMock.catchedErrorCallCount).to(equal(0))
            expect(self.errorHandlerMock.httpCodeErrorCallCount).to(equal(1))
        } catch {
            fail("An error was thrown.")
        }
    }
    
    func test_GetRequest_HttpError() {
        do {
            let jsonResponse = try networkingUnderTests.getHTTPRequestObservable(url: "http://badrequest.com", parameters: Dummy.genericParameters, headers: Dummy.genericHeaders).toBlocking().first()
            expect(jsonResponse).to(beNil())
        } catch {
            expect(self.errorHandlerMock.httpCodeErrorCallCount).to(equal(1))
            expect(self.errorHandlerMock.catchedErrorCallCount).to(equal(0))
        }
    }
    
    func test_GetRequest_ConnectivityError() {
        do {
            let jsonResponse = try networkingUnderTests.getHTTPRequestObservable(url: "http://nointernet.com", parameters: Dummy.genericParameters, headers: Dummy.genericHeaders).toBlocking().first()
            expect(jsonResponse).to(beNil())
        } catch {
            expect(self.errorHandlerMock.httpCodeErrorCallCount).to(equal(0))
            expect(self.errorHandlerMock.catchedErrorCallCount).to(equal(1))
        }
    }
    
}
