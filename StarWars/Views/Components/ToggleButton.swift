//
//  ToggleButton.swift
//  StarWars
//
//  Created by Annie Persson on 02/10/2019.
//  Copyright © 2019 Annie Persson. All rights reserved.
//

import SwiftUI

struct ToggleButton: View {
  @Binding var isOn: Bool
  let whileOnLabel: String
  let whileOffLabel: String
  
  var body: some View {
    Button(
      action: { self.isOn.toggle() },
      label: { Text(self.isOn ? self.whileOnLabel : self.whileOffLabel) }
    )
  }
}
