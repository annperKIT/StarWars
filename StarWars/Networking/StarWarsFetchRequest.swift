//
//  StarWarsFetchRequest.swift
//  StarWars
//
//  Created by Annie Persson on 01/10/2019.
//  Copyright © 2019 Annie Persson. All rights reserved.
//

import Foundation

class StarWarsFetchRequest: FetchRequest {
  
  typealias CharacterCompleted = (Characters?) -> Void
  typealias SingleCharacterCompleted = (Character?) -> Void
  typealias FilmCompleted = (Film?) -> Void
  typealias SpeciesCompelted = (Species?) -> Void
  typealias DetailedCompleted = (Result<CharacterDetailed, FetchError>) -> Void
  
  // MARK: - Public methods
  
  /// Sends a request to the StarWars /people API. If successfull also decodeds the json response
  /// - parameter onCompleted: Closure with decoded Characters or nil
  func fetchCharacters(then onCompleted: @escaping CharacterCompleted) {
    
    let url = StarWarsEndpoint(path: "people").url
    
    fetchFrom(url) { (result) in
      
      switch result {
        
      case .success(let data):
        
        let characters = Characters.decode(data)
        return onCompleted(characters)
        
      case .failure(let error):
        assertionFailure(error.localizedDescription)
        return onCompleted(nil)
      }
      
    }
    
  }
  
  func fetchCharacterDetails(for char: Character, onComplete: @escaping DetailedCompleted) {
    
    var films: [Film] = []
    var species: Species?
    
    // Create a dispatch group to hold multiple requests
    let group = DispatchGroup()
    
    // Enter a new work item for each film url
    char.filmUrls.forEach { [weak self] (filmUrl) in
      guard let self = self else { return }
      group.enter()
    
      self.fetchFilm(fromUrls: filmUrl) { (film) in
        if let film = film {
          films.append(film)
        }
        group.leave()
      }
    }
    
    // Enter work item for fetching species
    group.enter()
    let speciesUrl = char.speciesUrl
    self.fetchSpecies(fromUrl: speciesUrl) { (this) in
      species = this
      group.leave()
    }
    
    group.notify(queue: .main) {
      let detailed = CharacterDetailed(baseInfo: char, films: films, species: species)
      return onComplete(.success(detailed))
    }
  }
  
  // MARK: - Private methods
  
  private func fetchSingleCharacter(fromUrl url: String, onComplete: @escaping (Character?) -> Void) {
    fetchAndDecode(fromUrl: url, onComplete: onComplete)
  }
  
  private func fetchFilm(fromUrls url: String, onComplete: @escaping FilmCompleted) {
    fetchAndDecode(fromUrl: url, onComplete: onComplete)
  }
  
  private func fetchSpecies(fromUrl url: String?, onComplete: @escaping SpeciesCompelted) {
    fetchAndDecode(fromUrl: url, onComplete: onComplete)
  }
  
  private func fetchAndDecode<T: Decodable>(fromUrl url: String?, onComplete: @escaping (T?) -> Void) {
    
    let url = URL(string: url ?? "")
    
    fetchFrom(url) { (result) in
      switch result {
      case .success(let data):
        let decodedObject = T.decode(data)
        onComplete(decodedObject)
      case .failure(let error):
        assertionFailure(error.localizedDescription)
        onComplete(nil)
      }
    }
    
  }
  
}
