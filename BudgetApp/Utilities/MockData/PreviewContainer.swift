//
//  PreviewContainer.swift
//  BudgetApp
//
//  Created by Linas on 27/04/2025.
//

import Foundation
import SwiftData


extension Budget {
  @MainActor
  static var previewContainer: ModelContainer {
    let container = try! ModelContainer(for: Budget.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    
    let groceries = Budget(name: "Groceries", limit: 300, expenses: [
      Expense(name: "Bread", price: 4.50, quantity: 1),
      Expense(name: "Milk", price: 10.0, quantity: 2)
    ])
    container.mainContext.insert(groceries)
    
    let vacation = Budget(name: "Vacation", limit: 123)
    container.mainContext.insert(vacation)
    
    let airpods = Budget(name: "AirPods Max", limit: 600)
    container.mainContext.insert(airpods)
    
    let appleDisplay = Budget(name: "Apple Display Studio", limit: 1500)
    container.mainContext.insert(appleDisplay)
    
    return container
  }
}


