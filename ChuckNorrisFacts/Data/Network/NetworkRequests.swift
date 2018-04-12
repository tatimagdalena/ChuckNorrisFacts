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
    
    func httpRequestObservable(request: HTTPRequest) -> Observable<Data> {
        return RxAlamofire
            .requestData(transformToHTTPMethod(request.verb), request.url, parameters: request.parameters, encoding: transformToAlamofireEncoding(request.parametersEncoding))
            .catchError(errorHandler.handleCatchedRequestError)
            .do(onNext: { (response, json) in try self.errorHandler.handleHttpStatusCodeError(response: response) })
            .map({ (response, jsonData) in jsonData })
    }
    
}

private extension NetworkRequests {
    
    func transformToHTTPMethod(_ verb: HTTPVerb) -> HTTPMethod {
        switch verb {
        case .get: return .get
        case .post: return .post
        }
    }
    
    func transformToAlamofireEncoding(_ encoding: ParameterEncoding) -> Alamofire.ParameterEncoding {
        switch encoding {
        case .url: return URLEncoding.default
        case .json: return JSONEncoding.default
        }
    }
    
}
