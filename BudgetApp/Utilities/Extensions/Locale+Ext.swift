//
//  Locale+Ext.swift
//  BudgetApp
//
//  Created by Linas on 27/04/2025.
//

import Foundation

extension Locale {
  static var currencyCode: String {
    Locale.current.currency?.identifier ?? "USD"
  }
}
