//
//  UIColor+Extensions.swift
//  UIFastKit
//
//  Created by 林季正 on 2020/11/8.
//

import Foundation

fileprivate func hexString2Color(hexString: String) -> UIColor? {
    let scanner = Scanner(string: hexString)
    var hexNumber: UInt64 = 0
    
    if hexString.count == 8 {
        if scanner.scanHexInt64(&hexNumber) {
            let r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
            let g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
            let b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
            let a = CGFloat(hexNumber & 0x000000ff) / 255

            return UIColor.init(red: r, green: g, blue: b, alpha: a)
        }
    } else if hexString.count == 6 {
        if scanner.scanHexInt64(&hexNumber) {
            let r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
            let g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
            let b = CGFloat(hexNumber & 0x0000ff) / 255

            return UIColor.init(red: r, green: g, blue: b, alpha: 1.0)
        }
    }
    
    return nil
}

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
    static func hex(_ hex: String) -> UIColor? {
        var hex = hex
        if hex.hasPrefix("#") {
            hex = String(hex.dropFirst())
        }
        
        if hex.hasPrefix("0x") || hex.hasPrefix("0X") {
            hex = String(hex.dropFirst().dropFirst())
        }
        
        let scanner = Scanner(string: hex)
        var hexNumber: UInt64 = 0
        
        if hex.count == 8 {
            if scanner.scanHexInt64(&hexNumber) {
                let r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                let g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                let b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                let a = CGFloat(hexNumber & 0x000000ff) / 255
                return UIColor.init(red: r, green: g, blue: b, alpha: a)
            }
        } else if hex.count == 6 {
            if scanner.scanHexInt64(&hexNumber) {
                let r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                let g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                let b = CGFloat(hexNumber & 0x0000ff) / 255
                return UIColor.init(red: r, green: g, blue: b, alpha: 1.0)
            }
        }
        
        return nil
    }
    
    static func rgb(_ red: Int, _ green: Int, _ blue: Int) -> UIColor {
        return UIColor.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    static func rgba(_ red: Int, _ green: Int, _ blue: Int, _ alpha: CGFloat) -> UIColor {
        return UIColor.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    static func rgba(_ string: String) -> UIColor? {
        var red: Int?
        var green: Int?
        var blue: Int?
        var alpha: CGFloat?
        
        if string.split(separator: ",").count == 3 {
            let l = string.split(separator: ",").map{String($0.trimmingCharacters(in: .whitespacesAndNewlines))}
            
            red = colorInt(Int(l[0]))
            green = colorInt(Int(l[1]))
            blue = colorInt(Int(l[2]))
        } else if string.split(separator: ",").count == 4 {
            let l = string.split(separator: ",").map{String($0.trimmingCharacters(in: .whitespacesAndNewlines))}
            red = colorInt(Int(l[0]))
            green = colorInt(Int(l[1]))
            blue = colorInt(Int(l[2]))
            alpha = l[3].isNumeric ? alphaFloat(CGFloat(Double(l[3])!)) : nil
        } else if string.split(separator: " ").count == 3 {
            let l = string.split(separator: " ").map{String($0)}
            red = colorInt(Int(l[0]))
            green = colorInt(Int(l[1]))
            blue = colorInt(Int(l[2]))
        } else if string.split(separator: " ").count == 4 {
            let l = string.split(separator: " ").map{String($0)}
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
