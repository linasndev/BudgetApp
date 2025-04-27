//
//  String+Ext.swift
//  BudgetApp
//
//  Created by Linas on 27/04/2025.
//

import Foundation

extension String {
  var isEmptyOrWhitespace: Bool {
    trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
  }
}

