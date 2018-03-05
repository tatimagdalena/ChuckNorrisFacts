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
import RxTest
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
        expect { try self.handlerUnderTest.handleHttpStatusCodeError(response: response) }.to(throwError(RequestError.Client.badRequest))
    }
    
    func testUnauthorized() {
        let response = HTTPURLResponse(url: url, statusCode: 401, httpVersion: nil, headerFields: header)!
        expect { try self.handlerUnderTest.handleHttpStatusCodeError(response: response) }.to(throwError(RequestError.Client.unauthorized))
    }
    
    func testGenericClientError() {
        let response = HTTPURLResponse(url: url, statusCode: 402, httpVersion: nil, headerFields: header)!
        expect { try self.handlerUnderTest.handleHttpStatusCodeError(response: response) }.to(throwError(RequestError.Client.generic))
    }
    
    func testNotFound() {
        let response = HTTPURLResponse(url: url, statusCode: 404, httpVersion: nil, headerFields: header)!
        expect { try self.handlerUnderTest.handleHttpStatusCodeError(response: response) }.to(throwError(RequestError.Client.notFound))
    }
    
    func testInternalServerError() {
        let response = HTTPURLResponse(url: url, statusCode: 500, httpVersion: nil, headerFields: header)!
        expect { try self.handlerUnderTest.handleHttpStatusCodeError(response: response) }.to(throwError(RequestError.Server.internalServerError))
    }
    
    func testServiveUnavailable() {
        let response = HTTPURLResponse(url: url, statusCode: 503, httpVersion: nil, headerFields: header)!
        expect { try self.handlerUnderTest.handleHttpStatusCodeError(response: response) }.to(throwError(RequestError.Server.serviceUnavailable))
    }
    
    func testGenericServerError() {
        let response = HTTPURLResponse(url: url, statusCode: 501, httpVersion: nil, headerFields: header)!
        expect { try self.handlerUnderTest.handleHttpStatusCodeError(response: response) }.to(throwError(RequestError.Server.generic))
    }
    
    // MARK: - Thrown url request error tests -
    
    func test_URLError_NoConnectionError() {
        let urlError = createUrlError(errorCode: URLError.notConnectedToInternet)
        let observable = handlerUnderTest.handleCatchedRequestError(urlError)
        let observer = generateObserver(from: observable)
        let observerFirstError = observer.events[0].value.error
        expect(observer.events.count).to(equal(1), description: "There is no event being emitted")
        expect(observerFirstError).notTo(beNil(), description: "There is no error being emmited")
        expect(observerFirstError).to(beAKindOf(RequestError.Url.self), description: "Emitted error is not an RequestError.Url as expected")
        
        let requestErrorUrl = observerFirstError as? RequestError.Url
        switch requestErrorUrl {
        case .noConnection?: break
        case .none: break
        default: fail("Emitted error is an URLError of type \(requestErrorUrl!), not the expected noConnection type")
        }
    }
    
    private func createUrlError(errorCode: URLError.Code) -> URLError {
        let errorCode = errorCode.rawValue
        let nsError = NSError(domain: NSURLErrorDomain, code: errorCode, userInfo: nil)
        return URLError(_nsError: nsError)
    }
    
    private func generateObserver(from observable: Observable<(HTTPURLResponse, Any)>) -> TestableObserver<(HTTPURLResponse, Any)> {
        let testScheduler = TestScheduler(initialClock: 0)
        let observer = testScheduler.createObserver((HTTPURLResponse, Any).self)
        observable.asObservable().subscribe(observer).disposed(by: disposeBag)
        testScheduler.start()
        return observer
    }
    
    // MARK: - Thrown alamofire request error tests -
    
    func test_AFError_InvalidURL() {
        let afError = AFError.invalidURL(url: URL(string: "test.com")!)
        let observable = handlerUnderTest.handleCatchedRequestError(afError)
        let observer = generateObserver(from: observable)
        let observerFirstError = observer.events[0].value.error
        expect(observer.events.count).to(equal(1), description: "There is no event being emitted")
        expect(observerFirstError).notTo(beNil(), description: "There is no error being emmited")
        expect(observerFirstError).to(beAKindOf(RequestError.Request.self), description: "Emitted error is not an RequestError.Request as expected")
        
        let requestErrorAlamofire = observerFirstError as? RequestError.Request
        switch requestErrorAlamofire {
        case .invalidUrl?: break
        case .none: break
        default: fail("Emitted error is an URLError of type \(requestErrorAlamofire!), not the expected noConnection type")
        }
    }
}
