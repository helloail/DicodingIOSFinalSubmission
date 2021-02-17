//
//  Injection.swift
//  ForYouDicodingIOSExpertSub1
//
//  Created by Moh Zinnur Atthufail Addausi on 15/02/21.
//

import Foundation
import RealmSwift
import Core
import Tourism

final class Injection: NSObject {

    func provideHomeModul<U: UseCase>() -> U where U.Request == Any, U.Response == [TourismModel] {
        // 2
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
        // 3
        let locale = GetTourismLocaleDataSource(realm: appDelegate.realm)
            
        // 4
        let remote = GetTourismRemoteDataSource(endpoint: Endpoints.Gets.list.url)
            
        // 5
        let mapper = TourismTransformer()
            
        // 6
        let repository = GetTourismRepository(
            localeDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper)
            
        // 7
        return Interactor(repository: repository) as! U
    }
    
    func provideFavoriteModul<U: UseCase>() -> U where U.Request == String, U.Response == [TourismModel] {
        // 2
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
        // 3
        let locale = GetFavoriteTourismLocaleDataSource(realm: appDelegate.realm)
            
        // 5
        let mapper = TourismTransformer()
            
        // 6
        let repository = GetFavoriteTourismRepository(
            localeDataSource: locale,
            mapper: mapper)
            
        // 7
        return Interactor(repository: repository) as! U
    }
    
    func provideDetailModul<U: UseCase>() -> U where U.Request == Int, U.Response == TourismModel {

        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        let locale = GetFavoriteTourismLocaleDataSource(realm: appDelegate.realm)

        let mapper = TourismTransformer()

        let repository = UpdateFavoriteTourismRepository(
            localeDataSource: locale,
            mapper: mapper)
        return Interactor(repository: repository) as! U
    }
    
    func providePartTourism<U: UseCase>() -> U where U.Request == Int, U.Response == TourismModel {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let locale = GetFavoriteTourismLocaleDataSource(realm: appDelegate.realm)
        
        let mapper = TourismTransformer()
            
        let repository = GetPartTourismRepository(
            localeDataSource: locale,
            mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
}
