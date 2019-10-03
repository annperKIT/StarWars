//
//  CharacterDetailView.swift
//  StarWars
//
//  Created by Annie Persson on 02/10/2019.
//  Copyright © 2019 Annie Persson. All rights reserved.
//

import SwiftUI

struct CharacterDetailView: View {
  var details: CharacterDetailed

  var body: some View {
    VStack(alignment: .leading, spacing: 20) {

      // Base section
      DetailSection(fields: [
        Field(title: NSLocalizedString("detail_title_name", comment: ""), value: details.baseInfo.name),
        Field(title: NSLocalizedString("detail_title_gender", comment: ""), value: details.baseInfo.gender)
      ])
      
      // Only include the species section if it's not nil
      details.species.map {
        DetailSection(fields: [
          Field(title: NSLocalizedString("detail_title_species", comment: ""), value: $0.name),
          Field(title: NSLocalizedString("detail_title_designation", comment: ""), value: $0.designation),
          Field(title: NSLocalizedString("detail_title_lang", comment: ""), value: $0.language)

          ])
      }
      
      // Film section
      VStack(alignment: .leading) {
        RowView {
          Text(NSLocalizedString("detail_title_films", comment: "")).bold()
        }
        ForEach(details.films) { film in
          Text(film.fullTitle)
            .padding(.leading, 40)
        }

      }
      
      Spacer()

    }

  }
  
}

// MARK: - DetailSection

struct DetailSection: View {
  var fields: [Field]
  
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      ForEach(fields) { field in
        FieldView(field: field)
      }
    }
  }
}
