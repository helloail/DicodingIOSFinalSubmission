//
//  API.swift
//  ForYouDicodingIOSExpertSub1
//
//  Created by Moh Zinnur Atthufail Addausi on 15/02/21.
//

import Foundation
struct API {

  static let baseUrl = "https://tourism-api.dicoding.dev/"
}

protocol Endpoint {

  var url: String { get }
}

enum Endpoints {
  
  enum Gets: Endpoint {
    case list
    
    public var url: String {
      switch self {
      case .list: return "\(API.baseUrl)list"
      }
    }
  }
}
////
