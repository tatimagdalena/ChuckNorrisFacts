//
//  FactsRetievable.swift
//  ChuckNorrisFacts
//
//  Created by Tatiana Magdalena on 05/03/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation
import RxSwift

protocol FactsRetrievable {
    func getFacts(term: String) -> Observable<Fact>
}
