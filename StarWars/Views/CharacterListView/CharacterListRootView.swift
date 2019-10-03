//
//  CharacterRootListView.swift
//  StarWars
//
//  Created by Annie Persson on 02/10/2019.
//  Copyright © 2019 Annie Persson. All rights reserved.
//

import SwiftUI

struct CharactetListRootView: View {
  @EnvironmentObject var sharedData: SharedData
  @ObservedObject var viewModel = CharacterListViewModel()
  
  var body: some View {
    NavigationView {
      
      StateView<Characters, CharacterListView>(state: $viewModel.state) { (chars) in
        CharacterListView(characters: chars)
      }

    }.onAppear(perform: viewModel.fetch)
  }
  
}
