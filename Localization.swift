//
//  Localization.swift
//  SwiftyImageIO
//
//  Created by Max Lesichniy on 19.11.2022.
//

import Foundation
import ImageIO

public func ImageIOLocalizedString(_ key: CFString) -> String? {
    let bundle = Bundle(identifier: "com.apple.ImageIO")
    return bundle?.localizedString(forKey: key as String, value: key as String, table: "CGImageSource")
}


