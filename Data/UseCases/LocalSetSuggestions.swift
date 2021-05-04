import Domain
import Foundation

public final class LocalSetSuggestions: SetSuggestions {
    
    private let userSettings: UserSettings
    private let getSuggestions: GetSuggestions
    
    public init(userSettings: UserSettings, getSuggestions: GetSuggestions) {
        self.userSettings = userSettings
        self.getSuggestions = getSuggestions
    }
    
    public func set(suggestion: String) {
        var suggestions = getSuggestions.getSuggestions()
        suggestions.append(suggestion)
        suggestions = suggestions.filter { !$0.isEmpty }
        userSettings.set(value: suggestions.suffix(5), for: "suggestions")
    }
}
