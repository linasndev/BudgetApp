//
//  Expense.swift
//  BudgetApp
//
//  Created by Linas on 27/04/2025.
//

import Foundation
import SwiftData

@Model
class Expense {
  var name: String = ""
  var price: Double = 0.0
  var quantity: Int = 1
  var budget: Budget?
  
  init(name: String, price: Double, quantity: Int) {
    self.name = name
    self.price = price
    self.quantity = quantity
  }

  var total: Double {
    price * Double(quantity)
  }
}
