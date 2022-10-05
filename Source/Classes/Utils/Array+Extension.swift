//
//  Extensions.swift
//  WordPressSimplify-iOS
//
//  Created by Diego Badaracco on 21/09/2022.
//

import Foundation

extension Array where Element == Int {
    func makeQueryItemValue() -> String {
        var content = ""
        for (idx, element) in self.enumerated() {
            content = "\(content)\(element)"
            if idx != self.endIndex - 1 {
                content = "\(content),"
            }
        }
        return content
    }
}

extension Array where Element == String {
    func makeQueryItemValue() -> String {
        var content = ""
        for (idx, element) in self.enumerated() {
            content = "\(content)\(element)"
            if idx != self.endIndex - 1 {
                content = "\(content),"
            }
        }
        return content
    }
}
