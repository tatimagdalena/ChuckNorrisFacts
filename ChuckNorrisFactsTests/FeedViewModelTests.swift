//
//  FeedViewModelTests.swift
//  ChuckNorrisFactsTests
//
//  Created by Tatiana Magdalena on 12/03/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import XCTest
import Nimble
import RxBlocking
import RxSwift
@testable import ChuckNorrisFacts

class FeedViewModelTests: XCTestCase {
    
    private var viewModelUnderTest: FeedViewModel!
    private var dataSourceMock: MyMocks.FactsDataSource!
    private var factsMapperMock: MyMocks.FactsModelMapper!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        viewModelUnderTest = nil
        dataSourceMock = nil
        super.tearDown()
    }
    
    func test_Successfull() {
        prepareForTest(dataSourceResponseType: .success, apiResponseType: .validJSON)
        
        do {
            let response = try viewModelUnderTest.getFactsList(searchTerm: "some-term")
                .toBlocking()
                .toArray()
            expect(self.dataSourceMock.getFactsCallCount).to(equal(1))
            expect(response.count).to(equal(2))
            if response.count == 2 {
                assertLoading(state: response[0], caller: #function)
                assertSuccess(state: response[1], caller: #function)
            }
        } catch {
            fail("An error was thrown when it wasn't expected to. Error: \(error)")
        }
        
    }
    
    func test_Error() {
        prepareForTest(dataSourceResponseType: .error, apiResponseType: .validJSON)
        
        do {
            let response = try viewModelUnderTest.getFactsList(searchTerm: "some-term")
                .toBlocking()
                .toArray()
            expect(self.dataSourceMock.getFactsCallCount).to(equal(1))
            expect(response.count).to(equal(2))
            if response.count == 2 {
                assertLoading(state: response[0], caller: #function)
                assertError(state: response[1], caller: #function)
            }
        } catch {
            fail("View model should be able to recover from error.")
        }
    }
    
    private func prepareForTest(dataSourceResponseType: Dummy.DataSourceResponse, apiResponseType: Dummy.APIResponse) {
        dataSourceMock = MyMocks.FactsDataSource(responseType: dataSourceResponseType)
        factsMapperMock = MyMocks.FactsModelMapper(responseType: apiResponseType)
        viewModelUnderTest = FeedViewModel(factsSource: dataSourceMock, factsMapper: factsMapperMock, stateMapper: FeedStateMapper())
    }
    
    private func assertLoading(state: FeedState, caller: String) {
        switch state {
        case .loading: break
        default: fail("State is \(state) when it should be loading (\(caller))")
        }
    }
    
    private func assertSuccess(state: FeedState, caller: String) {
        switch state {
        case .success: break
        default: fail("State is \(state) when it should be success (\(caller))")
        }
    }
    
    private func assertError(state: FeedState, caller: String) {
        switch state {
        case .error: break
        default: fail("State is \(state) when it should be error (\(caller))")
        }
    }
    
}
