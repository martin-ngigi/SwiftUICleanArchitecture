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
    
    init?(pokemonObject: PokemonSwiftDataObject) {
        guard let urlComponents = URLComponents(string: pokemonObject.url),
              let idString = urlComponents.path.split(separator: "/").last,
              let id = Int(idString) else {
                  return nil
              }
        self.id = id
        self.name = pokemonObject.name
        self.url = Constants.APIEndpoint.getPokemonImage(id: id).url?.absoluteString ?? ""
    }
}

// This will be saved in Swift Data
@Model
class PokemonSwiftDataObject{
    @Attribute(.unique)
    var id: String = NSUUID().description
    var name: String
    var url: String
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
    
    convenience init(item: PokemonResponseModel) {
            self.init(
                name: item.name,
                url: item.url
            )
        }
}
