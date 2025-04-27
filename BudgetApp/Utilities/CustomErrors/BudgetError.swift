//
//  BudgetError.swift
//  BudgetApp
//
//  Created by Linas on 27/04/2025.
//

import Foundation

enum BudgetError: Error {
  case duplicateName
  
  
  var title: String {
    switch self {
    case .duplicateName:
      "The budget name must be unique"
    }
  }
}
