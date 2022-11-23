//
//  Email.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 26/10/22.
//

import Foundation

public struct Email {
    let value: String
    public var isValid: Bool {
        get {
            if self.value.isEmpty {
                return false
            }
            return validate(email: self.value)
        }
    }
    public var isInvalid: Bool {
        return !self.isValid
    }
    
    public init(email: String = "") {
        self.value = email
    }
}
extension Email {
    func validate(email: String) -> Bool {
        let trimmedText = email.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else {
            return false
        }
        let range = NSMakeRange(0, NSString(string: trimmedText).length)
        let allMatches = dataDetector.matches(in: trimmedText, options: [], range: range)
        if allMatches.count == 1, allMatches.first?.url?.absoluteString.contains("mailto:") == true {
            return true
        }
        return false
    }
}
