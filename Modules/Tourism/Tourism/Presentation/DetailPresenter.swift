//
//  DetailPresenter.swift
//  Tourism
//
//  Created by Moh Zinnur Atthufail Addausi on 13/02/21.
//

import Foundation
import Combine
import Core

public class DetailModulPresenter<Request,
                                  Response,
                                  TourismUseCase: UseCase, FavoriteUseCase: UseCase>: ObservableObject
where
    TourismUseCase.Request == Request, TourismUseCase.Response == Response,
    FavoriteUseCase.Request == Request, FavoriteUseCase.Response == Response {
    private var cancellables: Set<AnyCancellable> = []
    
    private let _tourismUseCase: TourismUseCase
    private let _favoriteUseCase: FavoriteUseCase
    
    @Published public var item: Response?
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    public init(tourismUseCase: TourismUseCase, favoriteUseCase: FavoriteUseCase) {
        _tourismUseCase = tourismUseCase
        _favoriteUseCase = favoriteUseCase
    }
    
    public func getTourism(request: TourismUseCase.Request) {
        isLoading = true
        _tourismUseCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure (let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { item in
                self.item = item
            })
            .store(in: &cancellables)
    }
    
    public func updateFavoriteTourism(request: FavoriteUseCase.Request) {
        _favoriteUseCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { item in
                self.item = item
            })
            .store(in: &cancellables)
    }
    
}
