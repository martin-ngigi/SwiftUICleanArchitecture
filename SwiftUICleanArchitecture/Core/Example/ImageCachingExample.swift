//
//  ImageCachingExample.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 20/03/2024.
//

import SwiftUI
import SwiftData

struct ImageCachingExample: View {
    
    @Environment(\.modelContext) private var context
    @ObservedObject var viewModel = ImageCahingViewModel()
    
    var body: some View {
        VStack{
            if viewModel.state == .isLoading{
                ProgressView()
            }
            else {
                Text(viewModel.pokemon?.name ?? "Empty Name")
                Text(viewModel.pokeminEntity?.image.debugDescription ?? "None" )
                
                if viewModel.pokemon != nil {
                    if let imageData = viewModel.pokeminEntity?.image, let image = UIImage(data: imageData){
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .clipShape(.rect(cornerRadius: 5))
                            .frame(width: 80, height: 140)
                    }
                }
            }
        }
        .onAppear{
            Task{
                do {
//                    try await viewModel.downloadAndCacheImage(context: context)
                    let _ = try viewModel.fetchCachedImage(context: context)
                }
                catch{
                    print("DEBUG: error \(error.localizedDescription)")
                }
            }
        }
    }

}


class ImageCahingViewModel: ObservableObject {
    @Published  var pokemon: PokemonSwiftDTO?
    @Published  var pokeminEntity: PokemonEntity?
    @Published  var imageData: Data?
    
    @Published var state: FetchState = .good
    
    @MainActor
    func downloadAndCacheImage(context: ModelContext) async throws {
        do {
            state = .isLoading
            let pokeName: String = "Test Pokemon"
            let pokeUrl : String  = "https://st.depositphotos.com/3336339/4627/i/450/depositphotos_46270609-stock-photo-unique-red-ball-leader.jpg"
            let pokeImage = try await Data(contentsOf: URL(string: pokeUrl)!)
            
            let pokemon: PokemonSwiftDTO = PokemonSwiftDTO(name: pokeName, url: pokeUrl, image: pokeImage)
            
            context.insert(pokemon)
            try context.save()
            
            state = .good
            
        }
        catch {
            state = .error(error.localizedDescription)

            print("DEBUG: downloadAndCacheImage error \(error.localizedDescription)")
            throw error
        }

    }
    
    @MainActor
    func fetchCachedImage(context: ModelContext) throws -> PokemonSwiftDTO? {
        state = .isLoading

        let fetchDescriptor = FetchDescriptor<PokemonSwiftDTO>()
        var pokemonLists: [PokemonSwiftDTO] = []
        do {
            pokemonLists = try context.fetch(fetchDescriptor)
            pokemon = pokemonLists.first!
//            return pokemonLists[0]
            
            pokeminEntity = PokemonEntity(id: pokemon?.id ?? 0, name: pokemon?.name ?? "No _ Name", imageURL: pokemon?.url ?? "No URL", image: pokemon?.image)
            
//            print("pokeminEntity \(pokeminEntity?.name)")
            imageData = pokemon?.image
            state = .good
            return pokemonLists.first
        }
        catch {
            state = .error(error.localizedDescription)
            print("DEBUG: readListOperation failed with error \(error)")
            throw error
        }
    }
    
}

//#Preview {
//    ImageCachingExample()
//}
