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
    private var networkingMock: MyMocks.NetworkRequests!
    private var mapperMock: MyMocks.FactsModelMapper!
    
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
        networkingMock = MyMocks.NetworkRequests(responseType: responseType)
        mapperMock = MyMocks.FactsModelMapper(responseType: responseType)
        dataSourceUnderTest = FactsDataSource(networking: networkingMock, mapper: mapperMock)
    }
    
    private func assertMapperCallsExpectations(mapper: MyMocks.FactsModelMapper, values: AssertMapperValues, caller: String) {
        expect(mapper.toFactsQueryCallCount).to(equal(values.toFactsQueryCallCount), description: "In \(caller)")
        expect(mapper.toFactArrayCallCount).to(equal(values.toFactArrayCallCount), description: "In \(caller)")
        expect(mapper.toObservableCallCount).to(equal(values.toObservableCallCount), description: "In \(caller)")
    }
    
}

extension FactsDataSourceTests {
    
    struct AssertMapperValues {
        var toFactsQueryCallCount: Int
        var toFactArrayCallCount: Int
        var toObservableCallCount: Int
    }
    
}
