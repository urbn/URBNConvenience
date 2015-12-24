//
//  QRCodeGenerator.swift
//  Pods
//
//  Created by Nick DiStefano on 12/23/15.
//
//

import Foundation


public func qrImage(text: String, foregroundColor: UIColor? = nil, backgroundColor: UIColor? = nil, size: CGSize? = nil) -> UIImage? {
    if let sizeForImage = size, foreColor = foregroundColor, backColor = backgroundColor {
        return imageConvert(color(scale(qrImage(text), size: sizeForImage), foregroundColor: foreColor, backgroundColor: backColor))
    }
    
    if let sizeForImage = size {
        return imageConvert(scale(qrImage(text), size: sizeForImage))
    }
    
    if let foreColor = foregroundColor, backColor = backgroundColor {
        return imageConvert(color(qrImage(text), foregroundColor: foreColor, backgroundColor: backColor))
    }

    return nil
}

public func qrImage(text: String) -> CIImage? {
    let data = text.dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)
    let filter = CIFilter(name: "CIQRCodeGenerator")
    
    filter?.setValue(data, forKey: "inputMessage")
    filter?.setValue("Q", forKey: "inputCorrectionLevel")
    
    return filter?.outputImage
}

public func scale(image: CIImage?, size: CGSize) -> CIImage? {
    guard let imageToScale = image else { return nil }
    
    let scaleX = size.width / imageToScale.extent.size.width
    let scaleY = size.height / imageToScale.extent.size.height
    
    return imageToScale.imageByApplyingTransform(CGAffineTransformMakeScale(scaleX, scaleY))
}

public func color(image: CIImage?, foregroundColor: UIColor, backgroundColor: UIColor) -> CIImage? {
    guard let imageToColor = image else { return nil }
    
    let foregroundCoreColor = convertToCIColor(foregroundColor)
    let backgroundCoreColor = convertToCIColor(backgroundColor)

    let colorFilter = CIFilter(name: "CIFalseColor", withInputParameters: ["inputImage": imageToColor, "inputColor0":foregroundCoreColor, "inputColor1":backgroundCoreColor])
    
    return colorFilter?.outputImage
}

public func convertToCIColor(color: UIColor) -> CIColor {
    let foregroundColorRef = color.CGColor
    let foregroundColorString = CIColor(CGColor: foregroundColorRef).stringRepresentation
    
    return CIColor(string: foregroundColorString)
}

public func imageConvert(ciImage: CIImage?) -> UIImage? {
    guard let image = ciImage else { return nil }
    return UIImage(CIImage: image)
}