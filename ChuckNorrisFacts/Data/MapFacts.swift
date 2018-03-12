//
//  MapFacts.swift
//  ChuckNorrisFacts
//
//  Created by Tatiana Magdalena on 09/03/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation
import RxSwift

protocol MapFacts {
    func transformToFactsQueryDataModel(json: Any) throws -> FactsQueryDataModel
    func transformToFactsArray(factsQuery: FactsQueryDataModel) throws -> [Fact]
    func transformToFactObservable(facts: [Fact]) -> Observable<Fact>
}
