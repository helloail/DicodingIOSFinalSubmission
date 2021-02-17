//
//  CircleBackButtonStyle.swift
//  ForYouDicodingIOSExpertSub1
//
//  Created by Moh Zinnur Atthufail Addausi on 15/02/21.
//

import Foundation
import SwiftUI

struct CircleBackButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 40, height: 40)
            .foregroundColor(Color.black)
            .background(Color.white)
            .opacity(0.8)
            .clipShape(Circle())
    }
}
