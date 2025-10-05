import SwiftUI

struct AppSpacing {
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 12
    static let lg: CGFloat = 16
    static let xl: CGFloat = 24
    static let xxl: CGFloat = 32
    static let xxxl: CGFloat = 48
}

// Spacing scale: 8/12/16/24
extension CGFloat {
    static let spacingXS = AppSpacing.xs
    static let spacingSM = AppSpacing.sm
    static let spacingMD = AppSpacing.md
    static let spacingLG = AppSpacing.lg
    static let spacingXL = AppSpacing.xl
    static let spacingXXL = AppSpacing.xxl
    static let spacingXXXL = AppSpacing.xxxl
}
