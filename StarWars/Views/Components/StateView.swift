//
//  StateView.swift
//  StarWars
//
//  Created by Annie Persson on 02/10/2019.
//  Copyright © 2019 Annie Persson. All rights reserved.
//

import SwiftUI

struct StateView<R, V: View>: View {
  typealias Closure = (_: R) -> V
  @Binding var state: LoadableState<R>
  var content: Closure
  
  var body: AnyView {
    switch state {
    case .loading:
      return AnyView(
        ActivityIndicator(style: .large)
      )
    case .completed(let result):
      switch result {
        
      case .success(let data) :
        return AnyView(
          content(data)
        )
        
      case .failure(let error):
        return AnyView(
          Text(error.localizedDescription)
        )
      }
    }
  }
}
