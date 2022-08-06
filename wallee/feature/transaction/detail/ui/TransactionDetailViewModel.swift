//
//  TransactionDetailViewModel.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 06/08/22.
//

import Foundation

@MainActor class TransactionDetailViewModel: ObservableObject {
    @Published var state: TransactionDetailState = .init()

    init() {
        initLoad()
    }

     func initLoad() {
        let currentDate = Date()
        state.transactionTypeItems = initialTransactionTypes(selectedType: .expense)
        state.categoryItems = initialCategoryTypes(selectedCategoryType: .others)
        state.note = ""
        state.totalAmount = "0"
        state.transactionDate = currentDate
        state.transactionCreatedAt = currentDate
        state.transactionUpdatedAt = nil
        state.currency = .defaultValue
        
        Loggr.debug {
            "Wisnukrn1"
        }
    }

    private func initialTransactionTypes(selectedType: TransactionType = .expense) -> [TransactionTypeItem] {
        return [
            TransactionTypeItem(title: "transaction_expense", selected: false, transactionType: .expense),
            TransactionTypeItem(title: "transaction_income", selected: false, transactionType: .income),
            TransactionTypeItem(title: "transaction_transfer", selected: false, transactionType: .transfer),
        ].map { transactionTypeItem in
            var modify = transactionTypeItem
            modify.selected = transactionTypeItem.transactionType == selectedType
            return modify
        }
    }

    private func initialCategoryTypes(selectedCategoryType: CategoryType = .others) -> [CategoryItem] {
        return [
            CategoryType.monthlyFee,
            CategoryType.adminFee,
            CategoryType.pets,
            CategoryType.donation,
            CategoryType.education,
            CategoryType.financial,
            CategoryType.entertainment,
            CategoryType.childrenNeeds,
            CategoryType.householdNeeds,
            CategoryType.sport,
            CategoryType.others,
            CategoryType.food,
            CategoryType.parking,
            CategoryType.fuel,
            CategoryType.movie,
            CategoryType.automotive,
            CategoryType.tax,
            CategoryType.income,
            CategoryType.businessExpense,
            CategoryType.selfCare,
            CategoryType.loan,
            CategoryType.service,
            CategoryType.shopping,
            CategoryType.bills,
            CategoryType.taxi,
            CategoryType.cashWithdrawal,
            CategoryType.phone,
            CategoryType.topUp,
            CategoryType.publicTransportation,
            CategoryType.travel,
            CategoryType.uncategorized,
        ].map { item in
            CategoryItem(
                type: item,
                selected: item == selectedCategoryType
            )
        }
    }
}
