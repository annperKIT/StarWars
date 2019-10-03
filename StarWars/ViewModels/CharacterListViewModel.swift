//
//  CharacterListViewModel.swift
//  StarWars
//
//  Created by Annie Persson on 02/10/2019.
//  Copyright © 2019 Annie Persson. All rights reserved.
//

import Foundation
import Combine

class CharacterListViewModel: ObservableObject {
  @Published var state: LoadableState<Characters> = .loading
  
  private let requestMaker = StarWarsFetchRequest()
  
  func fetch() {
    state = .loading
    
    requestMaker.fetchCharacters { (characters) in
      DispatchQueue.main.async {
        
        if let chars = characters {
          self.state = .completed(.success(chars))
          return
        }
          
        self.state = .completed(.failure(.missingData))
      }
    }
  }

}
