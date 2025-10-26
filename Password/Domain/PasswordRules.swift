//
//  PasswordCriterion.swift
//  Password
//
//  Created by Rodrigo Galeano on 26/10/25.
//

import Foundation

enum PasswordRules: CaseIterable {
    case length
    case uppercase
    case number
    case symbol
    case lowercase
    case oddDigitsExactThree
    case currentDay
    case brazilLastWorldCupYear
    case hasPrimeDigit
    case eighthAlphabetLetter
    case allVowels
    case startsWithLetter
    
    var message: String {
        switch self {
        case .length:
            return "At least 6 characters"
        case .uppercase:
            return "At least one uppercase letter"
        case .number:
            return "At least one number"
        case .symbol:
            return "At least one symbol"
        case .lowercase:
            return "At least one lowercase letter"
        case .oddDigitsExactThree:
            return "Exactly 3 odd digits"
        case .currentDay:
            return "Must contain current day (dd)"
        case .brazilLastWorldCupYear:
            return "Must contain the year of Brazil's last World Cup title"
        case .hasPrimeDigit:
            return "Must contain a prime digit"
        case .eighthAlphabetLetter:
            return "Must contain the 8th letter of the alphabet"
        case .allVowels:
            return "Must contain all vowels"
        case .startsWithLetter:
            return "Must start with a letter"
        }
    }
    
    func isSatisfied(by password: String) -> Bool {
        switch self {
        case .length:
            return password.count >= 6
            
        case .uppercase:
            return password.contains { $0.isLetter && $0.isUppercase }
            
        case .number:
            return password.contains { $0.isNumber }
            
        case .symbol:
            return password.contains { !$0.isLetter && !$0.isNumber }
            
        case .lowercase:
            return password.contains { $0.isLetter && $0.isLowercase }
            
        case .oddDigitsExactThree:
            let oddDigitsCount = password.filter { char in
                guard let value = char.wholeNumberValue else { return false }
                return value % 2 != 0
            }.count
            return oddDigitsCount == 3
            
        case .currentDay:
            let formatter = DateFormatter()
            formatter.timeZone = .current
            formatter.dateFormat = "dd"
            let todayDD = formatter.string(from: Date())
            return password.contains(todayDD)
            
        case .brazilLastWorldCupYear:
            return password.contains("2002")
            
        case .hasPrimeDigit:
            let primes: Set<Character> = ["2", "3", "5", "7"]
            return password.contains { primes.contains($0) }
            
        case .eighthAlphabetLetter:
            return password.localizedCaseInsensitiveContains("h")
            
        case .allVowels:
            let lower = password.lowercased()
            for v in ["a","e","i","o","u"] {
                if !lower.contains(v) { return false }
            }
            return true
            
        case .startsWithLetter:
            return password.first?.isLetter == true
        }
    }
}
