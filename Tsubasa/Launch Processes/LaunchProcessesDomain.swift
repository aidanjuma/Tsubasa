//
//  LaunchProcessesDomain.swift
//  Tsubasa
//
//  Created by Aidan Juma on 03/08/2023.
//

import ComposableArchitecture
import Foundation

struct LaunchProcessesDomain: ReducerProtocol {
    struct State: Equatable {
        var isFirstLaunch = {
            if UserDefaults.standard.object(forKey: "isFirstLaunch") == nil {
                UserDefaults.standard.set(true, forKey: "isFirstLaunch")
                return true
            } else {
                return UserDefaults.standard.bool(forKey: "isFirstLaunch")
            }
        }()
        
        var dataLoadingStatus = DataLoadingStatus.notStarted
        var airportList = IdentifiedArrayOf<Airport>()
    }
    
    enum Action: Equatable {
        case fetchAirports
        case fetchAirportsResponse(TaskResult<[Airport]>)
        case completeFirstLaunch
    }
    
    // Dependencies:
    @Dependency(\.airportDataApiClient) var airportDataApiClient
    @Dependency(\.coreDataManager) var coreDataManager
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .fetchAirports:
                if state.isFirstLaunch {
                    if state.dataLoadingStatus == .success || state.dataLoadingStatus == .loading {
                        return .none
                    }
                    
                    state.dataLoadingStatus = .loading
                    return .task {
                        await .fetchAirportsResponse(
                            TaskResult { try await airportDataApiClient.fetchAirports() }
                        )
                    }
                }
                return .none
            case .fetchAirportsResponse(.success(let airports)):
                state.dataLoadingStatus = .success
                state.airportList = IdentifiedArrayOf(
                    uniqueElements: airports
                )
                coreDataManager.insertAirports(state.airportList.elements)
                return .none
            case .fetchAirportsResponse(.failure(let error)):
                state.dataLoadingStatus = .error
                print(error)
                return .none
            case .completeFirstLaunch:
                UserDefaults.standard.set(true, forKey: "isFirstLaunch")
                return .none
            }
        }
    }
}
