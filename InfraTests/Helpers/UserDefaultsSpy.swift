import Foundation

final class UserDefaultsSpy: UserDefaults {

    var stringArrayForKey: ((String) -> [String]?)?
    var setValueForKey: ((Any?, String) -> Void)?

    override init?(suiteName: String? = "UserDefaultsSpy") {
        guard let suiteName = suiteName else { return nil }

        super.init(suiteName: suiteName)
        removePersistentDomain(forName: suiteName)
    }

    override func stringArray(forKey defaultName: String) -> [String]? {
        return stringArrayForKey?(defaultName) ?? super.stringArray(forKey: defaultName)
    }

    override func set(_ value: Any?, forKey defaultName: String) {
        setValueForKey?(value, defaultName) ?? super.set(value, forKey: defaultName)
    }
}
