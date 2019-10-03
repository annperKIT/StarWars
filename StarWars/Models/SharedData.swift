//
//  SharedData.swift
//  StarWars
//
//  Created by Annie Persson on 02/10/2019.
//  Copyright © 2019 Annie Persson. All rights reserved.
//

import Foundation

class SharedData: ObservableObject {
    
  @Published var favorited: Set<UUID> = []
  
}
