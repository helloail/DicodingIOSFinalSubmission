//
//  GetFavoriteTourismRepository.swift
//  Tourism
//
//  Created by Moh Zinnur Atthufail Addausi on 13/02/21.
//

import Foundation
import Core
import Combine

public struct GetFavoriteTourismRepository <
    TourismLocaleDataSource: LocaleDataSource,
    Transformer: Mapper>: Repository
where
    TourismLocaleDataSource.Response == TourismModuleEntity,
    Transformer.Entity == [TourismModuleEntity],
    Transformer.Domain == [TourismModel] {
    
    public typealias Request = String
    public typealias Response = [TourismModel]
    
    private let _localeDataSource: TourismLocaleDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: TourismLocaleDataSource,
        mapper: Transformer) {
        
        _localeDataSource = localeDataSource
        _mapper = mapper
    }
    
    public func execute(request: String?) -> AnyPublisher<[TourismModel], Error> {
        return _localeDataSource.list(request: nil)
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
    }
}
