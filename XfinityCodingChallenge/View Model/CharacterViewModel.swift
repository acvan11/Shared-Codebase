//
//  ViewModel.swift
//  XfinityCodingChallenge
//
//  Created by Franklin Mott on 11/19/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation

protocol CharacterViewModelDelegate: class {
    func updateView()
}

protocol CharacterViewModelProtocol: class {
    
    var characters: [CharacterModel] { get }
    var viewModelDelegate: CharacterViewModelDelegate? { get set }
    
    func get()
    func filter(_ query: String)
}

class CharacterViewModel: CharacterViewModelProtocol {
    
    weak var viewModelDelegate: CharacterViewModelDelegate?
    
    // all characters, ever.
    private var allCharacters = [CharacterModel]()
    
    // represent the characters shown
    var characters = [CharacterModel]() {
        didSet {
            viewModelDelegate?.updateView()
        }
    }
    
    func get() {
        APIService.shared.getCharacters { [weak self] chars in
            guard let self = self else { return }
            self.allCharacters = chars
            self.characters = chars
        }
    }
    
    func filter(_ query: String) {
        if query.isEmpty {
            characters = allCharacters
            return
        }
        let searchText = query.lowercased()
        characters = allCharacters.filter { (character: CharacterModel) -> Bool in
               return character.name.lowercased().contains(searchText)
        }
    }
}
