import Foundation

public protocol CFPropertyProtocol {
    var projectedValue: (key: CFString, value: CFValueConvertible?) { get }
    func assign(from cfValues: CFRawValues)
}

@propertyWrapper
public class CFProperty<T: CFValueRepresentable>: CFPropertyProtocol {
    
    private let key: CFString
    
    public init(key: CFString) {
        self.key = key
    }
    
    public var wrappedValue: T?
    
    public var projectedValue: (key: CFString, value: CFValueConvertible?) {
        (key: key, value: wrappedValue)
    }
    
    public func assign(from cfValues: CFRawValues) {
        guard let rawCfValue = cfValues[key] else { return }
        guard let cfValue = rawCfValue as? T.CFValue else {
            assertionFailure("Incorrect conversion type for \(key)")
            return
        }
        wrappedValue = T(cfValue: cfValue)
    }
    
}
