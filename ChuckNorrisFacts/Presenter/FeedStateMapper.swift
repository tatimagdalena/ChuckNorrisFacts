//
//  FeedStateMapper.swift
//  ChuckNorrisFacts
//
//  Created by Tatiana Magdalena on 13/03/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation
import RxSwift

protocol MapFeedState {
    func transformToFeedState(factOutputs: [FactOutput]) -> FeedState
    func transformToFeedStateObservable(error: Error) -> Observable<FeedState>
}

struct FeedStateMapper: MapFeedState {
    func transformToFeedState(factOutputs: [FactOutput]) -> FeedState {
        return .success(facts: factOutputs)
    }
    
    func transformToFeedStateObservable(error: Error) -> Observable<FeedState> {
        return Observable.create({ (observer) -> Disposable in
            observer.onNext(.error(error as! RequestError))
            observer.onCompleted()
            return Disposables.create { print("disposed") }
        })
    }
}
