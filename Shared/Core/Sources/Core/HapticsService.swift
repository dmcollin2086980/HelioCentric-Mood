import Foundation
import UIKit

protocol HapticsService {
    func triggerTabChange()
    func triggerSuccess()
    func triggerError()
    func triggerSelection()
}

final class SystemHapticsService: HapticsService {
    private let impactFeedback = UIImpactFeedbackGenerator(style: .light)
    private let notificationFeedback = UINotificationFeedbackGenerator()
    private let selectionFeedback = UISelectionFeedbackGenerator()
    
    func triggerTabChange() {
        impactFeedback.impactOccurred()
    }
    
    func triggerSuccess() {
        notificationFeedback.notificationOccurred(.success)
    }
    
    func triggerError() {
        notificationFeedback.notificationOccurred(.error)
    }
    
    func triggerSelection() {
        selectionFeedback.selectionChanged()
    }
}

final class NoopHapticsService: HapticsService {
    func triggerTabChange() {}
    func triggerSuccess() {}
    func triggerError() {}
    func triggerSelection() {}
}
