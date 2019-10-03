//
//  Endpoint.swift
//  StarWars
//
//  Created by Annie Persson on 01/10/2019.
//  Copyright © 2019 Annie Persson. All rights reserved.
//

import Foundation

struct StarWarsEndpoint {
  var path: String
  var url: URL? {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "swapi.co"
    components.path = "/api/\(path)"
    return components.url
  }
}
