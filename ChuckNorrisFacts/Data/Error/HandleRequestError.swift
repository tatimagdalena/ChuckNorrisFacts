//
//  HandleRequestError.swift
//  ChuckNorrisFacts
//
//  Created by Tatiana Magdalena on 09/03/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation
import RxSwift

protocol HandleRequestError {
    func handleHttpStatusCodeError(response: HTTPURLResponse) throws
    func handleCatchedRequestError(_ error: Error) -> Observable<(HTTPURLResponse, Data)>
}
