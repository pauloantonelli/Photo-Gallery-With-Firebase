//
//  StringExtension.swift
//  Photo Gallery App SwiftUI
//
//  Created by Paulo Antonelli on 20/12/22.
//

import Foundation

extension String {
    func extractImageNameFromString() -> String {
        if let lastIndex = self.lastIndex(of: ".") {
            let subString = self[...self.index(before: lastIndex)]
            return String(subString)
        }
        return self
    }
    
    func extractImageFormatFromString() -> String? {
        if let lastIndex = self.lastIndex(of: ".") {
            let subString = self[self.index(after: lastIndex)...]
            return String(subString)
        }
        return nil
    }
}
