//
//  MainPresenter.swift
//  ForYouDicodingIOSExpertSub1
//
//  Created by Moh Zinnur Atthufail Addausi on 07/11/20.
//

import SwiftUI

class MainPresenter {
    
    private let router = MainRouter()
    
    func navigationBuilder<Content: View>(forIndex index: Int, @ViewBuilder content: () -> Content) -> some View {
      
            router.createNavigation(index: index)
                .navigationBarHidden(true)
        
    }
    
}
