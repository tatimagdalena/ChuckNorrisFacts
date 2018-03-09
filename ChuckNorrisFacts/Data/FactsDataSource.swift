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
    private let baseUrl = "https://api.chucknorris.io/jokes/search"
    
    let networking: Networking
    let mapper: MapFacts
    
    init(networking: Networking, mapper: MapFacts) {
        self.networking = networking
        self.mapper = mapper
    }
}

// MARK: - Facts Retrievable -

extension FactsDataSource: FactsRetrievable {
    
    func getFacts(term: String) -> Observable<Fact> {
        
        let queryParameters = ["query" : term as Any]
        
        return networking.getHTTPRequestObservable(url: baseUrl, parameters: queryParameters, headers: nil)
            .map(mapper.transformToFactsQueryDataModel)
            .map(mapper.transformToFactsArray)
            .flatMap(mapper.transformToFactObservable)
    }
    
}
