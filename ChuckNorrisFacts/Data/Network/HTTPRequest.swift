//
//  HTTPRequest.swift
//  ChuckNorrisFacts
//
//  Created by Tatiana Magdalena on 26/03/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation

struct HTTPRequest {
    let verb: HTTPVerb
    let url: String
    let parameters: [String : Any]?
    let parametersEncoding: ParameterEncoding
    let headers: [String : String]?
}
