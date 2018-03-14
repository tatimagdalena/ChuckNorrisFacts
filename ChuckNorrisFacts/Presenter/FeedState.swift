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
    
    var displayMessage: String {
        switch self {
        case .waitingForInput: return "Pesquise por um termo para ver fatos do Chuck Norris"
        case .loading: return "Carregando"
        case .success: return ""
        case .error(let error): return error.displayMessage
        }
    }
}

extension FeedState {
    func isSuccess() -> Bool {
        switch self {
        case .success: return true
        default: return false
        }
    }
}
