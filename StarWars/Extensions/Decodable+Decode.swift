//
//  Decodable+Decode.swift
//  StarWars
//
//  Created by Annie Persson on 01/10/2019.
//  Copyright © 2019 Annie Persson. All rights reserved.
//

import Foundation

extension Decodable {
  
  static func decode(_ data: Data) -> Self? {
    let decoder = JSONDecoder()
    
    do {
      let decodedObject = try decoder.decode(Self.self, from: data)
      return decodedObject
    } catch {
      return nil
    }
  }
}
