//
//  TourismModel.swift
//  Tourism
//
//  Created by Moh Zinnur Atthufail Addausi on 12/02/21.
//

import Foundation

public struct TourismModel: Equatable, Identifiable {
    
    public let id: Int
    public let name: String?
    public let placeDescription: String?
    public let address: String?
    public let longitude: Double?
    public let latitude: Double?
    public let image: String?
    public var favorite: Bool = false
}
