//
//  AboutView.swift
//  ForYouDicodingIOSExpertSub1
//
//  Created by Moh Zinnur Atthufail Addausi on 11/11/20.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        content
    }
}

extension AboutView {
    
    var content : some View {
        
        VStack(alignment: .center, spacing: 16 ) {
            imageDetail
            nameAbout
            emailAbout
            Spacer()
            footerAbout
        }.padding(30)
    }
    
    var imageDetail: some View {
        
        Image("fotosaya")
            .resizable()
            
            .aspectRatio( contentMode: .fill)
            .frame(width: 200, height: 200)
            .clipShape(Circle())
    }
    
    var nameAbout : some View {
        Text("Moh. Zinnur Atthufail Addausi")
            .font(.footnote)
            .foregroundColor(Color("text"))
        
    }
    
    var emailAbout : some View {
        Text("zinnuratthufail2@gmail.com")
            .font(.footnote)
            .padding(.top, -10)
            .foregroundColor(Color("text"))
        
    }
    
    var footerAbout : some View {
        Text("IOS Developer @ Apple Developer Academy | UC")
            .font(.footnote)
            .foregroundColor(Color("text"))
            .bold()
        
    }
}
