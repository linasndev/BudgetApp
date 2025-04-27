//
//  AddExpenseView.swift
//  BudgetApp
//
//  Created by Linas on 27/04/2025.
//

import SwiftUI
import SwiftData


struct AddExpenseView: View {
  
  @Environment(\.modelContext) private var modelContext
  @Environment(\.dismiss) private var dismiss
  
  @State private var name: String = ""
  @State private var price: Double?
  @State private var quantity: Int = 1
  
  let budget: Budget
  
  
  var body: some View {
    NavigationStack {
      Form {
        Section("Add Expense") {
          TextField("Expense name", text: $name)
          TextField("Expense price", value: $price, format: .number)
          TextField("Expense quantity", value: $quantity, format: .number)
          
          Button(action: {
            if isValid {
              saveExpense()
              dismiss()
            }
          }, label: {
            Text("Save Expense")
              .frame(maxWidth: .infinity)
          })
          .buttonStyle(.borderedProminent)
          .listRowSeparator(.hidden)
        }
      }
      .toolbar(content: {
        ToolbarItem(placement: .topBarLeading) {
          Button("Dismiss") {
            dismiss()
          }
        }
      })
      .navigationTitle("Add Expense")
    }
  }
  
  private var isValid: Bool {
    guard let price = price else { return false }
    return !name.isEmptyOrWhitespace && price > 0 && quantity > 0
  }
  
  private func saveExpense() {
    guard let price else { return }
  
    do {
      let newExpense = Expense(name: name, price: price, quantity: quantity)
      budget.expenses?.append(newExpense)
      try modelContext.save()
    } catch {
      print("❌ Can't save Expenses")
    }
  }
}

#Preview {
  let container = Budget.previewContainer
  let fetchDescriptor = FetchDescriptor<Budget>()
  let budget = try! container.mainContext.fetch(fetchDescriptor)[0]
  return NavigationStack {
    AddExpenseView(budget: budget)
  }
}
