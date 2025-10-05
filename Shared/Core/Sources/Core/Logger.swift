import Foundation
import os

extension Logger {
    convenience init(subsystem: String, category: String) {
        self.init(subsystem: subsystem, category: category)
    }
}
