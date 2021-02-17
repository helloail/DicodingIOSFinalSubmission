//
//  GetFavoriteTourismLocaleDataSource.swift
//  Tourism
//
//  Created by Moh Zinnur Atthufail Addausi on 12/02/21.
//

import Core
import Combine
import RealmSwift
import Foundation

public struct GetFavoriteTourismLocaleDataSource: LocaleDataSource {

    public typealias Request = String
    
    public typealias Response = TourismModuleEntity
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    public func list(request: String?) -> AnyPublisher<[TourismModuleEntity], Error> {
        return Future<[TourismModuleEntity], Error> { completion in
            
            let tourismEntity = {
                _realm.objects(TourismModuleEntity.self)
                    .filter("favorite = \(true)")
                    .sorted(byKeyPath: "name", ascending: true)
            }()
            completion(.success(tourismEntity.toArray(ofType: TourismModuleEntity.self)))
            
        }.eraseToAnyPublisher()
    }
  
    public func get(id: Int) -> AnyPublisher<TourismModuleEntity, Error> {
        
        return Future<TourismModuleEntity, Error> { completion in
            if let tourismEntity = {
                _realm.objects(TourismModuleEntity.self).filter("id = \(id)")
            }().first {
                completion(.success(tourismEntity))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }

        }.eraseToAnyPublisher()
    }
    
    public func add(entities: [TourismModuleEntity]) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    public func update(id: Int) -> AnyPublisher<TourismModuleEntity, Error> {
        return Future<TourismModuleEntity, Error> { completion in
            if let tourismEntity = {
                _realm.objects(TourismModuleEntity.self).filter("id = \(id)")
            }().first {
                do {
                    try _realm.write {
                        tourismEntity.setValue(!tourismEntity.favorite, forKey: "favorite")
                    }
                    completion(.success(tourismEntity))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
}
