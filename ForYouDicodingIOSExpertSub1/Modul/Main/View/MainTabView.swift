//
//  CustomSegmentedPickerView.swift
//  ForYouDicodingIOSExpertSub1
//
//  Created by Moh Zinnur Atthufail Addausi on 01/11/20.
//

import Foundation
import SwiftUI

struct MainTabView: View {
    
    @Binding var selectedIndex: Int
    var titles = ["Home", "Favorites", "Profile"]
    var imagetitles = ["house.fill", "heart.fill", "person.circle.fill"]
    @State var frames = [CGRect](repeating: .zero, count: 3)
    
    var body: some View {
        VStack {
            ZStack {
                HStack(spacing: UIScreen.main.bounds.width /  10) {
                    tabbutton
                }
                .background(
                    Capsule()
                        .fill(Color("cyanactive"))
                        .frame(width: self.frames[self.selectedIndex].width,
                               height: self.frames[self.selectedIndex].height,
                               alignment: .topLeading)
                        .offset(x: self.frames[self.selectedIndex].minX - self.frames[0].minX), alignment: .leading
                )
            }
            .animation(.default)
            Spacer()
        }
    }
    
    func setFrame(index: Int, frame: CGRect) {
        self.frames[index] = frame
    }
}

extension MainTabView {
    var tabbutton  : some View {
        ForEach(self.titles.indices, id: \.self) { index in
            
            Button {
                self.selectedIndex = index
            } label: {
                HStack(spacing: 8) {
                    
                    Image(systemName: self.imagetitles[index])
                        .foregroundColor(Color("texttab"))
                    
                    Text(self.titles[index])
                        .font(Font.footnote)
                        .fontWeight(.bold)
                        .foregroundColor(Color("texttab"))
                }
            }
            .buttonStyle(PlainButtonStyle())
            .padding(8)
            .background(
                GeometryReader { geo in
                    Color.clear.onAppear { self.setFrame(index: index, frame: geo.frame(in: .global)) }
                    
                }
            )
        }
    }
}
