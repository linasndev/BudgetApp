//
//  BudgetAppApp.swift
//  BudgetApp
//
//  Created by Linas on 27/04/2025.
//

import SwiftUI
import SwiftData

@main
struct BudgetAppApp: App {
  
  init() {
    print(URL.applicationSupportDirectory.path(percentEncoded: false))
  }
  
  var body: some Scene {
    WindowGroup {
      BudgetListView()
        .modelContainer(for: Budget.self)
    }
  }
}
