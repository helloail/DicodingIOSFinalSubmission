//
//  UpdateFavoriteTourismRepository.swift
//  Tourism
//
//  Created by Moh Zinnur Atthufail Addausi on 14/02/21.
//

import Foundation
import Core
import Combine

public struct UpdateFavoriteTourismRepository<
    TourismLocaleDataSource: LocaleDataSource,
    Transformer: Mapper>: Repository
where
    TourismLocaleDataSource.Response == TourismModuleEntity,
    Transformer.PartEntity == TourismModuleEntity,
    Transformer.PartDomain == TourismModel {
  
    public typealias Request = Int
    public typealias Response = TourismModel
    
    private let _localeDataSource: TourismLocaleDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: TourismLocaleDataSource,
        mapper: Transformer) {
        
        _localeDataSource = localeDataSource
        _mapper = mapper
    }
    
    public func execute(request: Int?) -> AnyPublisher<TourismModel, Error> {
        return _localeDataSource.update(id: request ?? 0)
            .map { _mapper.transformPartEntityToDomain(result: $0) }
            .eraseToAnyPublisher()
    }
}
