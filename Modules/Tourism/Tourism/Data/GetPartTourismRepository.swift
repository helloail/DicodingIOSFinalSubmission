//
//  GetPartTourismRepository.swift
//  Tourism
//
//  Created by Moh Zinnur Atthufail Addausi on 15/02/21.
//

import Foundation
import Core
import Combine

public struct GetPartTourismRepository<
    PartTourismLocaleDataSource: LocaleDataSource,
    Transformer: Mapper>: Repository
where
    PartTourismLocaleDataSource.Response == TourismModuleEntity,
    Transformer.PartEntity == TourismModuleEntity,
    Transformer.PartDomain == TourismModel {
    
    public typealias Request = Int
    public typealias Response = TourismModel

    private let _localeDataSource: PartTourismLocaleDataSource
    private let _mapper: Transformer

    public init(
        localeDataSource: PartTourismLocaleDataSource,
        mapper: Transformer) {

        _localeDataSource = localeDataSource
        _mapper = mapper
    }

    public func execute(request: Int?) -> AnyPublisher<TourismModel, Error> {
        return _localeDataSource.get(id: request ?? 0)
            .map { _mapper.transformPartEntityToDomain(result: $0) }
            .eraseToAnyPublisher()
    }
}
