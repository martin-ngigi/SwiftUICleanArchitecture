//
//  NetworkUtils.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 15/03/2024.
//

import Foundation

class NetworkUtils{
    static let shared = NetworkUtils()
    
    func fetch<T: Decodable>(type: T.Type, from url: URL) async -> Result<T, APIError> {
        do {
            var request = URLRequest(url: url)
            request.timeoutInterval = Constants.pokeApiTimeoutInterval
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                return .failure(APIError.badResponse((response as? HTTPURLResponse)?.statusCode ?? 0))
            }
            
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            
            return .success(decodedData)
        } catch let error as URLError {
            return .failure(APIError.urlSession(error))
        } catch let decodingError as DecodingError {
            return .failure(APIError.decoding(decodingError))
        } catch {
            return .failure(APIError.unknown)
        }
    }
        
    func fetch2<T: Codable>(from url: URL) async throws -> T{
        var request = URLRequest(url: url)
        request.timeoutInterval = Constants.pokeApiTimeoutInterval
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        
        return decodedData
    }
}
