//
//  MediumCloneApp.swift
//  MediumClone
//
//  Created by jmlb23 on 11/12/20.
//

import SwiftUI

@main
struct MediumCloneApp: App {
  var body: some Scene {
    WindowGroup {
      Home()
        .environmentObject(store)
    }
  }
}
