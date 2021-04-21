import Foundation
import Data

public final class UserDefaultsAdapter: UserSettings {
    
    private let userDefaults: UserDefaults
    
    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    public func get(setting: String) -> Data? {
        let settings = userDefaults.stringArray(forKey: setting)
        return try? JSONEncoder().encode(settings)
    }
}
