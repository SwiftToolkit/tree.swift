//
//  String+Style.swift
//  tree.swift
//
//  Created by Natan Rolnik on 16/02/2025.
//

import Foundation

extension String {
    var bold: String {
        "\u{001B}[1m" + self + "\u{001B}[0m"
    }
}
