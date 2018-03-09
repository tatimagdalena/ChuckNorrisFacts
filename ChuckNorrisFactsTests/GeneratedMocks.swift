// MARK: - Mocks generated from file: ChuckNorrisFacts/Data/Networking.swift at 2018-03-09 10:29:45 +0000

//
//  Networking.swift
//  ChuckNorrisFacts
//
//  Created by Tatiana Magdalena on 08/03/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Cuckoo
@testable import ChuckNorrisFacts

import Foundation
import RxSwift

class MockNetworking: Networking, Cuckoo.Mock {
    typealias MocksType = Networking
    typealias Stubbing = __StubbingProxy_Networking
    typealias Verification = __VerificationProxy_Networking
    let cuckoo_manager = Cuckoo.MockManager()

    private var observed: Networking?

    func spy(on victim: Networking) -> Self {
        observed = victim
        return self
    }

    

    

    
    // ["name": "getHTTPRequestObservable", "returnSignature": " -> Observable<Any>", "fullyQualifiedName": "getHTTPRequestObservable(url: String, parameters: [String : Any]?, headers: [String : String]?) -> Observable<Any>", "parameterSignature": "url: String, parameters: [String : Any]?, headers: [String : String]?", "parameterSignatureWithoutNames": "url: String, parameters: [String : Any]?, headers: [String : String]?", "inputTypes": "String, [String : Any]?, [String : String]?", "isThrowing": false, "isInit": false, "hasClosureParams": false, "@type": "ProtocolMethod", "accessibility": "", "parameterNames": "url, parameters, headers", "call": "url: url, parameters: parameters, headers: headers", "parameters": [CuckooGeneratorFramework.MethodParameter(label: Optional("url"), name: "url", type: "String", range: CountableRange(250..<261), nameRange: CountableRange(250..<253)), CuckooGeneratorFramework.MethodParameter(label: Optional("parameters"), name: "parameters", type: "[String : Any]?", range: CountableRange(263..<290), nameRange: CountableRange(263..<273)), CuckooGeneratorFramework.MethodParameter(label: Optional("headers"), name: "headers", type: "[String : String]?", range: CountableRange(292..<319), nameRange: CountableRange(292..<299))], "returnType": "Observable<Any>", "isOptional": false, "stubFunction": "Cuckoo.StubFunction"]
     func getHTTPRequestObservable(url: String, parameters: [String : Any]?, headers: [String : String]?)  -> Observable<Any> {
        
            return cuckoo_manager.call("getHTTPRequestObservable(url: String, parameters: [String : Any]?, headers: [String : String]?) -> Observable<Any>",
                parameters: (url, parameters, headers),
                original: observed.map { o in
                    return { (args) -> Observable<Any> in
                        let (url, parameters, headers) = args
                        return o.getHTTPRequestObservable(url: url, parameters: parameters, headers: headers)
                    }
                })
        
    }
    

    struct __StubbingProxy_Networking: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager

        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        func getHTTPRequestObservable<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(url: M1, parameters: M2, headers: M3) -> Cuckoo.StubFunction<(String, [String : Any]?, [String : String]?), Observable<Any>> where M1.MatchedType == String, M2.MatchedType == [String : Any]?, M3.MatchedType == [String : String]? {
            let matchers: [Cuckoo.ParameterMatcher<(String, [String : Any]?, [String : String]?)>] = [wrap(matchable: url) { $0.0 }, wrap(matchable: parameters) { $0.1 }, wrap(matchable: headers) { $0.2 }]
            return .init(stub: cuckoo_manager.createStub("getHTTPRequestObservable(url: String, parameters: [String : Any]?, headers: [String : String]?) -> Observable<Any>", parameterMatchers: matchers))
        }
        
    }


    struct __VerificationProxy_Networking: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation

        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }

        

        
        @discardableResult
        func getHTTPRequestObservable<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(url: M1, parameters: M2, headers: M3) -> Cuckoo.__DoNotUse<Observable<Any>> where M1.MatchedType == String, M2.MatchedType == [String : Any]?, M3.MatchedType == [String : String]? {
            let matchers: [Cuckoo.ParameterMatcher<(String, [String : Any]?, [String : String]?)>] = [wrap(matchable: url) { $0.0 }, wrap(matchable: parameters) { $0.1 }, wrap(matchable: headers) { $0.2 }]
            return cuckoo_manager.verify("getHTTPRequestObservable(url: String, parameters: [String : Any]?, headers: [String : String]?) -> Observable<Any>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
    }


}

 class NetworkingStub: Networking {
    

    

    
     func getHTTPRequestObservable(url: String, parameters: [String : Any]?, headers: [String : String]?)  -> Observable<Any> {
        return DefaultValueRegistry.defaultValue(for: Observable<Any>.self)
    }
    
}




// MARK: - Mocks generated from file: ChuckNorrisFacts/Data/MapFacts.swift at 2018-03-09 10:29:45 +0000

//
//  MapFacts.swift
//  ChuckNorrisFacts
//
//  Created by Tatiana Magdalena on 09/03/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Cuckoo
@testable import ChuckNorrisFacts

import Foundation
import RxSwift

class MockMapFacts: MapFacts, Cuckoo.Mock {
    typealias MocksType = MapFacts
    typealias Stubbing = __StubbingProxy_MapFacts
    typealias Verification = __VerificationProxy_MapFacts
    let cuckoo_manager = Cuckoo.MockManager()

    private var observed: MapFacts?

    func spy(on victim: MapFacts) -> Self {
        observed = victim
        return self
    }

    

    

    
    // ["name": "transformToFactsQueryDataModel", "returnSignature": " throws -> FactsQueryDataModel", "fullyQualifiedName": "transformToFactsQueryDataModel(json: Any) throws -> FactsQueryDataModel", "parameterSignature": "json: Any", "parameterSignatureWithoutNames": "json: Any", "inputTypes": "Any", "isThrowing": true, "isInit": false, "hasClosureParams": false, "@type": "ProtocolMethod", "accessibility": "", "parameterNames": "json", "call": "json: json", "parameters": [CuckooGeneratorFramework.MethodParameter(label: Optional("json"), name: "json", type: "Any", range: CountableRange(252..<261), nameRange: CountableRange(252..<256))], "returnType": "FactsQueryDataModel", "isOptional": false, "stubFunction": "Cuckoo.StubThrowingFunction"]
     func transformToFactsQueryDataModel(json: Any)  throws -> FactsQueryDataModel {
        
            return try cuckoo_manager.callThrows("transformToFactsQueryDataModel(json: Any) throws -> FactsQueryDataModel",
                parameters: (json),
                original: observed.map { o in
                    return { (args) throws -> FactsQueryDataModel in
                        let (json) = args
                        return try o.transformToFactsQueryDataModel(json: json)
                    }
                })
        
    }
    
    // ["name": "transformToFactsArray", "returnSignature": " throws -> [Fact]", "fullyQualifiedName": "transformToFactsArray(factsQuery: FactsQueryDataModel) throws -> [Fact]", "parameterSignature": "factsQuery: FactsQueryDataModel", "parameterSignatureWithoutNames": "factsQuery: FactsQueryDataModel", "inputTypes": "FactsQueryDataModel", "isThrowing": true, "isInit": false, "hasClosureParams": false, "@type": "ProtocolMethod", "accessibility": "", "parameterNames": "factsQuery", "call": "factsQuery: factsQuery", "parameters": [CuckooGeneratorFramework.MethodParameter(label: Optional("factsQuery"), name: "factsQuery", type: "FactsQueryDataModel", range: CountableRange(324..<355), nameRange: CountableRange(324..<334))], "returnType": "[Fact]", "isOptional": false, "stubFunction": "Cuckoo.StubThrowingFunction"]
     func transformToFactsArray(factsQuery: FactsQueryDataModel)  throws -> [Fact] {
        
            return try cuckoo_manager.callThrows("transformToFactsArray(factsQuery: FactsQueryDataModel) throws -> [Fact]",
                parameters: (factsQuery),
                original: observed.map { o in
                    return { (args) throws -> [Fact] in
                        let (factsQuery) = args
                        return try o.transformToFactsArray(factsQuery: factsQuery)
                    }
                })
        
    }
    
    // ["name": "transformToFactObservable", "returnSignature": " -> Observable<Fact>", "fullyQualifiedName": "transformToFactObservable(facts: [Fact]) -> Observable<Fact>", "parameterSignature": "facts: [Fact]", "parameterSignatureWithoutNames": "facts: [Fact]", "inputTypes": "[Fact]", "isThrowing": false, "isInit": false, "hasClosureParams": false, "@type": "ProtocolMethod", "accessibility": "", "parameterNames": "facts", "call": "facts: facts", "parameters": [CuckooGeneratorFramework.MethodParameter(label: Optional("facts"), name: "facts", type: "[Fact]", range: CountableRange(409..<422), nameRange: CountableRange(409..<414))], "returnType": "Observable<Fact>", "isOptional": false, "stubFunction": "Cuckoo.StubFunction"]
     func transformToFactObservable(facts: [Fact])  -> Observable<Fact> {
        
            return cuckoo_manager.call("transformToFactObservable(facts: [Fact]) -> Observable<Fact>",
                parameters: (facts),
                original: observed.map { o in
                    return { (args) -> Observable<Fact> in
                        let (facts) = args
                        return o.transformToFactObservable(facts: facts)
                    }
                })
        
    }
    

    struct __StubbingProxy_MapFacts: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager

        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        func transformToFactsQueryDataModel<M1: Cuckoo.Matchable>(json: M1) -> Cuckoo.StubThrowingFunction<(Any), FactsQueryDataModel> where M1.MatchedType == Any {
            let matchers: [Cuckoo.ParameterMatcher<(Any)>] = [wrap(matchable: json) { $0 }]
            return .init(stub: cuckoo_manager.createStub("transformToFactsQueryDataModel(json: Any) throws -> FactsQueryDataModel", parameterMatchers: matchers))
        }
        
        func transformToFactsArray<M1: Cuckoo.Matchable>(factsQuery: M1) -> Cuckoo.StubThrowingFunction<(FactsQueryDataModel), [Fact]> where M1.MatchedType == FactsQueryDataModel {
            let matchers: [Cuckoo.ParameterMatcher<(FactsQueryDataModel)>] = [wrap(matchable: factsQuery) { $0 }]
            return .init(stub: cuckoo_manager.createStub("transformToFactsArray(factsQuery: FactsQueryDataModel) throws -> [Fact]", parameterMatchers: matchers))
        }
        
        func transformToFactObservable<M1: Cuckoo.Matchable>(facts: M1) -> Cuckoo.StubFunction<([Fact]), Observable<Fact>> where M1.MatchedType == [Fact] {
            let matchers: [Cuckoo.ParameterMatcher<([Fact])>] = [wrap(matchable: facts) { $0 }]
            return .init(stub: cuckoo_manager.createStub("transformToFactObservable(facts: [Fact]) -> Observable<Fact>", parameterMatchers: matchers))
        }
        
    }


    struct __VerificationProxy_MapFacts: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation

        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }

        

        
        @discardableResult
        func transformToFactsQueryDataModel<M1: Cuckoo.Matchable>(json: M1) -> Cuckoo.__DoNotUse<FactsQueryDataModel> where M1.MatchedType == Any {
            let matchers: [Cuckoo.ParameterMatcher<(Any)>] = [wrap(matchable: json) { $0 }]
            return cuckoo_manager.verify("transformToFactsQueryDataModel(json: Any) throws -> FactsQueryDataModel", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func transformToFactsArray<M1: Cuckoo.Matchable>(factsQuery: M1) -> Cuckoo.__DoNotUse<[Fact]> where M1.MatchedType == FactsQueryDataModel {
            let matchers: [Cuckoo.ParameterMatcher<(FactsQueryDataModel)>] = [wrap(matchable: factsQuery) { $0 }]
            return cuckoo_manager.verify("transformToFactsArray(factsQuery: FactsQueryDataModel) throws -> [Fact]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func transformToFactObservable<M1: Cuckoo.Matchable>(facts: M1) -> Cuckoo.__DoNotUse<Observable<Fact>> where M1.MatchedType == [Fact] {
            let matchers: [Cuckoo.ParameterMatcher<([Fact])>] = [wrap(matchable: facts) { $0 }]
            return cuckoo_manager.verify("transformToFactObservable(facts: [Fact]) -> Observable<Fact>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
    }


}

 class MapFactsStub: MapFacts {
    

    

    
     func transformToFactsQueryDataModel(json: Any)  throws -> FactsQueryDataModel {
        return DefaultValueRegistry.defaultValue(for: FactsQueryDataModel.self)
    }
    
     func transformToFactsArray(factsQuery: FactsQueryDataModel)  throws -> [Fact] {
        return DefaultValueRegistry.defaultValue(for: [Fact].self)
    }
    
     func transformToFactObservable(facts: [Fact])  -> Observable<Fact> {
        return DefaultValueRegistry.defaultValue(for: Observable<Fact>.self)
    }
    
}




// MARK: - Mocks generated from file: ChuckNorrisFacts/Data/HandleRequestError.swift at 2018-03-09 10:29:45 +0000

//
//  HandleRequestError.swift
//  ChuckNorrisFacts
//
//  Created by Tatiana Magdalena on 09/03/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Cuckoo
@testable import ChuckNorrisFacts

import Foundation
import RxSwift

class MockHandleRequestError: HandleRequestError, Cuckoo.Mock {
    typealias MocksType = HandleRequestError
    typealias Stubbing = __StubbingProxy_HandleRequestError
    typealias Verification = __VerificationProxy_HandleRequestError
    let cuckoo_manager = Cuckoo.MockManager()

    private var observed: HandleRequestError?

    func spy(on victim: HandleRequestError) -> Self {
        observed = victim
        return self
    }

    

    

    
    // ["name": "handleHttpStatusCodeError", "returnSignature": " throws", "fullyQualifiedName": "handleHttpStatusCodeError(response: HTTPURLResponse) throws", "parameterSignature": "response: HTTPURLResponse", "parameterSignatureWithoutNames": "response: HTTPURLResponse", "inputTypes": "HTTPURLResponse", "isThrowing": true, "isInit": false, "hasClosureParams": false, "@type": "ProtocolMethod", "accessibility": "", "parameterNames": "response", "call": "response: response", "parameters": [CuckooGeneratorFramework.MethodParameter(label: Optional("response"), name: "response", type: "HTTPURLResponse", range: CountableRange(267..<292), nameRange: CountableRange(267..<275))], "returnType": "Void", "isOptional": false, "stubFunction": "Cuckoo.StubNoReturnThrowingFunction"]
     func handleHttpStatusCodeError(response: HTTPURLResponse)  throws {
        
            return try cuckoo_manager.callThrows("handleHttpStatusCodeError(response: HTTPURLResponse) throws",
                parameters: (response),
                original: observed.map { o in
                    return { (args) throws in
                        let (response) = args
                         try o.handleHttpStatusCodeError(response: response)
                    }
                })
        
    }
    
    // ["name": "handleCatchedRequestError", "returnSignature": " -> Observable<(HTTPURLResponse, Any)>", "fullyQualifiedName": "handleCatchedRequestError(_: Error) -> Observable<(HTTPURLResponse, Any)>", "parameterSignature": "_ error: Error", "parameterSignatureWithoutNames": "error: Error", "inputTypes": "Error", "isThrowing": false, "isInit": false, "hasClosureParams": false, "@type": "ProtocolMethod", "accessibility": "", "parameterNames": "error", "call": "error", "parameters": [CuckooGeneratorFramework.MethodParameter(label: nil, name: "error", type: "Error", range: CountableRange(336..<350), nameRange: CountableRange(0..<0))], "returnType": "Observable<(HTTPURLResponse, Any)>", "isOptional": false, "stubFunction": "Cuckoo.StubFunction"]
     func handleCatchedRequestError(_ error: Error)  -> Observable<(HTTPURLResponse, Any)> {
        
            return cuckoo_manager.call("handleCatchedRequestError(_: Error) -> Observable<(HTTPURLResponse, Any)>",
                parameters: (error),
                original: observed.map { o in
                    return { (args) -> Observable<(HTTPURLResponse, Any)> in
                        let (error) = args
                        return o.handleCatchedRequestError(error)
                    }
                })
        
    }
    

    struct __StubbingProxy_HandleRequestError: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager

        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        func handleHttpStatusCodeError<M1: Cuckoo.Matchable>(response: M1) -> Cuckoo.StubNoReturnThrowingFunction<(HTTPURLResponse)> where M1.MatchedType == HTTPURLResponse {
            let matchers: [Cuckoo.ParameterMatcher<(HTTPURLResponse)>] = [wrap(matchable: response) { $0 }]
            return .init(stub: cuckoo_manager.createStub("handleHttpStatusCodeError(response: HTTPURLResponse) throws", parameterMatchers: matchers))
        }
        
        func handleCatchedRequestError<M1: Cuckoo.Matchable>(_ error: M1) -> Cuckoo.StubFunction<(Error), Observable<(HTTPURLResponse, Any)>> where M1.MatchedType == Error {
            let matchers: [Cuckoo.ParameterMatcher<(Error)>] = [wrap(matchable: error) { $0 }]
            return .init(stub: cuckoo_manager.createStub("handleCatchedRequestError(_: Error) -> Observable<(HTTPURLResponse, Any)>", parameterMatchers: matchers))
        }
        
    }


    struct __VerificationProxy_HandleRequestError: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation

        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }

        

        
        @discardableResult
        func handleHttpStatusCodeError<M1: Cuckoo.Matchable>(response: M1) -> Cuckoo.__DoNotUse<Void> where M1.MatchedType == HTTPURLResponse {
            let matchers: [Cuckoo.ParameterMatcher<(HTTPURLResponse)>] = [wrap(matchable: response) { $0 }]
            return cuckoo_manager.verify("handleHttpStatusCodeError(response: HTTPURLResponse) throws", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func handleCatchedRequestError<M1: Cuckoo.Matchable>(_ error: M1) -> Cuckoo.__DoNotUse<Observable<(HTTPURLResponse, Any)>> where M1.MatchedType == Error {
            let matchers: [Cuckoo.ParameterMatcher<(Error)>] = [wrap(matchable: error) { $0 }]
            return cuckoo_manager.verify("handleCatchedRequestError(_: Error) -> Observable<(HTTPURLResponse, Any)>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
    }


}

 class HandleRequestErrorStub: HandleRequestError {
    

    

    
     func handleHttpStatusCodeError(response: HTTPURLResponse)  throws {
        return DefaultValueRegistry.defaultValue(for: Void.self)
    }
    
     func handleCatchedRequestError(_ error: Error)  -> Observable<(HTTPURLResponse, Any)> {
        return DefaultValueRegistry.defaultValue(for: Observable<(HTTPURLResponse, Any)>.self)
    }
    
}



