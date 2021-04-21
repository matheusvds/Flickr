import Foundation
import Data

final class UserSettingsSpy: UserSettings {
    
    var data: Data?
    
    func get(setting: String) -> Data? {
        return data
    }
    
    func completeWithNilData() {
        self.data = nil
    }
    
    func completeWith(data: Data?) {
        self.data = data
    }
}
