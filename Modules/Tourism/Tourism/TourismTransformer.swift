//
//  TourismTransformer.swift
//  Tourism
//
//  Created by Moh Zinnur Atthufail Addausi on 12/02/21.
//

import Core

public struct TourismTransformer: Mapper {
   
    public typealias Response = [PlaceResponse]
    public typealias Entity = [TourismModuleEntity]
    public typealias Domain = [TourismModel]
    public typealias PartDomain = TourismModel
    public typealias PartEntity = TourismModuleEntity
    public init() {}
    
    public func transformResponseToEntity( response: [PlaceResponse] ) -> [TourismModuleEntity] {
        return response.map { result in
            let newPlace = TourismModuleEntity()
            newPlace.id = result.id ?? 0
            newPlace.name = result.name ?? "Unknow"
            newPlace.image = result.image ?? "Unknow"
            newPlace.desc = result.placeDescription ?? "Unknow"
            newPlace.address = result.address ?? "Unknow"
            newPlace.longitude = result.longitude ?? 0.0
            newPlace.latitude = result.latitude ?? 0.0
            return newPlace
        }
    }
    
    public func transformEntityToDomain ( entity: [TourismModuleEntity] ) -> [TourismModel] {
        
        return entity.map { result in
            
            return TourismModel(
                id: result.id,
                name: result.name,
                placeDescription: result.desc,
                address: result.address,
                longitude: result.longitude,
                latitude: result.latitude,
                image: result.image,
                favorite: result.favorite
                
            )
        }
    }
    public func transformPartEntityToDomain(result: TourismModuleEntity) -> TourismModel {
        return TourismModel(
            id: result.id,
            name: result.name,
            placeDescription: result.desc,
            address: result.address,
            longitude: result.longitude,
            latitude: result.latitude,
            image: result.image,
            favorite: result.favorite
            
        )
    }
    
}
