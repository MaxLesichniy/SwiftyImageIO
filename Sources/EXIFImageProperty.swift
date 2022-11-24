import Foundation
import ImageIO

public struct EXIFImageProperties {
    public init() {}
    
    @CFProperty(key: kCGImagePropertyExifExposureTime)
    public var exposureTime: TimeInterval?
    
    @CFProperty(key: kCGImagePropertyExifFNumber)
    public var fNumber: Double?
    
    @CFProperty(key: kCGImagePropertyExifISOSpeedRatings)
    public var ISOSpeedRatings: [Int]?
    
    @CFProperty(key: kCGImagePropertyExifExposureBiasValue)
    public var exposureBiasValue: Float?
    
//    @CFProperty(key: kCGImagePropertyExifColorSpace)
//    public var colorSpace: CGColorSpace?
    
    @CFProperty(key: kCGImagePropertyExifLensModel)
    public var lensModel: String?
    
}

extension EXIFImageProperties: ImageProperties {
    
    public static var imageIOKey: CFString {
        return kCGImagePropertyExifDictionary
    }
    
    public var values: CFValues {
        let mirror = Mirror(reflecting: self)
        let values = mirror.children.compactMap { child in
            if let property = child.value as? CFPropertyProtocol {
                return property.projectedValue
            }
            return nil
        }
        return values.rawCfValues()
    }
    
    public init(_ cfValues: CFRawValues) {
        let mirror = Mirror(reflecting: self)
        mirror.children.forEach { child in
            if let property = child.value as? CFPropertyProtocol {
                return property.assign(from: cfValues)
            }
        }
    }
    
}
