//
//  MyMocks.swift
//  ChuckNorrisFactsTests
//
//  Created by Tatiana Magdalena on 12/03/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import XCTest
import RxSwift
@testable import ChuckNorrisFacts

class MyMocks {
    
    class FactsModelMapper: MapFacts {
        
        var toFactsQueryCallCount = 0
        var toFactArrayCallCount = 0
        var toObservableCallCount = 0
        var toFactOutputCallCount = 0
        
        var responseType: Dummy.APIResponse
        init(responseType: Dummy.APIResponse) {
            self.responseType = responseType
        }
        
        func transformToFactsQueryDataModel(jsonData: Data) throws -> FactsQueryDataModel {
            toFactsQueryCallCount += 1
            switch responseType {
            case .validJSON:
                let queryResult = FactsQueryDataModel.Result(category: ["a-category"], icon_url: "some-url", id: "AlsfjokAKsj", url: "some-url", value: "a chuck norris fact")
                return FactsQueryDataModel(total: 1, result: [queryResult])
            case .invalidJSON:
                throw RequestError.Response.cannotParse
            case .error:
                throw RequestError.generic
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
        
        func transformToFactOutput(fact: Fact) -> FactOutput {
            toFactOutputCallCount += 1
            return FactOutput(phrase: "some phrase", category: "some category", categoryColor: .blue, fontSize: 14)
        }
    }
    
    class NetworkRequests: Networking {
        
        var responseType: Dummy.APIResponse
        init(responseType: Dummy.APIResponse) {
            self.responseType = responseType
        }
        
        func getHTTPRequestObservable(url: String, parameters: [String : Any]?, headers: [String : String]? = nil) -> Observable<Data> {
            switch responseType {
            case .validJSON: return Observable.just(Dummy.queryCorrectJsonData)
            case .invalidJSON: return Observable.just(Dummy.queryErrorJsonData)
            case .error: return Observable.error(RequestError.generic)
            }
        }
        
    }
    
    class FactsDataSource: FactsRetrievable {
        
        var getFactsCallCount = 0
        
        var responseType: Dummy.DataSourceResponse
        init(responseType: Dummy.DataSourceResponse) {
            self.responseType = responseType
        }
        
        func getFacts(term: String) -> Observable<Fact> {
            getFactsCallCount += 1
            
            switch responseType {
            case .success:
                let fact = Fact(id: "jfjfi", phrase: "some phrase", category: [])
                let fact2 = Fact(id: "jfjfi", phrase: "some phrase", category: [])
                return Observable.from([fact, fact2])
            case .error:
                return Observable.error(RequestError.generic)
            }
        }
        
    }
    
    class RequestErrorHandler: HandleRequestError {
        
        var catchedErrorCallCount = 0
        var httpCodeErrorCallCount = 0
        
        func handleCatchedRequestError(_ error: Error) -> Observable<(HTTPURLResponse, Data)> {
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
