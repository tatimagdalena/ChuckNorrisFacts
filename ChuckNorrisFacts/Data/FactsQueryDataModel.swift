//
//  FactsQueryDataModel.swift
//  ChuckNorrisFacts
//
//  Created by Tatiana Magdalena on 05/03/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation

struct FactsQueryDataModel {
    var total: Int?
    var result: [Result]?

    init(from json: [String : Any]) {
        total = json["total"] as? Int
        if let resultJsonArray = json["result"] as? [[String : Any]] {
            result = []
            for resultJson in resultJsonArray {
                result?.append(Result(from: resultJson))
            }
        }

    }
}

// MARK: - Inner structs -

extension FactsQueryDataModel {
    struct Result {
        var category: [String]?
        var icon_url: String?
        var id: String?
        var url: String?
        var value: String?

        init(from json: [String : Any]) {
            category = json["category"] as? [String]
            icon_url = json["icon_url"] as? String
            id = json["id"] as? String
            url = json["url"] as? String
            value = json["value"] as? String
        }
    }
}


