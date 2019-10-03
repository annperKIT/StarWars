//
//  Charcters.swift
//  StarWars
//
//  Created by Annie Persson on 01/10/2019.
//  Copyright © 2019 Annie Persson. All rights reserved.
//

import Foundation

struct Characters: Codable {
  let results: [Character]
}

struct Character: Codable, Identifiable {
  let name: String
  let gender: String
  let filmUrls: [String]
  let url: String
  var id = UUID()

  var speciesUrl: String {
    return species.first ?? ""
  }
  
  var firstname: String {
    name.components(separatedBy: " ").first ?? ""
  }
  
  var lastname: String {
    name.components(separatedBy: " ").last ?? ""
  }
  
  private let species: [String]
  
  enum CodingKeys: String, CodingKey {
    case name, gender, url, species
    case filmUrls = "films"
  }

}
