import SwiftUI

@propertyWrapper
struct StructArrayStorage<T: Codable> {
    private let key: String
    private let defaultValue: [T]
    
    init(key: String, defaultValue: [T]) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: [T] {
        get {
            if let data = UserDefaults.standard.data(forKey: key),
               let decodedValue = try? JSONDecoder().decode([T].self, from: data) {
                return decodedValue
            }
            return defaultValue
        }
        set {
            if let encodedValue = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encodedValue, forKey: key)
            }
        }
    }
}
