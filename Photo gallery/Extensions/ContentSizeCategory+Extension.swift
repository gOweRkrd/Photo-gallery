import SwiftUI

enum SFProDisplay: String {
    case medium = "SFProDisplay-Medium"
    case bold = "SFProDisplay-Bold"
    case regular = "SFProDisplay-Regular"
    case semiBold = "SFProRounded-Semibold"
}

extension ContentSizeCategory {
    var size: CGFloat {
        switch self {
        case .extraSmall:
                return 12
        case .small:
                return 14
        case .medium:
                return 16
        case .large:
                return 18
        case .extraLarge:
                return 20
        case .extraExtraLarge:
                return 24
        case .extraExtraExtraLarge:
                return 26
        case .accessibilityExtraLarge:
                return 28
        default:
                return 14
        }
    }
}
