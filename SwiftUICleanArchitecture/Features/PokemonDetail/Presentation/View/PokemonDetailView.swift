//
//  PokemonDetailView.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 15/03/2024.
//

import SwiftUI

struct PokemonDetailView: View {
    
    let id: Int

    @StateObject var viewModel = PokemonDetailViewModel()
    
    
    init(id: Int){
        self.id = id
    }

    var body: some View {
        VStack{
            
            VStack{
                switch viewModel.state {
                case .good:
                    VStack{
                        AsyncImage(url: URL(string: viewModel.pokemonDetail?.pokemon.imageURL ?? "")) { image in
                            image.image?.resizable()
                        }
                        .scaledToFit()
                                            
                        Text(viewModel.pokemonDetail?.pokemon.name ?? "")
                        
                        HStack{
                            Text("Height: **\(viewModel.pokemonDetail?.height ?? 0)**")
                                .font(.subheadline)
                            Text("Weight: **\(viewModel.pokemonDetail?.weight ?? 0)**")
                                .font(.subheadline)
                        }
                    }
                case .isLoading:
                    LoadingIndicatorView()
                case .noResults:
                    ContentUnavailableView("No pokemnon avialable", systemImage: "")
                case .error(let message):
                    Text("Error: \(message)")
                }
            }
        }
        .task {
            await viewModel.loadDetail(id: id)
        }
    }
    
}

#Preview {
    PokemonDetailView(id: 1)
}
