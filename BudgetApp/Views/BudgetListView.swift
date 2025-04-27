//
//  ContentView.swift
//  BudgetApp
//
//  Created by Linas on 27/04/2025.
//

import SwiftUI
import SwiftData

struct BudgetListView: View {
  
  @Query private var budgets: [Budget]
  
  @State private var isPresentedAddBudgetView: Bool = false
  
  var body: some View {
    NavigationStack {
      List(budgets) { budget in
        NavigationLink(value: budget, label: {
          BudgetCellView(budget: budget)
        })
      }
      .listStyle(.plain)
      .navigationTitle("Budgets")
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button("Add Budget") {
            isPresentedAddBudgetView = true
          }.accessibilityIdentifier("addBudgetButton")
        }
      }
      .popover(isPresented: $isPresentedAddBudgetView) {
        AddBudgetView()
          .presentationCompactAdaptation(.sheet)
      }
      .navigationDestination(for: Budget.self) { budget in
        BudgetDetailView(budget: budget)
      }
    }
  }
}


struct BudgetCellView: View {
  
  let budget: Budget
  
  var body: some View {
    HStack {
      Text(budget.name)
      Spacer()
      Text(budget.limit, format: .currency(code: Locale.currencyCode))
    }
  }
}

#Preview {
  BudgetListView()
    .modelContainer(Budget.previewContainer)
}
