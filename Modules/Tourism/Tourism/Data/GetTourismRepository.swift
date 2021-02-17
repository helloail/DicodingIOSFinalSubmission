//
//  GetTourismRepository.swift
//  Tourism
//
//  Created by Moh Zinnur Atthufail Addausi on 12/02/21.
//

import Core
import Combine

// 1
public struct GetTourismRepository<
    TourismLocaleDataSource: LocaleDataSource,
    RemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
    // 2
    TourismLocaleDataSource.Response == TourismModuleEntity,
    RemoteDataSource.Response == [PlaceResponse],
    Transformer.Response == [PlaceResponse],
    Transformer.Entity == [TourismModuleEntity],
    Transformer.Domain == [TourismModel] {
    
    // 3
    public typealias Request = Any
    public typealias Response = [TourismModel]
    
    private let _localeDataSource: TourismLocaleDataSource
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: TourismLocaleDataSource,
        remoteDataSource: RemoteDataSource,
        mapper: Transformer) {
        
        _localeDataSource = localeDataSource
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    // 4
    public func execute(request: Any?) -> AnyPublisher<[TourismModel], Error> {
        return _localeDataSource.list(request: nil)
            .flatMap { result -> AnyPublisher<[TourismModel], Error> in
                if result.isEmpty {
                    return _remoteDataSource.execute(request: nil)
                        .map { _mapper.transformResponseToEntity(response: $0) }
                        .catch { _ in _localeDataSource.list(request: nil) }
                        .flatMap { _localeDataSource.add(entities: $0) }
                        .filter { $0 }
                        .flatMap { _ in _localeDataSource.list(request: nil)
                            .map { _mapper.transformEntityToDomain(entity: $0) }
                        }
                        .eraseToAnyPublisher()
                    
                } else {
                    return _localeDataSource.list(request: nil)
                        .map { _mapper.transformEntityToDomain(entity: $0) }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
}
