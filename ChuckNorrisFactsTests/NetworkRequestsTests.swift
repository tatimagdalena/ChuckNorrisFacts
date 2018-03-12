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
    
    private var errorHandlerMock: MyMockHandleRequestError!
    private var networkingUnderTests: NetworkRequests!
    
    override func setUp() {
        super.setUp()
        errorHandlerMock = MyMockHandleRequestError()
        networkingUnderTests = NetworkRequests(errorHandler: errorHandlerMock)
        _ = stub(condition: isHost("mycorrectjsondata.com"), response: { _ in
            return OHHTTPStubsResponse(jsonObject: Dummy.jsonDictionary, statusCode: 202, headers: ["Content-Type" : "application/json"])
        })
        _ = stub(condition: isHost("badrequest.com"), response: { _ in
            return OHHTTPStubsResponse(jsonObject: Dummy.jsonDictionary, statusCode: 400, headers: ["Content-Type" : "application/json"])
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
            let jsonResponse = try networkingUnderTests.getHTTPRequestObservable(url: "http://mycorrectjsondata.com", parameters: Dummy.parameters, headers: Dummy.headers).toBlocking().first()!
            expect(self.errorHandlerMock.catchedErrorCallCount).to(equal(0))
            expect(self.errorHandlerMock.httpCodeErrorCallCount).to(equal(1))
            expect(jsonResponse as? [String : Any]).notTo(beNil())
        } catch {
            fail("An error was thrown.")
        }
    }
    
    func test_GetRequest_HttpError() {
        do {
            let jsonResponse = try networkingUnderTests.getHTTPRequestObservable(url: "http://badrequest.com", parameters: Dummy.parameters, headers: Dummy.headers).toBlocking().first()
            expect(jsonResponse).to(beNil())
        } catch {
            expect(self.errorHandlerMock.httpCodeErrorCallCount).to(equal(1))
            expect(self.errorHandlerMock.catchedErrorCallCount).to(equal(0))
        }
    }
    
    func test_GetRequest_ConnectivityError() {
        do {
            let jsonResponse = try networkingUnderTests.getHTTPRequestObservable(url: "http://nointernet.com", parameters: Dummy.parameters, headers: Dummy.headers).toBlocking().first()
            expect(jsonResponse).to(beNil())
        } catch {
            expect(self.errorHandlerMock.httpCodeErrorCallCount).to(equal(0))
            expect(self.errorHandlerMock.catchedErrorCallCount).to(equal(1))
        }
    }
    
}

extension NetworkRequestsTests {
    struct Dummy {
        static let jsonDictionary: [String : Any] = ["hello" : "world",
                                                     "foo" : "bar",
                                                     "zero" : 0]
        static let parameters = ["parameter" : "value"]
        static let headers = ["header" : "value"]
    }
    
    class MyMockHandleRequestError: HandleRequestError {
        
        var catchedErrorCallCount = 0
        var httpCodeErrorCallCount = 0
        
        func handleCatchedRequestError(_ error: Error) -> Observable<(HTTPURLResponse, Any)> {
            catchedErrorCallCount += 1
            return Observable.error(RequestError.generic)
        }
        
        func handleHttpStatusCodeError(response: HTTPURLResponse) throws {
            httpCodeErrorCallCount += 1
            switch response.statusCode {
            case 200..<300: break
            default: throw RequestError.generic
            }
        }
    }
}
