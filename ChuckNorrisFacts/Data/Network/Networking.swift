//
//  Networking.swift
//  ChuckNorrisFacts
//
//  Created by Tatiana Magdalena on 08/03/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation
import RxSwift

protocol Networking {
    func httpRequestObservable(request: HTTPRequest) -> Observable<Data>
}
