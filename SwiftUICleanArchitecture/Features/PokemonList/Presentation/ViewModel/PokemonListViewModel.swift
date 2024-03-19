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
//            let isInternetConnected: Bool = networkInfo.isConnected
//            let isInternetConnected: Bool = true
            
            var result: Result<[PokemonEntity], APIError>

            // We have internet, so get pokemons from remote data source and also save to local
            if isInternetConnected {
                print("DEBUG: 1. Is internet connected ? \(isInternetConnected)")
                result = try await getPokemonListUseCase.executeRemote(limit: limit, offset: offset, modelContext: modelContext)
            }
            // We don't have internet, so get from local db
            else {
                print("DEBUG: 2. Is internet connected ?? \(isInternetConnected)")
                result = getPokemonListUseCase.executeLocalData(limit: limit, offset: offset, modelContext: modelContext)
            }
            
            switch result {
            case .success(let newPokemonList):
                print("DEBUG: newPokemonList Success")
                if isInternetConnected {
                    pokemonList += newPokemonList
                    offset += newPokemonList.count
                    print("I am here 1 offset: \(offset)")
                }
                else {
                    print("I am here 2 offset: \(offset)")
                    pokemonList = newPokemonList
                    offset = newPokemonList.count
                }
                
                if newPokemonList.isEmpty {
                    self.state = .noResults
                }
                else{
                    self.state = .good
                }
            case .failure(let error):
                print("DEBUG: newPokemonList Fail")
                print("DEBUG: loadMore pokemon list Error occurred: \(error.localizedDescription)")
                self.state = .error(error.localizedDescription)
            }
        }
        catch{
            print("DEBUG: loadMore pokemon list Error occurred: \(error.localizedDescription)")
            self.state = .error(error.localizedDescription)
        }
    }

}
