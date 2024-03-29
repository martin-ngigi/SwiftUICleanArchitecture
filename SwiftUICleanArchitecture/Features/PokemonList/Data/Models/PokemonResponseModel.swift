//
//  Pokemon.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 15/03/2024.
//

import Foundation
import SwiftData

// This is the DTO (Data Transfer Object passed from API JSON
class PokemonResponseModel : Decodable, Encodable {
    let id: Int? // Not in API response
    let name: String
    let url: String
    let image: Data?
    
    init?(pokemonObject: PokemonSwiftDTO) {
        guard let urlComponents = URLComponents(string: pokemonObject.url),
              let idString = urlComponents.path.split(separator: "/").last,
              let id = Int(idString) else {
                  return nil
              }
        self.id = id
        self.name = pokemonObject.name
        self.url = Constants.APIEndpoint.getPokemonImage(id: id).url?.absoluteString ?? ""
        self.image = pokemonObject.image
    }
}

// This will be saved in Swift Data
@Model
class PokemonSwiftDTO{
    @Attribute(.unique)
//    var id: String = NSUUID().description
    var id: Int {
            guard let urlComponents = URLComponents(string: url),
                  let idString = urlComponents.path.split(separator: "/").last,
                  let id = Int(idString)
                    else {
//                          return nil
                          return 0
                      }
            return id
        }
    var name: String
    var url: String
    
    @Attribute(.externalStorage)
    var image: Data?
    
    init(name: String, url: String, image: Data) {
        self.name = name
        self.url = url
        self.image = image
    }
    
    convenience init(item: PokemonResponseModel) {
            self.init(
                name: item.name,
                url: item.url,
                image: item.image ?? Data()
            )
        }
}

extension PokemonSwiftDTO{
    static let MOCK_POKEMON = PokemonSwiftDTO(name: "TEST", url: "example.com", image: Data() )
}
