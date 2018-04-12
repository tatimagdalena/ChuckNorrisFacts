//
//  FactsDataSource.swift
//  ChuckNorrisFacts
//
//  Created by Tatiana Magdalena on 05/03/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation
import RxSwift

struct FactsDataSource {

    let baseUrl = ProcessInfo.processInfo.arguments.contains("UI-TESTING") ? "http://localhost:8080" : "https://api.chucknorris.io"
    
    let networking: Networking
    let mapper: MapFacts
    let completeUrl: String
    
    init(networking: Networking, mapper: MapFacts) {
        completeUrl = baseUrl + "/jokes/search"
        
        self.networking = networking
        self.mapper = mapper
    }
}

// MARK: - Facts Retrievable -

extension FactsDataSource: FactsRetrievable {
    
    func getFacts(term: String) -> Observable<Fact> {
        
        let queryParameters = ["query" : term as Any]
        
        let factsRequest = HTTPRequest(verb: .get,
                                  url: completeUrl,
                                  parameters: queryParameters,
                                  parametersEncoding: .url,
                                  headers: nil)
        
        return networking.httpRequestObservable(request: factsRequest)
            .map(mapper.transformToFactsQueryDataModel)
            .map(mapper.transformToFactsArray)
            .flatMap(mapper.transformToFactObservable)
    }
    
}
