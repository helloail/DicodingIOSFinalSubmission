//
//  SceneDelegate.swift
//  ForYouDicodingIOSExpertSub1
//
//  Created by Moh Zinnur Atthufail Addausi on 01/11/20.
//

import UIKit
import SwiftUI
import Core
import Tourism

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        let homeUseCase: Interactor<
            Any,
            [TourismModel],
            GetTourismRepository<
                GetTourismLocaleDataSource,
                GetTourismRemoteDataSource,
                TourismTransformer>
        > = Injection.init().provideHomeModul()
        
        let favoriteUseCase: Interactor<
            String,
            [TourismModel],
            GetFavoriteTourismRepository<
                GetFavoriteTourismLocaleDataSource,
                TourismTransformer>
        > = Injection.init().provideFavoriteModul()
        
        let homePresenter = GetListPresenter(useCase: homeUseCase)
        let favoritePresenter = GetListPresenter(useCase: favoriteUseCase)
        
        let contentView = ContentView()
            .environmentObject(homePresenter)
            .environmentObject(favoritePresenter)
        
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
    
}
