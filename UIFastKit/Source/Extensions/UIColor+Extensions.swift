//
//  UIColor+Extensions.swift
//  UIFastKit
//
//  Created by 林季正 on 2020/11/8.
//

import Foundation

fileprivate func colorInt(_ int: Int?) -> Int? {
    if let n = int {
        return (n >= 0 && n <= 255) ? n : nil
    } else {
        return nil
    }
}

fileprivate func alphaFloat(_ float: CGFloat) -> CGFloat? {
    return (float >= 0 && float <= 1) ? float : nil
}

public extension UIColor {
    static func string(_ str: String) -> UIColor? {
        let result = hex(str)
        return result != nil ? result : rgba(str)
    }
    
    static func hex(_ hex: String) -> UIColor? {
        var hex = hex.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        if hex.hasPrefix("#") {
            hex = String(hex.dropFirst())
        }
        
        if hex.hasPrefix("0x") {
            hex = String(hex.dropFirst(2))
        }
        
        let scanner = Scanner(string: hex)
        var hexNumber: UInt64 = 0
        
        if hex.count == 6 {
            if scanner.scanHexInt64(&hexNumber) {
                let r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                let g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                let b = CGFloat(hexNumber & 0x0000ff) / 255
                return UIColor.init(red: r, green: g, blue: b, alpha: 1.0)
            }
        }
        
        return nil
    }
    
    static func hex(_ hex: Int) -> UIColor? {
        return UIColor.init(
            red: CGFloat((hex >> 16) & 0xFF) / 255.0,
            green: CGFloat((hex >> 8) & 0xFF) / 255.0,
            blue: CGFloat(hex & 0xFF) / 255.0,
            alpha: 1.0
        )
    }
    
    static func rgb(_ red: Int, _ green: Int, _ blue: Int) -> UIColor {
        return UIColor.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    static func rgba(_ red: Int, _ green: Int, _ blue: Int, _ alpha: CGFloat) -> UIColor {
        return UIColor.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    static func rgba(_ str: String) -> UIColor? {
        let string = str.lowercased()
            .replacingOccurrences(of: "r", with: "")
            .replacingOccurrences(of: "g", with: "")
            .replacingOccurrences(of: "b", with: "")
            .replacingOccurrences(of: "a", with: "")
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: ",", with: " ")

        var red: Int?
        var green: Int?
        var blue: Int?
        var alpha: CGFloat?
        
        let l = string.split(separator: " ").map{String($0)}
        if l.count == 3 {
            red = colorInt(Int(l[0]))
            green = colorInt(Int(l[1]))
            blue = colorInt(Int(l[2]))
        } else if l.count == 4 {
            red = colorInt(Int(l[0]))
            green = colorInt(Int(l[1]))
            blue = colorInt(Int(l[2]))
            alpha = l[3].isNumeric ? alphaFloat(CGFloat(Double(l[3])!)) : nil
        }
                
        if let r = red, let g = green, let b = blue, let a = alpha {
            return rgba(r, g, b, a)
        } else if let r = red, let g = green, let b = blue {
            return rgb(r, g, b)
        }
        
        
        return nil
    }
}
