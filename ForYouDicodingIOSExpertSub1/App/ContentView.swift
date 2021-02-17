//
//  ContentView.swift
//  ForYouDicodingIOSExpertSub1
//
//  Created by Moh Zinnur Atthufail Addausi on 01/11/20.
//

import SwiftUI
import Core
import Tourism

struct ContentView: View {
    
    @EnvironmentObject var homePresenter: GetListPresenter<
        Any, TourismModel, Interactor
        <Any, [TourismModel], GetTourismRepository<GetTourismLocaleDataSource,
                                                   GetTourismRemoteDataSource, TourismTransformer>>>
    
    @EnvironmentObject var favoritePresenter: GetListPresenter<
        String, TourismModel, Interactor
        <String, [TourismModel], GetFavoriteTourismRepository<GetFavoriteTourismLocaleDataSource, TourismTransformer>>>
    
    var body: some View {
        TabView {
            NavigationView {
                HomeView(presenter: homePresenter)
            }.tabItem {
                TabItem(imageName: "house", title: "Home")
            }
            
            NavigationView {
                FavoriteView(presenter: favoritePresenter)
            }.tabItem {
                TabItem(imageName: "heart", title: "Fsvourites")
            }
            
            NavigationView {
                AboutView()
            }.tabItem {
                TabItem(imageName: "person", title: "About")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
