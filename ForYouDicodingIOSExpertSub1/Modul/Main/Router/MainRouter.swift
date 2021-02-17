//
//  NavigationFactory.swift
//  ForYouDicodingIOSExpertSub1
//
//  Created by Moh Zinnur Atthufail Addausi on 01/11/20.
//

import Foundation
import SwiftUI

class MainRouter {
    
    @EnvironmentObject var homePresenter: HomePresenter
    
     func createNavigation(index: Int) -> some View {
        
        switch index {
        
        case 0: return AnyView(makeHomeView())
        case 1: return AnyView(makeFavoriteView())
        case 2: return AnyView(makeAboutView())
        default:
            return AnyView(makeAboutView())
        }
    }
}

extension MainRouter {
    
    func makeHomeView() -> some View {
        let homeUseCase = Injection.init().provideHome()
        let presenter = HomePresenter(homeUseCase: homeUseCase)
        return HomeView(presenter: presenter)
    }
    
    func makeFavoriteView() -> some View {
        
        let favouriteUseCase = Injection.init().provideFavourite()
        let presenter = FavouritePresenter(favouriteUseCase: favouriteUseCase)
        return FavoriteView(presenter: presenter)
    }
    
    func makeAboutView() -> some View {
        return AboutView()
    }
}
