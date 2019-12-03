//
//  APIService.swift
//  XfinityCodingChallenge
//
//  Created by Franklin Mott on 11/19/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation


typealias CharacterHandler = ([CharacterModel]) -> Void

final class APIService {
    
    static let shared = APIService()
    private init() {}
    
    func getCharacters(_ completion: @escaping CharacterHandler) {
        guard let url = URL(string: ServerConstants.SERVER_URL) else {
            completion([])
            return
        }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { (dat, _, err) in
            if let error = err {
                print("Bad Task: \(error.localizedDescription)")
                completion([])
                return
            }
            guard let data = dat else {
                completion([])
                print("No data returned")
                return
            }
            do {
                let characterResponse = try JSONDecoder().decode(CharacterResponse.self, from: data)
                let characters = characterResponse.characters
                completion(characters)
            } catch let myError {
                print("Couldn't Decode Character: \(myError.localizedDescription)")
                completion([])
                return
            }
        }.resume()
    }
}




