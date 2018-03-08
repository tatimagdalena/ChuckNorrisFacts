//
//  FactsDataSourceTests.swift
//  ChuckNorrisFactsTests
//
//  Created by Tatiana Magdalena on 06/03/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import XCTest
import RxTest
import RxBlocking
import RxSwift
@testable import ChuckNorrisFacts

class FactsDataSourceTests: XCTestCase {
    
    private var observer: TestableObserver<Fact>!
    var scheduler: TestScheduler!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        scheduler = TestScheduler(initialClock: 0)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        observer = scheduler.createObserver(Fact.self)
    }
    
}
