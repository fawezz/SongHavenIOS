//
//  ColorExtension.swift
//  songHaven-IOS
//
//  Created by zewaff on 21/11/2022.
//

import SwiftUI

extension Color {
    
    static let primary_color = Color(hex: "1B1734")
    static let main_color = Color.purple//Color(hex: "5C038C")
    static let main_color_soft = Color(hex: "896FBC")
    static let main_color_hard = Color(hex: "420264")
    
    
    init(hex: String, alpha: Double = 1) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) { cString.remove(at: cString.startIndex) }
        
        let scanner = Scanner(string: cString)
        scanner.currentIndex = scanner.string.startIndex
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        self.init(.sRGB, red: Double(r) / 0xff, green: Double(g) / 0xff, blue:  Double(b) / 0xff, opacity: alpha)
    }
}
