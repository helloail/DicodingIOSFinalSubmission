//
//  HomeRouter.swift
//  ForYouDicodingIOSExpertSub1
//
//  Created by Moh Zinnur Atthufail Addausi on 04/11/20.
//

import Foundation
import SwiftUI
import Core
import Tourism

class DetailRouter {
  
    func makeDetailView(for tourism: TourismModel) -> some View {
        
        let useCase: Interactor<Int,
                                TourismModel,
                                UpdateFavoriteTourismRepository
                                <GetFavoriteTourismLocaleDataSource,
                                 TourismTransformer>>
            = Injection.init().provideDetailModul()
        
        let TourismUseCase: Interactor<Int,
                                       TourismModel,
                                       GetPartTourismRepository
                                       <GetFavoriteTourismLocaleDataSource,
                                        TourismTransformer>>
            = Injection.init().providePartTourism()
        
        let presenter = DetailModulPresenter(tourismUseCase: TourismUseCase, favoriteUseCase: useCase)
        
        return DetailView(presenter: presenter, tourism: tourism)
    }
}
