//
//  HomeRouter.swift
//  ForYouDicodingIOSExpertSub1
//
//  Created by Moh Zinnur Atthufail Addausi on 04/11/20.
//

import SwiftUI

class HomeRouter {

  func makeDetailView(for place: PlaceModel) -> some View {
    let detailUseCase = Injection.init().provideDetail(place: place)
    let presenter = DetailPresenter(detailUseCase: detailUseCase)
    return DetailView(presenter: presenter)
  }
  
}
