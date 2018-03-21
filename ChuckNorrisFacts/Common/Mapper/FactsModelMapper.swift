//
//  FactsModelMapper.swift
//  ChuckNorrisFacts
//
//  Created by Tatiana Magdalena on 07/03/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation
import RxSwift

struct FactsModelMapper: MapFacts {
    
    func transformToFactsQueryDataModel(jsonData: Data) throws -> FactsQueryDataModel {
        do {
            return try JSONDecoder().decode(FactsQueryDataModel.self, from: jsonData)
        } catch {
            throw RequestError.response(.cannotParse)
        }
    }
    
    func transformToFactsArray(factsQuery: FactsQueryDataModel) throws -> [Fact] {
        guard let factsQueryResult = factsQuery.result else { throw RequestError.response(.missingParameter) }
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
    
    func transformToFactOutput(fact: Fact) -> FactOutput {
        return FactOutput(phrase: fact.phrase,
                          category: fact.category.isEmpty ? "UNCATEGORIZED" : fact.category[0].capitalized,
                          categoryColor: fact.category.isEmpty ? Color.darkGray : Color.blue,
                          fontSize: fact.phrase.count > 50 ? 14 : 16)
    }
    
    private func transformToDomainModel(dataModel: FactsQueryDataModel.Result) throws -> Fact {
        guard let id = dataModel.id,
            let value = dataModel.value
            else { throw RequestError.response(.missingParameter) }
        
        return Fact(id: id, phrase: value, category: dataModel.category ?? [String]())
    }
    
}
