//
//  PasswordViewModel.swift
//  Password
//
//  Created by Rodrigo Galeano on 26/10/25.
//

import Combine

class PasswordViewModel: ObservableObject {
    @Published var allCriteriaMet: Bool = false
    @Published var nextCriterionMessage: String?
    @Published var password: String = "" { didSet { validatePassword() } }
    
    func validatePassword() {
        guard !password.isEmpty else {
            allCriteriaMet = false
            nextCriterionMessage = nil
            return
        }
        
        let lengthSatisfied = PasswordRules.length.isSatisfied(by: password)
        
        if !lengthSatisfied {
            allCriteriaMet = false
            nextCriterionMessage = PasswordRules.length.message
            return
        }
        
        if let nextCriterion = nextPendingCriterion() {
            allCriteriaMet = false
            nextCriterionMessage = nextCriterion.message
        } else {
            allCriteriaMet = true
            nextCriterionMessage = nil
        }
    }
    
    private func nextPendingCriterion() -> PasswordRules? {
        if !PasswordRules.length.isSatisfied(by: password) { return .length }
        
        for criterion in PasswordRules.allCases where criterion != .length {
            if !criterion.isSatisfied(by: password) { return criterion }
        }
        
        return nil
    }
}
