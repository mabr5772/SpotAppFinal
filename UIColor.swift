import SwiftUI

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var formattedHex = hex
        if formattedHex.hasPrefix("#") {
            formattedHex.remove(at: formattedHex.startIndex)
        }
        
        let scanner = Scanner(string: formattedHex)
        var hexNumber: UInt64 = 0
        
        if scanner.scanHexInt64(&hexNumber) {
            let red = CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0
            let green = CGFloat((hexNumber & 0x00FF00) >> 8) / 255.0
            let blue = CGFloat(hexNumber & 0x0000FF) / 255.0
            self.init(red: red, green: green, blue: blue, alpha: alpha)
            return
        }
        
        self.init(red: 0, green: 0, blue: 0, alpha: alpha)
    }
}
