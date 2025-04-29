//
//  BudgetDetailView.swift
//  BudgetApp
//
//  Created by Linas on 27/04/2025.
//

import SwiftUI
import SwiftData

struct BudgetDetailView: View {
  
  @Environment(\.modelContext) private var modelContext
  
  @Bindable var budget: Budget
  
  @State private var isPresentedAddExpenseView: Bool = false
  
  var body: some View {
    
    VStack {
      Text(budget.limit, format: .currency(code: Locale.currencyCode))
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .font(.headline)
      
      
      Form {
        Section("Budget") {
          TextField("Budget name", text: $budget.name)
          TextField("Budget limit", value: $budget.limit, format: .currency(code: Locale.currencyCode))
        }
        
        Section("Expenses") {
          if let expenses = budget.expenses {
            List {
              VStack(alignment: .center, spacing: 10) {
                
                HStack {
                  Text("Spent:")
                  Text(budget.spent, format: .currency(code: Locale.currencyCode))
                }
                
                HStack {
                  Text("Remaining:")
                  Text(budget.remaining, format: .currency(code: Locale.currencyCode))
                    .foregroundStyle(insufficientFundsColor)
                }
                
              }
              .frame(maxWidth: .infinity, alignment: .center)
              
              ForEach(expenses) { expense in
                ExpenseCellView(expense: expense)
              }
              .onDelete(perform: deleteExpense)
            }
          }
        }
      }
      .navigationTitle("Budget Name")
    }
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button("Add Expense") {
          isPresentedAddExpenseView = true
        }
      }
    }
    .popover(isPresented: $isPresentedAddExpenseView) {
      AddExpenseView(budget: budget)
        .presentationCompactAdaptation(.sheet)
    }
  }
  
  private var insufficientFundsColor: Color {
    budget.remaining < 0 ? .red : .green
  }
  
  private func deleteExpense(indexSet: IndexSet) {
    if let expenses = budget.expenses {
      indexSet.forEach { index in
        let expenseToDelete = expenses[index]
        if let expenseIndex = budget.expenses?.firstIndex(where: { $0.id == expenseToDelete.id }) {
          budget.expenses?.remove(at: expenseIndex)
        }
        modelContext.delete(expenseToDelete)
        try? modelContext.save()
      }
    }
  }
}

#Preview {
  let container = Budget.previewContainer
  let fetchDescriptor = FetchDescriptor<Budget>()
  let budget = try! container.mainContext.fetch(fetchDescriptor)[0]
  NavigationStack {
    BudgetDetailView(budget: budget)
      .modelContainer(container)
  }
}


struct ExpenseCellView: View {
  
  let expense: Expense
  
  var body: some View {
    HStack {
      Text("\(Text(expense.name)) (\(expense.quantity))")
      Spacer()
      Text(expense.total, format: .currency(code: Locale.currencyCode))
    }
  }
}

