//
//  CharacterModel.swift
//  XfinityCodingChallenge
//
//  Created by Franklin Mott on 11/19/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

struct CharacterResponse: Decodable {
    let characters: [CharacterModel]
    private enum CodingKeys: String, CodingKey {
        case characters = "RelatedTopics"
    }
}

class CharacterModel: Decodable {
    let name: String
    let imageURL: String
    let desc: String
    private enum CodingKeys: String, CodingKey {
        case text = "Text"
        case icon = "Icon"
        case url = "URL"
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let text = try container.decode(String.self, forKey: .text)
        let comps = text.components(separatedBy: " - ")
        if let name = comps.first {
            self.name = name
        }
        else {
            self.name = "not found"
        }
        if comps.count > 1, let desc = comps.last {
            self.desc = desc
        }
        else {
            self.desc = "not found"
        }
        let iconCont = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .icon)
        imageURL = try iconCont.decode(String.self, forKey: .url)
    }
}

