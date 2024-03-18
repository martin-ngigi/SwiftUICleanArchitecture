//
//  PokemonListViewModel.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 16/03/2024.
//

import Foundation
import SwiftData

class PokemonListViewModel: ObservableObject{
    @Published var state: FetchState = .good
    
    @Published var getPokemonListUseCase: GetPokemonListUseCase = GetPokemonListUseCase(pokeRespository: PokemonListRepository.shared)
    
    @Published var pokemonList: [PokemonEntity] = []
    @Published var offset: Int = 0
    @Published var limit: Int = 10
    
    private var networkInfo = NetworkInfoImpl()
    
    init(){
//        Task { await loadMore(modelContext: ModelContext) }
    }
    
    @MainActor
    func loadMore(modelContext: ModelContext) async{
        guard state == FetchState.good else { return }
        
        state = .isLoading
        
        
        
        do {
            
            let networkInfo = NetworkInfoImpl()
            let isInternetConnected: Bool = await networkInfo.checkIfInternetIsConnected()
            
            var result: Result<[PokemonEntity], APIError>
            result = try await getPokemonListUseCase.executeRemote(limit: limit, offset: offset, modelContext: modelContext)
            // We have internet, so get pokemons from remote data source and also save to local
            if isInternetConnected {
                print("DEBUG: Is internet connected ? \(networkInfo.isConnected)")
                result = try await getPokemonListUseCase.executeRemote(limit: limit, offset: offset, modelContext: modelContext)
            }
            // We don't have internet, so get from local db
            else {
                print("DEBUG: Is internet connected ?? \(networkInfo.isConnected)")
                result = getPokemonListUseCase.executeLocalData(limit: limit, offset: offset, modelContext: modelContext)
            }
            
            switch result {
            case .success(let newPokemonList):
                if networkInfo.isConnected{
                    pokemonList += newPokemonList
                    offset += newPokemonList.count
                }
                
                if newPokemonList.isEmpty {
                    self.state = .noResults
                }
                else{
                    self.state = .good
                }
            case .failure(let error):
                print("loadMore pokemon list Error occurred: \(error.localizedDescription)")
                self.state = .error(error.localizedDescription)
            }
        }
        catch{
            print("loadMore pokemon list Error occurred: \(error.localizedDescription)")
            self.state = .error(error.localizedDescription)
        }
    }

}
