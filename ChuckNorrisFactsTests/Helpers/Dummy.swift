//
//  Dummy.swift
//  ChuckNorrisFactsTests
//
//  Created by Tatiana Magdalena on 12/03/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation

class Dummy {
    
    enum APIResponse {
        case validJSON
        case invalidJSON
        case error
    }
    
    enum DataSourceResponse {
        case success
        case error
    }
    
    //TODO: Try to use it as lazy var to instance
    
    static var queryCorrectJsonData: Data {
        return loadJson(named: "query_correct_response")
    }
    
    static var queryErrorJsonData: Data {
        return loadJson(named: "query_error_response")
    }
    
    static var genericJsonResponse: Data {
        return loadJson(named: "generic_json_response")
    }

    static let genericParameters = ["parameter" : "value"]
    static let genericHeaders = ["header" : "value"]
    
    static let jsonHeader = ["Content-Type" : "application/json"]
    
    private static func loadJson(named name: String) -> Data {
        do {
            let bundle = Bundle(for: self)
            let path = bundle.path(forResource: name, ofType: "json")
            let url = URL(fileURLWithPath: path!)
            let data = try Data(contentsOf: url)
            return data
        } catch {
            fatalError("It was not possible to load \(name).json from test folder.\nError: \(error)")
        }
    }
}
