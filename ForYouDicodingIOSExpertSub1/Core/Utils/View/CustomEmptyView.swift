//
//  CustomEmptyView.swift
//  ForYouDicodingIOSExpertSub1
//
//  Created by Moh Zinnur Atthufail Addausi on 15/02/21.
//

import Foundation
import SwiftUI

struct CustomEmptyView: View {
  var image: String
  var title: String
  
  var body: some View {
    VStack {
      Image(image)
        .resizable()
        .renderingMode(.original)
        .scaledToFit()
        .frame(width: 250)
      
      Text(title)
        .font(.system(.body, design: .rounded))
    }
  }
}
