//
//  SearchBar.swift
//  StarWars
//
//  Created by Annie Persson on 02/10/2019.
//  Copyright © 2019 Annie Persson. All rights reserved.
//

import SwiftUI

struct SearchBar: View {
  var placeholder: String
  @Binding var searchText: String

  var body: some View {
    HStack {

      Image(systemName: "magnifyingglass")
        .foregroundColor(.secondary)

      TextField(
        placeholder,
        text: $searchText
      )

      Button(
        action: { self.searchText = "" },
        label: {
         Image(systemName: "xmark.circle.fill")
          .foregroundColor(.secondary)
        }
      )

    }.padding([.leading, .trailing])
  }
}
