//
//  AppDelegate.swift
//  ChuckNorrisFacts
//
//  Created by Tatiana Magdalena on 02/03/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let factsMapper = FactsModelMapper()
        let errorHandler = RequestErrorHandler()
        let networkRequests = NetworkRequests(errorHandler: errorHandler)
        let factsSource = FactsDataSource(networking: networkRequests, mapper: factsMapper)
        let stateMapper = FeedStateMapper()
        let feedViewModel = FeedViewModel(factsSource: factsSource, factsMapper: factsMapper, stateMapper: stateMapper)
        let feedViewController = FeedViewController(viewModel: feedViewModel)
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: feedViewController)
        window?.makeKeyAndVisible()
        
        return true
    }

}

