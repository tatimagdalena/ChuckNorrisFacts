//
//  FactsDataSource.swift
//  ChuckNorrisFacts
//
//  Created by Tatiana Magdalena on 05/03/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire

struct FactsDataSource {
    private let baseUrl = "https://api.chucknorris.io/jokes/search"
    
    let errorHandler: RequestErrorHandler
    let mapper: FactsModelMapper
    
    init(errorHandler: RequestErrorHandler, mapper: FactsModelMapper) {
        self.errorHandler = errorHandler
        self.mapper = mapper
    }
}

// MARK: - Facts Retrievable -

extension FactsDataSource: FactsRetrievable {
    
    func getFacts(term: String) -> Observable<Fact> {
        
        let queryParameters = ["query" : term as Any]
        
        return RxAlamofire
            .requestJSON(.get, baseUrl, parameters: queryParameters, encoding: URLEncoding.default)
            .catchError(errorHandler.handleCatchedRequestError)
            .do(onNext: { (response, json) in try self.errorHandler.handleHttpStatusCodeError(response: response) })
            .map({ (response, json) in try self.mapper.transformToFactsQueryDataModel(json: json) })
            .map(mapper.transformToFactsArray)
            .flatMap(mapper.transformToFactObservable)
    }
    
}
