import Foundation

public protocol UserSettings {
    
    func get(setting: String) -> Data?
    func set(value: [String], for setting: String)
}
