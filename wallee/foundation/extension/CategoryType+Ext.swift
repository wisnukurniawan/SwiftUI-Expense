//
//  CategoryType+Ext.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 07/08/22.
//

import Foundation

extension CategoryType {
    func getEmojiAndText() -> (String, String) {
        switch self {
        case .monthlyFee:
            return (getEmoji("shopping_cart"), "category_monthly_fee")
        case .adminFee:
            return (getEmoji("money_with_wings"), "category_admin_fee")
        case .pets:
            return (getEmoji("cat2"), "category_pets")
        case .donation:
            return (getEmoji("palms_up_together"), "category_donations")
        case .education:
            return (getEmoji("books"), "category_education")
        case .financial:
            return (getEmoji("bank"), "category_financial")
        case .entertainment:
            return (getEmoji("popcorn"), "category_entertainment")
        case .childrenNeeds:
            return (getEmoji("baby"), "category_children_needs")
        case .householdNeeds:
            return (getEmoji("house"), "category_household_needs")
        case .sport:
            return (getEmoji("muscle"), "category_sport")
        case .others:
            return (getEmoji("thinking"), "category_others")
        case .food:
            return (getEmoji("stew"), "category_food")
        case .parking:
            return (getEmoji("parking"), "category_parking")
        case .fuel:
            return (getEmoji("fuelpump"), "category_fuel")
        case .movie:
            return (getEmoji("movie_camera"), "category_movie")
        case .automotive:
            return (getEmoji("blue_car"), "category_automotive")
        case .tax:
            return (getEmoji("receipt"), "category_tax")
        case .income:
            return (getEmoji("moneybag"), "category_income")
        case .businessExpense:
            return (getEmoji("briefcase"), "category_business_expenses")
        case .selfCare:
            return (getEmoji("lotion_bottle"), "category_self_care")
        case .loan:
            return (getEmoji("credit_card"), "category_loan")
        case .service:
            return (getEmoji("hammer_and_wrench"), "category_service")
        case .shopping:
            return (getEmoji("shopping"), "category_shopping")
        case .bills:
            return (getEmoji("bulb"), "category_bills")
        case .taxi:
            return (getEmoji("oncoming_taxi"), "category_tax")
        case .cashWithdrawal:
            return (getEmoji("dollar"), "category_cash_withdrawal")
        case .phone:
            return (getEmoji("iphone"), "category_phone")
        case .topUp:
            return (getEmoji("inbox_tray"), "category_top_up")
        case .publicTransportation:
            return (getEmoji("bus"), "category_public_transportation")
        case .travel:
            return (getEmoji("airplane"), "category_travel")
        case .uncategorized:
            return (getEmoji("question"), "category_uncategorized")
        }
    }

    private func getEmoji(_ key: String) -> String {
        return EmojiData.data[key] ?? ""
    }
}
