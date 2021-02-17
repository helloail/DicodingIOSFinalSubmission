//
//  TourismLocaleDataSource.swift
//  Tourism
//
//  Created by Moh Zinnur Atthufail Addausi on 12/02/21.
//

import Foundation
import Core
import Combine
import RealmSwift

// 1
public struct GetTourismLocaleDataSource: LocaleDataSource {
 
    public typealias Request = String
    
    public typealias Response = TourismModuleEntity
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    public func list(request: String?) -> AnyPublisher<[TourismModuleEntity], Error> {
        return Future<[TourismModuleEntity], Error> { completion in
            
            let tourism: Results<TourismModuleEntity> = {
                _realm.objects(TourismModuleEntity.self)
                    .sorted(byKeyPath: "name", ascending: true)
            }()
            
            completion(.success(tourism.toArray(ofType: TourismModuleEntity.self)))
            
        }.eraseToAnyPublisher()
    }
    // 4
    public func add(entities: [TourismModuleEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try _realm.write {
                    for tourism in entities {
                        _realm.add(tourism, update: .all)
                    }
                    completion(.success(true))
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
            
        }.eraseToAnyPublisher()
    }
    
    // 5
    public func get(id: Int) -> AnyPublisher<TourismModuleEntity, Error> {
        fatalError()
    }
    
    // 6
    
    public func update(id: Int) -> AnyPublisher<TourismModuleEntity, Error> {
        fatalError()
    }
}
