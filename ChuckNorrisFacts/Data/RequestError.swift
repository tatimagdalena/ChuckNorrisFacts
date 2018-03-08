//
//  RequestError.swift
//  ChuckNorrisFacts
//
//  Created by Tatiana Magdalena on 06/03/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation

enum RequestError: Error {
    enum Url: Error {
        case noConnection
        case connectionLost
        case timeOut
        case generic
    }
    enum Request: Error {
        case invalidUrl
        case parameterEncodingFailed
        case responseSerializationFailed
        case responseValidationFailed
        case generic
    }
    enum Response: Error {
        case cannotParse
        case missingParameter
        case empty
    }
    enum Client: Error {
        case badRequest
        case unauthorized
        case notFound
        case generic
    }
    enum Server: Error {
        case internalServerError
        case serviceUnavailable
        case generic
    }
    case generic
}
