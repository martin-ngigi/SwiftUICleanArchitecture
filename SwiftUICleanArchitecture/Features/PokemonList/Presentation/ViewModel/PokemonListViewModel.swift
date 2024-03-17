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
    
    @Published var hasError: Bool = false
    @Published var error: LocalizedError?
    
    init(){
//        Task { await loadMore(modelContext: ModelContext) }
    }
    
    @MainActor
    func loadMore(modelContext: ModelContext) async{
        guard state == FetchState.good else { return }
        
        state = .isLoading
        
        do {
            let result = try await getPokemonListUseCase.execute(limit: limit, offset: offset, modelContext: modelContext)
            
            switch result {
            case .success(let newPokemonList):
                pokemonList += newPokemonList
                offset += newPokemonList.count
                
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
    
    @MainActor
    func loadMore2() async {
        
        guard state == FetchState.good else { return }
        
        state = .isLoading
        
        do{
            let newPokemonList = try await getPokemonListUseCase.execute2(limit: limit, offset: offset)
            pokemonList += newPokemonList
            offset += newPokemonList.count
            
            if newPokemonList.count == 0{
                self.state = .noResults
            }
            else {
                self.state = .good
            }
        }
        catch{
            print("loadMore pokemon list Error occurred: \(error.localizedDescription)")
            self.state = .error(error.localizedDescription)
        }
    }

}
