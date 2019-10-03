//
//  CharacterDetailViewModel.swift
//  StarWars
//
//  Created by Annie Persson on 02/10/2019.
//  Copyright © 2019 Annie Persson. All rights reserved.
//

import Combine

// MARK: - LoadableState

enum LoadableState<T> {
  case loading
  case completed(Result<T, FetchError>)
}

// MARK: - CharacterDetailViewModel

class CharacterDetailViewModel: ObservableObject {
  
  @Published var state: LoadableState<CharacterDetailed> = .loading
  @Published var character: Character
  
  private let requestMaker = StarWarsFetchRequest()
  
  init(_ character: Character) {
    self.character = character
  }
  
  func fetchDetails() {
    state = .loading
    requestMaker.fetchCharacterDetails(for: character) { (result) in
      switch result {
      case .success(let details):
        self.state = .completed(.success(details))
      case .failure(let error):
        self.state = .completed(.failure(error))
      }
    }
  }
  
}
