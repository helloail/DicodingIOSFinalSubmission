//
//  HomeView.swift
//  ForYouDicodingIOSExpertSub1
//
//  Created by Moh Zinnur Atthufail Addausi on 01/11/20.
//

import SwiftUI
import Tourism
import Core

struct HomeView: View {
    @ObservedObject var presenter: GetListPresenter<
        Any, TourismModel, Interactor<
            Any, [TourismModel], GetTourismRepository<
                GetTourismLocaleDataSource, GetTourismRemoteDataSource, TourismTransformer>>>
    
    var body: some View {
        ZStack {
            if presenter.isLoading {
                loadingIndicator
            } else if presenter.isError {
                errorIndicator
            } else if presenter.list.isEmpty {
                emptyCategories
            } else {
                content
            }
        }.onAppear {
            if self.presenter.list.count == 0 {
                self.presenter.getList(request: nil)
                
            }
        }.colorScheme(.light)
    }
}

extension HomeView {
    
    var errorIndicator: some View {
        CustomEmptyView(
            image: "assetSearchNotFound",
            title: presenter.errorMessage
        ).offset(y: 80)
    }
    
    var emptyCategories: some View {
        CustomEmptyView(
            image: "assetNoFavorite",
            title: "The meal category is empty"
        ).offset(y: 80)
    }
    
    var loadingIndicator: some View {
        VStack {
            LoaderIndicator()
            Text("Loading...")
                .foregroundColor(Color("text"))
            
        }
    }
    
    var content : some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach( self.presenter.list, id: \.name ) { place in
       
                ZStack {
                    linkBuilder(for: place) {
                        HomeRow(place: place)
                    }.buttonStyle(PlainButtonStyle())
                }.padding(8)
                
            }.padding(EdgeInsets(top: 8, leading: 24, bottom: 8, trailing: 8))
            
        }
    }
    
    func linkBuilder<Content: View>(
        for tourism: TourismModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        
        NavigationLink(
            destination: DetailRouter().makeDetailView(for: tourism)
        ) { content() }
    }
}
