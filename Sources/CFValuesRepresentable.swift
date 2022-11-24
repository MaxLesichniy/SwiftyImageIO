import Foundation

public protocol CFValuesRepresentable {
    var values: CFValues { get }
}

internal extension CFValuesRepresentable {
    func rawValues() -> CFDictionary {
        var result: [CFString: AnyObject] = [:]
        
        for (imageIOKey, value) in values {
            result[imageIOKey] = value?.cfValue
        }
        
        return result as CFDictionary
    }
}
