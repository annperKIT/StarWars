//
//  CharacterDetailed.swift
//  StarWars
//
//  Created by Annie Persson on 01/10/2019.
//  Copyright © 2019 Annie Persson. All rights reserved.
//

import Foundation

// MARK: - CharacterDetailed

struct CharacterDetailed {
  let baseInfo: Character
  let films: [Film]
  let species: Species?
}

// MARK: - Film

struct Film: Codable, Identifiable {
  var id = UUID()
  let title: String
  let episode: Int
  
  var fullTitle: String {
    return "Episode \(episode): \(title)"
  }
  
  enum CodingKeys: String, CodingKey {
    case title
    case episode = "episode_id"
  }
}

// MARK: - Species

struct Species: Codable {
  let name: String
  let language: String
  let designation: String
}
