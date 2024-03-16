//
//  PokemonDetailView.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 15/03/2024.
//

import SwiftUI

struct PokemonDetailView: View {
    
    var id: Int
    @State private var pokemonDetail: PokemonDetailEntity?
    
    var body: some View {
        VStack{
            if pokemonDetail == nil{
                Text("Loading...")
            }
            else {
                AsyncImage(url: URL(string: pokemonDetail?.pokemon.imageURL ?? "")) { image in
                    image.image?.resizable()
                }
                .scaledToFit()
            }
            
            Text(pokemonDetail?.pokemon.name ?? "")
            
            HStack{
                Text("Height: **\(pokemonDetail?.height ?? 0)**")
                    .font(.subheadline)
                Text("Weight: **\(pokemonDetail?.weight ?? 0)**")
                    .font(.subheadline)
            }
        }
        .task {
           await loadDetail(id: id)
        }
    }
    
    func loadDetail(id: Int) async{
        do {
            let getPokemonDetailUsecase = GetpokemonDetailUseCase(repository: DetailRepository.shared)
            self.pokemonDetail = try await getPokemonDetailUsecase.execute(id: id)
        }
        catch{
            print("Error: \(error.localizedDescription)")
        }
    }
}

#Preview {
    PokemonDetailView(id: 1)
}
