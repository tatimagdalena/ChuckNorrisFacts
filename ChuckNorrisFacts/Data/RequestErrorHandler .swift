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
        case 400: throw RequestError.client(.badRequest)
        case 401: throw RequestError.client(.unauthorized)
        case 404: throw RequestError.client(.notFound)
        case 400..<500: throw RequestError.client(.generic)
        case 500: throw RequestError.server(.internalServerError)
        case 503: throw RequestError.server(.serviceUnavailable)
        case 500..<600: throw RequestError.server(.generic)
        default: throw RequestError.generic
        }
    }
    
    func handleCatchedRequestError(_ error: Error) -> Observable<(HTTPURLResponse, Data)> {
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
    
    private func transformToDomainError(urlError: URLError) -> RequestError {
        switch urlError.code {
        case .notConnectedToInternet: return .url(.noConnection)
        case .timedOut: return .url(.timeOut)
        case .networkConnectionLost: return .url(.connectionLost)
        default: return .generic
        }
    }
    
    private func transformToDomainError(afError: AFError) -> RequestError {
        switch afError {
        case .invalidURL: return .request(.invalidUrl)
        case .parameterEncodingFailed: return .request(.parameterEncodingFailed)
        case .responseSerializationFailed: return .request(.responseSerializationFailed)
        case .responseValidationFailed: return .request(.responseValidationFailed)
        default: return .request(.generic)
        }
    }
    
}
