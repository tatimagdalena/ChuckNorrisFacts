//
//  FactsDataSourceTests.swift
//  ChuckNorrisFactsTests
//
//  Created by Tatiana Magdalena on 06/03/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import XCTest
import RxBlocking
import RxTest
import RxSwift
import Nimble
@testable import ChuckNorrisFacts

class FactsDataSourceTests: XCTestCase {
    
    private var dataSourceUnderTest: FactsDataSource!
    private var networkingMock: MyMockNetworking!
    private var mapperMock: MyMockMapFacts!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        dataSourceUnderTest = nil
        mapperMock = nil
        networkingMock = nil
        super.tearDown()
    }
    
    func test_ValidAPIResponse_ValidFactObservableReturn() {
        prepareForTest(responseType: .validJSON)
        
        do {
            let response = try dataSourceUnderTest.getFacts(term: "someTerm").toBlocking().toArray()
            assertMapperCallsExpectations(mapper: mapperMock, values: AssertMapperValues(toFactsQueryCallCount: 1, toFactArrayCallCount: 1, toObservableCallCount: 1), caller: #function)
            expect(response.count).to(equal(2))
        } catch {
            fail("An error was thrown when it wasn't expected. Error: \(error)")
        }
        
    }
    
    func test_InvalidAPIResponse_ObservableErrorResponse() {
        prepareForTest(responseType: .invalidJSON)
        
        do {
            _ = try dataSourceUnderTest.getFacts(term: "someTerm").toBlocking().toArray()
            fail("This method should have thrown some error")
        } catch {
            assertMapperCallsExpectations(mapper: mapperMock, values: AssertMapperValues(toFactsQueryCallCount: 1, toFactArrayCallCount: 0, toObservableCallCount: 0), caller: #function)
        }
    }
    
    func test_ThrownErrorAPI_ObservableErrorResponse() {
        prepareForTest(responseType: .error)
        
        do {
            _ = try dataSourceUnderTest.getFacts(term: "someTerm").toBlocking().toArray()
            fail("This method should have thrown some error")
        } catch {
            assertMapperCallsExpectations(mapper: mapperMock, values: AssertMapperValues(toFactsQueryCallCount: 0, toFactArrayCallCount: 0, toObservableCallCount: 0), caller: #function)
        }
    }
    
    private func prepareForTest(responseType: Dummy.APIResponse) {
        networkingMock = MyMockNetworking(responseType: responseType)
        mapperMock = MyMockMapFacts(responseType: responseType)
        dataSourceUnderTest = FactsDataSource(networking: networkingMock, mapper: mapperMock)
    }
    
    private func assertMapperCallsExpectations(mapper: MyMockMapFacts, values: AssertMapperValues, caller: String) {
        expect(mapper.toFactsQueryCallCount).to(equal(values.toFactsQueryCallCount))
        expect(mapper.toFactArrayCallCount).to(equal(values.toFactArrayCallCount))
        expect(mapper.toObservableCallCount).to(equal(values.toObservableCallCount))
    }
    
}

extension FactsDataSourceTests {
    
    struct AssertMapperValues {
        var toFactsQueryCallCount: Int
        var toFactArrayCallCount: Int
        var toObservableCallCount: Int
    }
    
    class MyMockMapFacts: MapFacts {
        
        var toFactsQueryCallCount = 0
        var toFactArrayCallCount = 0
        var toObservableCallCount = 0
        
        var responseType: Dummy.APIResponse
        init(responseType: Dummy.APIResponse) {
            self.responseType = responseType
        }
        
        func transformToFactsQueryDataModel(json: Any) throws -> FactsQueryDataModel {
            toFactsQueryCallCount += 1
            switch responseType {
            case .validJSON: return FactsQueryDataModel(from: Dummy.jsonArray)
            case .invalidJSON: throw RequestError.Response.cannotParse
            case .error: throw RequestError.generic
            }
        }
        
        func transformToFactsArray(factsQuery: FactsQueryDataModel) throws -> [Fact] {
            toFactArrayCallCount += 1
            let fact = Fact(id: "jfjfi", phrase: "some phrase", category: [])
            return [fact]
        }
        
        func transformToFactObservable(facts: [Fact]) -> Observable<Fact> {
            toObservableCallCount += 1
            let fact = Fact(id: "jfjfi", phrase: "some phrase", category: [])
            let fact2 = Fact(id: "jfjfi", phrase: "some phrase", category: [])
            return Observable.from([fact, fact2])
        }
    }
    
    class MyMockNetworking: Networking {
        
        var responseType: Dummy.APIResponse
        init(responseType: Dummy.APIResponse) {
            self.responseType = responseType
        }
        
        func getHTTPRequestObservable(url: String, parameters: [String : Any]?, headers: [String : String]? = nil) -> Observable<Any> {
            switch responseType {
            case .validJSON: return Observable.just(Dummy.dataJSONContent as Any)
            case .invalidJSON: return Observable.just(Dummy.dataJSONErrorContent as Any)
            case .error: return Observable.error(RequestError.generic)
            }
        }
        
    }
    
    struct Dummy {
        
        enum APIResponse {
            case validJSON
            case invalidJSON
            case error
        }
        
        static let dataJSONContent = """
        {\"total\":2,\"result\":\
        "[{\"category\":null,\"icon_url\":\"some-icon-url\",\"id\":\"tjq8lv6lqi-uoo5cxiu2oa\",\"url\":\"some-url\",\"value\":\"This one has no category.\"},\
        "{\"category\":null,\"icon_url\":\"some-icon-url\",\"id\":\"H7lHICEVSsW25ffciJEjxw\",\"url\":\"some-url\",\"value\":\"This one has no cateogry.\"}]}
        """
        static let dataJSONErrorContent = """
        {\"total\":4,\"result\":\
        "[{\"category\":null,\"icon_url\":\"some-icon-url\",\"id\":\"tjq8lv6lqi-uoo5cxiu2oa\",\"url\":\"some-url\",\"value\":\"This one has no category.\"},\
        "{\"category\":\"category1\",\"icon_url\":\"some-icon-url\",\"id\":\"H7lHICEVSsW25ffciJEjxw\",\"url\":\"some-url\",\"value\":\"This one has all properties.\"},\
        "{\"category\":\"category2\",\"icon_url\":\"some-icon-url\",\"id\":\"H7lHICEVSsW25ffciJEjxw\",\"url\":\"some-url\",\"value\":null},\
        "{\"category\":null,\"icon_url\":\"some-icon-url\",\"id\":null,\"url\":\"some-url\",\"value\":\"This one is missing an id.\"}]}
        """
        
        static let jsonArray: [String : Any] = [ "total": 2,
                                                 "result": [[ "category": nil,
                                                              "icon_url": "someurl",
                                                              "id": "someid",
                                                              "url": "someurl",
                                                              "value": "somephrase",
                                                              ],
                                                            [ "category": nil,
                                                              "icon_url": "someurl",
                                                              "id": "someid",
                                                              "url": "someurl",
                                                              "value": "somephrase",
                                                              ]],
                                                 ]
        
        
    }
}
