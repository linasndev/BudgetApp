//
//  Budget.swift
//  BudgetApp
//
//  Created by Linas on 27/04/2025.
//

import Foundation
import SwiftData

@Model
class Budget {
  var name: String = ""
  var limit: Double = 0.0
  
  @Relationship(deleteRule: .cascade, inverse: \Expense.budget) var expenses: [Expense]?
  
  init(name: String, limit: Double, expenses: [Expense]? = nil) {
    self.name = name
    self.limit = limit
    self.expenses = expenses
  }
  
  private func isUniqueName(context: ModelContext, name: String) throws -> Bool {
    let predicate = #Predicate<Budget> { budget in
      budget.name.localizedStandardContains(name)
    }
    
    let fetchDescriptor = FetchDescriptor(predicate: predicate)
    let results: [Budget] = try context.fetch(fetchDescriptor)
    return results.isEmpty
  }
  
  func save(context: ModelContext) throws {
    if try !isUniqueName(context: context, name: name) {
      throw BudgetError.duplicateName
    } else {
      context.insert(self)
      try context.save()
    }
  }
  
  var spent: Double {
    if let expenses {
      return expenses.reduce(0) { price, expense in
        price + (expense.price * Double(expense.quantity))
      }
    } else {
      return 0.0
    }
  }
  
  var remaining: Double {
    limit - spent
  }
  
}
