//
//  HomeView.swift
//  ForYouDicodingIOSExpertSub1
//
//  Created by Moh Zinnur Atthufail Addausi on 01/11/20.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var presenter: HomePresenter
    
    private let router = HomeRouter()
    
    var body: some View {
        ZStack {
            
            switch presenter.state {
            case .idle, .loading :
                loadingIndicator
            case .error(let error):
                Text("Error \(error.localizedDescription)")
            case .loaded:
                VStack {
                    content
                }
            case .empty:
                Text("")
            }
        }.onAppear {
            if self.presenter.places.count == 0 {
                self.presenter.getPlace()
            }
        }
    }
}

extension HomeView {
    
    var loadingIndicator: some View {
        VStack {
            LoaderIndicator()
            Text("Loading...")
        }
    }
    
    var content : some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach( self.presenter.places, id: \.name ) { place in
        
                ZStack {
                    self.presenter.linkBuilder(for: place) {
                        HomeRow(place: place)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                }.padding(EdgeInsets(top: 8, leading: 24, bottom: 8, trailing: 8))
                
            }
        }
    }
}
