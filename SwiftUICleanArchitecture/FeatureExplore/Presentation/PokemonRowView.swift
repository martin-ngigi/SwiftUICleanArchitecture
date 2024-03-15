//
//  PokemonRowView.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 15/03/2024.
//

import SwiftUI

struct PokemonRowView: View {
    var pokemon: PokemonEntity
    
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: pokemon.imageURL)) { image in
                image.image?.resizable()
            }
            .scaledToFit()
            .frame(width: 100, height: 100)
            
            Text(pokemon.name)
        }
    }
}

//#Preview {
//    PokemonRowView()
//}
