//
//  FactsQueryDataModel.swift
//  ChuckNorrisFacts
//
//  Created by Tatiana Magdalena on 05/03/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation

struct FactsQueryDataModel: Decodable {
    var total: Int?
    var result: [Result]?
}

extension FactsQueryDataModel {
    struct Result: Decodable {
        var category: [String]?
        var icon_url: String?
        var id: String?
        var url: String?
        var value: String?
    }
}
