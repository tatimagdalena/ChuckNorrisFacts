//
//  RequestError.swift
//  ChuckNorrisFacts
//
//  Created by Tatiana Magdalena on 06/03/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation

enum RequestError: Error {
    indirect case url(Url)
    enum Url {
        case noConnection
        case connectionLost
        case timeOut
        case generic
        
        var displayMessage: String {
            switch self {
            case .noConnection: return "Não foi possível encontrar uma conexão de rede. Conecte-se à internet para tentar novamente."
            case .connectionLost: return "Conexão perdida."
            case .timeOut: return "Isto está demorando um pouco mais que o normal."
            case .generic: return "Erro de conexão."
            }
        }
    }
    
    indirect case request(Request)
    enum Request {
        case invalidUrl
        case parameterEncodingFailed
        case responseSerializationFailed
        case responseValidationFailed
        case generic
        
        var displayMessage: String {
            return "Houve um problema com a requisição"
        }
    }
    
    indirect case response(Response)
    enum Response: Error {
        case cannotParse
        case missingParameter
        case empty
        
        var displayMessage: String {
            return "Por favor, tente novamente mais tarde."
        }
    }
    
    indirect case client(Client)
    enum Client: Error {
        case badRequest
        case unauthorized
        case notFound
        case generic
        
        var displayMessage: String {
            switch self {
            case .notFound: return "Não há resultados para o termo pesquisado. Entre com um novo termo para tentar novamente."
            default: return "Não foi possível encontrar resultados com este termo. Entre com um novo termo para tentar novamente."
            }
        }
    }
    
    indirect case server(Server)
    enum Server: Error {
        case internalServerError
        case serviceUnavailable
        case generic
        
        var displayMessage: String {
            return "Por favor, tente novamente mais tarde."
        }
    }
    
    case generic
    
}

extension RequestError {
    var displayMessage: String {
        switch self {
        case .url(let urlError): return urlError.displayMessage
        case .request(let requestError): return requestError.displayMessage
        case .response(let responseError): return responseError.displayMessage
        case .client(let clientError): return clientError.displayMessage
        case .server(let serverError): return serverError.displayMessage
        default:
            return "Ocorreu um erro inesperado."
        }
    }
}
