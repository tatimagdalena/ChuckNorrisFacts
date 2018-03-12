//
//  FeedViewModel.swift
//  ChuckNorrisFacts
//
//  Created by Tatiana Magdalena on 12/03/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation
import RxSwift

struct FeedViewModel {
    
    private var factsSource: FactsRetrievable
    private var factsMapper: MapFacts
    private var stateMapper: MapFeedState
    
    init(factsSource: FactsRetrievable, factsMapper: MapFacts, stateMapper: MapFeedState) {
        self.factsSource = factsSource
        self.factsMapper = factsMapper
        self.stateMapper = stateMapper
    }
    
    func getFactsList(searchTerm term: String) -> Observable<FeedState> {
        return factsSource.getFacts(term: term)
            .map(factsMapper.transformToFactOutput)
            .toArray()
            .map(stateMapper.transformToFeedState)
            .startWith(.loading)
            .catchError(stateMapper.transformToFeedStateObservable)
    }
    
}
