//
//  AddBudgetView.swift
//  BudgetApp
//
//  Created by Linas on 27/04/2025.
//

import SwiftUI
import SwiftData

struct AddBudgetView: View {
  
  @Environment(\.modelContext) private var modelContext
  @Environment(\.dismiss) private var dismiss
  
  @State private var name: String = ""
  @State private var limit: Double?
  @State private var errorMessage: String = ""
  
  var body: some View {
    NavigationStack {
      Form {
        TextField("Name", text: $name)
        
        TextField("Limit", value: $limit, format: .number)
        
        Text(errorMessage)
      }
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button("Save") {
            saveBudget()
          }
          .disabled(!isFormValid)
        }
        
        ToolbarItem(placement: .topBarLeading) {
          Button("Cancel") {
            dismiss()
          }
        }
      }
    }
  }
  
  private var isFormValid: Bool {
    guard let limit else { return false }
    
    return !name.isEmptyOrWhitespace && limit > 0
  }  
  
  private func saveBudget() {
    
    guard let limit else { return }
    
    do {
      let newBudget = Budget(name: name, limit: limit)
      try newBudget.save(context: modelContext)
      dismiss()
    } catch {
      errorMessage = BudgetError.duplicateName.title
    }
  }
}

#Preview {
  AddBudgetView()
}
