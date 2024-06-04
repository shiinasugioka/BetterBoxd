import SwiftUI

extension Color {
    static let darkBlue = Color(hex: "#272838")
    static let foregroundWhite = Color(hex: "#F9F8F8")
    static let pastelYellow = Color(hex: "#F3DE8A")
    static let salmonPink = Color(hex: "#EB9486")
    static let lightBlue = Color(hex: "#7E7F9A")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    static func fromHex(_ hex: String) -> Color {
                var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
                hexSanitized = hexSanitized.hasPrefix("#") ? String(hexSanitized.dropFirst()) : hexSanitized

                let scanner = Scanner(string: hexSanitized)
                var rgbValue: UInt64 = 0
                scanner.scanHexInt64(&rgbValue)

                let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
                let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
                let blue = Double(rgbValue & 0x0000FF) / 255.0

                return Color(red: red, green: green, blue: blue)
            }
        static let customBackground = Color(red: 39/255, green: 40/255, blue: 56/255)
        static let primary = Color(red: 243/255, green: 222/255, blue: 138/255)
        static let secondary = Color(red: 235/255, green: 148/255, blue: 134/255)
        static let highlight = Color(red: 39/255, green: 40/255, blue: 56/255)
        static let text = Color(red: 249/255, green: 248/255, blue: 248/255)
        static let lightGray = Color(UIColor.lightGray.withAlphaComponent(0.3))
        static let darkGray = Color(UIColor.darkGray)
    
    func toUIColor() -> UIColor {
        let components = self.cgColor?.components
        let red = components?[0] ?? 0.0
        let green = components?[1] ?? 0.0
        let blue = components?[2] ?? 0.0
        let alpha = components?[3] ?? 1.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
