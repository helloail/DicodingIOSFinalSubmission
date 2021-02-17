//
//  FavoriteView.swift
//  ForYouDicodingIOSExpertSub1
//
//  Created by Moh Zinnur Atthufail Addausi on 01/11/20.
//

import Foundation
import SwiftUI
import Tourism
import Core

struct FavoriteView: View {
    @ObservedObject var presenter: GetListPresenter<
        String, TourismModel, Interactor<
            String, [TourismModel], GetFavoriteTourismRepository<
                GetFavoriteTourismLocaleDataSource, TourismTransformer>>>
    
    var body: some View {
        
        ZStack {
            
            if presenter.isLoading {
                loadingIndicator
            } else if presenter.isError {
                errorIndicator
            } else if presenter.list.isEmpty {
                emptyState
            } else {
                content
            }
        }.onAppear {
            self.presenter.getList(request: nil)
            
        }
    }
}

extension FavoriteView {
    
    var errorIndicator: some View {
        CustomEmptyView(
            image: "assetSearchNotFound",
            title: presenter.errorMessage
        ).offset(y: 80)
    }
    
    var emptyState: some View {
        VStack {
            Spacer()
            Text("Ikan Hiu Makan Tomat")
                .foregroundColor(Color("textempty"))
                .font(Font.headline.bold())
            
            Text("Kamu Belum Punya Favorit Nih !")
                .foregroundColor(Color("textempty"))
                .font(Font.title2.bold())
            Spacer()
            
            Image("emptystate")
                .resizable()
                .frame( maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
    }
    
    var loadingIndicator: some View {
        VStack {
            Text("Loading...")
                .foregroundColor(Color("text"))
            LoaderIndicator()
        }
    }
    
    var content : some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach( self.presenter.list, id: \.id ) { place in
                
                ZStack {
                    linkBuilder(for: place) {
                        HomeRow(place: place)
                    }
                    .buttonStyle(PlainButtonStyle())
                }.padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
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
