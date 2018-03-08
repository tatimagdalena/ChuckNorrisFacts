//
//  FactsModelMapper.swift
//  ChuckNorrisFacts
//
//  Created by Tatiana Magdalena on 07/03/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation
import RxSwift

struct FactsModelMapper {
    
    func transformToFactsQueryDataModel(json: Any) throws -> FactsQueryDataModel {
        guard let jsonDictionary = json as? [String : Any] else { throw RequestError.Response.cannotParse }
        return self.deserializeFactsQuery(json: jsonDictionary)
    }
    
    func transformToFactsArray(factsQuery: FactsQueryDataModel) throws -> [Fact] {
        guard let factsQueryResult = factsQuery.result else { throw RequestError.Response.missingParameter }
        var facts = [Fact]()
        for factResult in factsQueryResult {
            let fact = try self.transformToDomainModel(dataModel: factResult)
            facts.append(fact)
        }
        return facts
    }
    
    func transformToFactObservable(facts: [Fact]) -> Observable<Fact> {
        return Observable.from(facts)
    }
    
    func transformToDomainModel(dataModel: FactsQueryDataModel.Result) throws -> Fact {
        guard let id = dataModel.id,
            let value = dataModel.value
            else { throw RequestError.Response.missingParameter }
        
        return Fact(id: id, phrase: value, category: dataModel.category ?? [String]())
    }
    
    func deserializeFactsQuery(json: [String : Any]) -> FactsQueryDataModel {
        return FactsQueryDataModel(from: json)
    }
    
}
