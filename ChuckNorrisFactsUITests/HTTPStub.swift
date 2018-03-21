//
//  HTTPStub.swift
//  ChuckNorrisFactsUITests
//
//  Created by Tatiana Magdalena on 23/03/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation
import Swifter

enum HTTPMethod {
    case POST
    case GET
}

enum HTTPResponseStub {
    case ok
    case serverError
    case notFound
    case clientError
}

struct HTTPStubInfo {
    let url: String
    let jsonFilename: String
    let method: HTTPMethod
    let responseType: HTTPResponseStub
}

let initialStubs = [
    HTTPStubInfo(url: "/jokes/search?query=abc", jsonFilename: "query_correct_response", method: .GET, responseType: .ok)
]

class HTTPDynamicStubs {
    
    var server = HttpServer()
    
    func setUp() {
        setupInitialStubs()
        try! server.start()
    }
    
    func tearDown() {
        server.stop()
    }
    
    func setupInitialStubs() {
        // Setting up all the initial mocks from the array
        for stub in initialStubs {
            setupStub(url: stub.url, filename: stub.jsonFilename, method: stub.method, responseType: stub.responseType)
        }
    }
    
    public func setupStub(url: String, filename: String?, method: HTTPMethod = .GET, responseType: HTTPResponseStub) {
        
        var json: Any? = nil
        if let filename = filename {
            let data = Dummy.loadJson(named: filename)
            json = dataToJSON(data: data)
        }
        
        // Swifter makes it very easy to create stubbed responses
        let response: ((HttpRequest) -> HttpResponse) = { _ in
            
            switch responseType {
            case .ok:
                return HttpResponse.ok(.json(json as AnyObject))
            case .serverError:
                return HttpResponse.internalServerError
            case .notFound:
                return HttpResponse.notFound
            case .clientError:
                return HttpResponse.badRequest(nil)
            }
            
        }
        
        switch method  {
        case .GET : server.GET[url] = response
        case .POST: server.POST[url] = response
        }
    }
    
    func dataToJSON(data: Data) -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil
    }
}
