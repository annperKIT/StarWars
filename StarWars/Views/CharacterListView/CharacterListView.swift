//
//  CharacterListView.swift
//  StarWars
//
//  Created by Annie Persson on 01/10/2019.
//  Copyright © 2019 Annie Persson. All rights reserved.
//

import SwiftUI

// MARK: - SortOrder

enum SortOrder {
  case firstname
  case lastname
}

// MARK: - CharacterListView

struct CharacterListView: View {
  var characters: Characters
  
  @EnvironmentObject var sharedData: SharedData
  @State var showFavorites: Bool = false
  @State var isSearching: Bool = false
  @State var sortedBy: SortOrder?
  @State var searchText = ""
  
  @State var showActionSheet: Bool = false
  
  var body: some View {
    VStack {
      
      // Search bar
      if isSearching {
        SearchBar(
          placeholder: NSLocalizedString("search_character_placeholder", comment: ""),
          searchText: $searchText)
      }
      
        // Table
        List(filteredList) { char in
            // Row
          NavigationLink(destination: CharacterDetailRootView(viewModel: CharacterDetailViewModel(char))) {
            CharRow(char: char, favs: self.$sharedData.favorited)
          }
        }

    }
      
      // Filter and sort action sheet
    .actionSheet(isPresented: $showActionSheet, content: {
      ActionSheet(title: Text("Apply filter"), message: nil, buttons: [
        .default(Text("Filter favorites"), action: {
          self.showFavorites.toggle()
        }),
        .default(Text("Sort by lastname"), action: {
          self.sortedBy = .lastname
        }),
        .default(Text("Sort by firstname"), action: {
          self.sortedBy = .firstname
        }),
        .cancel()
      ])
    })
      
      // Nagivation bar
    .navigationBarTitle("Characters")
    .navigationBarItems(
      leading: Button(
        action: { self.showActionSheet.toggle() },
        label: { Text("Sort and filter") }),
      trailing: ToggleButton(
        isOn: $isSearching,
        whileOnLabel: NSLocalizedString("search_hide", comment: ""),
        whileOffLabel: NSLocalizedString("search_show", comment: "")))
    
  }
  
  /// List of characters filtered after active search and applied filter
  private var filteredList: [Character] {
    let list = characters.results
    
    func searchFilter(_ char: Character) -> Bool {
      ((!isSearching || searchText.isEmpty)
      || char.name.contains(searchText))
    }
    
    func favoritesFilter(_ char: Character) -> Bool {
      !showFavorites || sharedData.favorited.contains(char.id)
    }
    
    let filteredList = list.filter({
     searchFilter($0) && favoritesFilter($0)
    })
    
    guard let appliedSort = sortedBy else {
      return filteredList
    }
    
    func applySort(first: Character, second: Character) -> Bool {
      switch appliedSort {
      case .firstname:
        return first.firstname < second.firstname
      case .lastname:
        return first.lastname < second.lastname
      }
    }
    
    return filteredList.sorted(by: {
     applySort(first: $0, second: $1)
    })
   }
}

// MARK: - CharRow

struct CharRow: View {
  var char: Character
  @Binding var favs: Set<UUID>
  
  private var isFavorited: Bool {
    return favs.contains(char.id)
  }
  
  var body: some View {
    HStack {
      Group {
        Image(systemName: "star.fill")
          .foregroundColor(isFavorited ? .yellow : .gray)
          .padding()
      }
      .onTapGesture {
        if self.isFavorited {
          self.favs.remove(self.char.id)
        } else {
          self.favs.insert(self.char.id)
        }
      }
      
      Text(char.name)
    }
  }
}
