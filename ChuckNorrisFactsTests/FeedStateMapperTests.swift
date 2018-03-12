//
//  FeedStateMapperTests.swift
//  ChuckNorrisFactsTests
//
//  Created by Tatiana Magdalena on 13/03/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import XCTest
import Nimble
@testable import ChuckNorrisFacts

class FeedStateMapperTests: XCTestCase {
    
    private var mapperUnderTest: FeedStateMapper!
    
    override func setUp() {
        super.setUp()
        mapperUnderTest = FeedStateMapper()
    }
    
    override func tearDown() {
        mapperUnderTest = nil
        super.tearDown()
    }
    
    func testSuccessMapping() {
        let factOutput = FactOutput(phrase: "some phrase", category: "some category", categoryColor: .blue, fontSize: 14)
        let feedState = mapperUnderTest.transformToFeedState(factOutputs: [factOutput])
        switch feedState {
        case .success(let outputs):
            if let output = outputs.first {
                expect(output.phrase).to(equal("some phrase"))
                expect(output.category).to(equal("some category"))
                expect(output.fontSize).to(equal(14))
                switch output.categoryColor {
                case .blue: break
                default: fail("Wrong category color mapping.")
                }
            }
        default:
            fail("Wrong mapping.")
        }
    }
    
    func testErrorMapping() {
        let error = RequestError.generic
        do {
            let feedState = try mapperUnderTest.transformToFeedStateObservable(error: error).toBlocking().first()!
            switch feedState {
            case .error: break
            default:
                fail("Wrong mapping.")
            }
        } catch {
            fail("Catched error wasn't correctly transformed to feed state observable.")
        }
    }
    
}
