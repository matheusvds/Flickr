import Foundation

public protocol UserSettings {
    
    func get(setting: String) -> Data?
}
