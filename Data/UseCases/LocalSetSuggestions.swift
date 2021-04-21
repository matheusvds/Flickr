import Domain
import Foundation

public final class LocalSetSuggestions: SetSuggestions {
    
    private let userSettings: UserSettings
    
    public init(userSettings: UserSettings) {
        self.userSettings = userSettings
    }
    
    public func set(suggestions: [String]) {
        userSettings.set(value: suggestions, for: "suggestions")
    }
}
