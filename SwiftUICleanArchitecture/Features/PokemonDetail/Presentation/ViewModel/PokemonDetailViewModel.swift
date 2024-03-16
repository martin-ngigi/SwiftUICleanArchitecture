//
//  PokemonDetailViewModel.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 16/03/2024.
//

import Foundation

class PokemonDetailViewModel: ObservableObject{
    
    @Published var pokemonDetail: PokemonDetailEntity?
    @Published var state: FetchState = .good
    
    init( pokemonDetail: PokemonDetailEntity? = nil) {
        self.pokemonDetail = pokemonDetail
    }
    
    @MainActor
    func loadDetail(id: Int) async{
        
        guard state == .good else { return }
        state = .isLoading
        
        do {
            let getPokemonDetailUsecase = GetpokemonDetailUseCase(repository: DetailRepository.shared)
            self.pokemonDetail = try await getPokemonDetailUsecase.execute(id: id)
            
            if(getPokemonDetailUsecase != nil){
                state = .good
            }
            else {
                state = .error("error loading")
            }
        }
        catch{
            state = .error(error.localizedDescription)
            print("Error: \(error.localizedDescription)")
        }
    }
    
}
