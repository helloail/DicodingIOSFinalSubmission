//
//  TourismModuleEntity.swift
//  Tourism
//
//  Created by Moh Zinnur Atthufail Addausi on 12/02/21.
//

import Foundation
import RealmSwift

public class TourismModuleEntity: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var address: String = ""
    @objc dynamic var longitude: Double = 0.0
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var image: String = ""
    @objc dynamic var favorite = false
    
    public override static func primaryKey() -> String? {
        return "id"
    }
}
