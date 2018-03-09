//
//  ErrorHandler.swift
//  ChuckNorrisFacts
//
//  Created by Tatiana Magdalena on 07/03/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

struct RequestErrorHandler: HandleRequestError {
    
    func handleHttpStatusCodeError(response: HTTPURLResponse) throws {
        switch response.statusCode {
        case 200..<300: break
        case 400: throw RequestError.Client.badRequest
        case 401: throw RequestError.Client.unauthorized
        case 404: throw RequestError.Client.notFound
        case 400..<500: throw RequestError.Client.generic
        case 500: throw RequestError.Server.internalServerError
        case 503: throw RequestError.Server.serviceUnavailable
        case 500..<600: throw RequestError.Server.generic
        default: throw RequestError.generic
        }
    }
    
    func handleCatchedRequestError(_ error: Error) -> Observable<(HTTPURLResponse, Any)> {
        switch error {
        case let urlError as URLError:
            let domainError = transformToDomainError(urlError: urlError)
            return Observable.error(domainError)
            
        case let afError as AFError:
            let domainError = transformToDomainError(afError: afError)
            return Observable.error(domainError)
            
        default: break
        }
        return Observable.error(RequestError.generic)
    }
    
    private func transformToDomainError(urlError: URLError) -> RequestError.Url {
        switch urlError.code {
        case .notConnectedToInternet: return .noConnection
        case .timedOut: return .timeOut
        case .networkConnectionLost: return .connectionLost
        default: return .generic
        }
    }
    
    private func transformToDomainError(afError: AFError) -> RequestError.Request {
        switch afError {
        case .invalidURL: return .invalidUrl
        case .parameterEncodingFailed: return .parameterEncodingFailed
        case .responseSerializationFailed: return .responseSerializationFailed
        case .responseValidationFailed: return .responseValidationFailed
        default: return .generic
        }
    }
    
}
