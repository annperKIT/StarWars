//
//  DetailView.swift
//  StarWars
//
//  Created by Annie Persson on 02/10/2019.
//  Copyright © 2019 Annie Persson. All rights reserved.
//

import SwiftUI

// MARK: - CharacterDetailView

struct CharacterDetailRootView: View {
  @ObservedObject var viewModel: CharacterDetailViewModel
    
  var body: some View {
    StateView<CharacterDetailed, CharacterDetailView>(state: $viewModel.state, content: { (data) in
      CharacterDetailView(details: data)
    })
      .navigationBarTitle(viewModel.character.name)
      .onAppear(perform: viewModel.fetchDetails)
      
  }

}
