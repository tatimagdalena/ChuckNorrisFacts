//
//  NetworkRequests.swift
//  ChuckNorrisFacts
//
//  Created by Tatiana Magdalena on 09/03/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire

struct NetworkRequests: Networking {
    
    let errorHandler: HandleRequestError
    
    init(errorHandler: HandleRequestError) {
        self.errorHandler = errorHandler
    }
    
    func getHTTPRequestObservable(url: String, parameters: [String : Any]? = nil, headers: [String : String]? = nil) -> Observable<Data> {
        return RxAlamofire
            .requestData(.get, url, parameters: parameters, encoding: URLEncoding.default)
            .catchError(errorHandler.handleCatchedRequestError)
            .do(onNext: { (response, json) in try self.errorHandler.handleHttpStatusCodeError(response: response) })
            .map({ (response, jsonData) in jsonData })
    }
    
}
