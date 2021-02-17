//
//  HomeView.swift
//  ForYouDicodingIOSExpertSub1
//
//  Created by Moh Zinnur Atthufail Addausi on 01/11/20.
//

import Foundation
import SwiftUI

struct MainView: View {
    
    @State private var bottomSheetShown = true
    @State var selectedIndex  = 0
    
    private let presenter = MainPresenter()
    
    var body: some View {
        
        NavigationView {
            ZStack(alignment: .bottom) {
                
                imagebackgroundMain
                VStack(spacing: 8) {
                    
                    tabview
                    Spacer()
                }
                mainBottomSheet
            }
        }
    }
}

extension MainView {
    
    var tabview: some View {
        
        MainTabView(selectedIndex: $selectedIndex)
    }
    
    var imagebackgroundMain: some View {
        VStack {
            Image("mainbackground")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.top, 20)
                .background(Color("cyanbackground"))
        }.ignoresSafeArea()
    }
    
    var mainBottomSheet: some View {
        GeometryReader { geometry in
            BottomSheetView(
                isOpen: self.$bottomSheetShown,
                maxHeight: geometry.size.height * 0.87,
                minHeight: geometry.size.height * 0.37
            ) {
                
                self.presenter.navigationBuilder(forIndex: self.selectedIndex) {
                    
                }
            }
        }.edgesIgnoringSafeArea(.all)
    }
    
}
