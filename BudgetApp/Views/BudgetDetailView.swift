//
//  BudgetDetailView.swift
//  BudgetApp
//
//  Created by Linas on 27/04/2025.
//

import SwiftUI
import SwiftData

struct BudgetDetailView: View {
  
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
              VStack(alignment: .leading, spacing: 10) {
                HStack {
                  Text("Spent:")
                  Spacer()
                  Text(budget.spent, format: .currency(code: Locale.currencyCode))
                }
                Divider()
                HStack {
                  Text("Remaining:")
                  Spacer()
                  Text(budget.remaining, format: .currency(code: Locale.currencyCode))
                    .foregroundStyle(insufficientFundsColor)
                }
                
                Divider()
              }
              .frame(maxWidth: .infinity, alignment: .leading)
              
              ForEach(expenses) { expense in
                ExpenseCellView(expense: expense)
              }
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
}

#Preview {
  let container = Budget.previewContainer
  let fetchDescriptor = FetchDescriptor<Budget>()
  let budget = try! container.mainContext.fetch(fetchDescriptor)[0]
  return NavigationStack {
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

