//
//  PokemonRowView.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 15/03/2024.
//

import SwiftUI

struct PokemonRowView: View {
    var pokemon: PokemonEntity
//    @ObservedObject var networkInfo = NetworkInfoImpl()
    @State var networkInfo: NetworkInfoImpl
    
    var body: some View {
        HStack{
            if networkInfo.isConnected{
                AsyncImage(url: URL(string: pokemon.imageURL)) { image in
                    image.image?.resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                }
            }
            else {
                if let imageData = pokemon.image, let image = UIImage(data: imageData){
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(.rect(cornerRadius: 5))
                        .frame(width: 80, height: 140)
                }
                
            }
            
            
            
            Text(pokemon.name)
        }
    }
}

//#Preview {
//    PokemonRowView()
//}
