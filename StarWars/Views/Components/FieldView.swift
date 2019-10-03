//
//  FiledView.swift
//  StarWars
//
//  Created by Annie Persson on 02/10/2019.
//  Copyright © 2019 Annie Persson. All rights reserved.
//

import SwiftUI

// MARK: - FieldView

struct FieldView: View {
  var field: Field
  
  var body: some View {
    
    RowView {
      Text("\(self.field.title):").bold()
      Text(self.field.value)
      Spacer()
    }
  }
}

// MARK: - Field

struct Field: Identifiable {
  var id = UUID()
  let title: String
  let value: String
}

// MARK: - RowView

struct RowView<T>: View where T: View {
  typealias Closure = () -> T
  let content: Closure
  
  init(@ViewBuilder content: @escaping Closure) {
    self.content = content
  }
  
  var body: some View {
    HStack(alignment: .center, spacing: 10) {
      content()
    }.padding(.leading, 20)
  }
}
