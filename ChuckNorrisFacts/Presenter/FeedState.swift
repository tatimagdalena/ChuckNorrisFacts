//
//  FeedState.swift
//  ChuckNorrisFacts
//
//  Created by Tatiana Magdalena on 12/03/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation

enum FeedState {
    case waitingForInput
    case loading
    case success(facts: [FactOutput])
    case error(RequestError)
}
