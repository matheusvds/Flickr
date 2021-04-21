import Domain
import Foundation

public final class LocalGetSuggestions: GetSuggestions {
    
    private let userSettings: UserSettings
    
    public init(userSettings: UserSettings) {
        self.userSettings = userSettings
    }
    
    public func getSuggestions() -> [String] {
        guard
            let data = userSettings.get(setting: "suggestions"),
            let suggestions = try? JSONDecoder().decode([String].self, from: data)
        else {
            return []
        }
        
        return suggestions
    }
}
