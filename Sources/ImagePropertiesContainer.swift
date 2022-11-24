//
//  ImagePropertiesContainer.swift
//  SwiftyImageIO_iOS
//
//  Created by Aliaksandr Bialiauski on 12/8/17.
//  Copyright © 2017 Alexander Belyavskiy. All rights reserved.
//

import Foundation

public struct ImagePropertiesContainer {
    private var rawValues: CFRawValues
    
    public init(_ rawValues: CFRawValues) {
        self.rawValues = rawValues
    }
    
    public func get<ImagePropertiesType: ImageProperties>(_ kind: ImagePropertiesType.Type) -> ImagePropertiesType? {
        guard let rawCFImageProperties = rawValues[ImagePropertiesType.imageIOKey] else {
            return nil
        }
        
        guard let cfValue = rawCFImageProperties as? CFRawValues else {
            preconditionFailure("ImageIO implementation changed. Investigate.")
        }
        
        return ImagePropertiesType(cfValue)
    }
    
    public mutating func set<ImagePropertiesType: ImageProperties>(_ imageProperties: ImagePropertiesType) {
        rawValues[ImagePropertiesType.imageIOKey] = imageProperties.rawValues()
    }
    
    public mutating func mutate<ImagePropertiesType: ImageProperties>(with block: (inout ImagePropertiesType?) -> Void) {
        var imageProperties: ImagePropertiesType? = self.get(ImagePropertiesType.self)
        block(&imageProperties)
        
        if let imageProperties = imageProperties {
            set(imageProperties)
        }
    }
    
}

public extension ImagePropertiesContainer {
    
    var colorModel: String? {
        rawValues[kCGImagePropertyColorModel] as? String
    }
    
    var profileName: String? {
        rawValues[kCGImagePropertyProfileName] as? String
    }
    
    var exif: EXIFImageProperties? {
        get { self.get(EXIFImageProperties.self) }
        set {
            guard let value = newValue else { return }
            self.set(value)
        }
    }
    
}

