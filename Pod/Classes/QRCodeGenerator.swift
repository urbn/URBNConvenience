//
//  QRCodeGenerator.swift
//  Pods
//
//  Created by Nick DiStefano on 12/23/15.
//
//

import Foundation


public func scaledColoredQRImage(text: String, foregroundColor: UIColor, backgroundColor: UIColor, size: CGSize) -> UIImage? {
    return color(scale(qrImage(text), size: size), foregroundColor: foregroundColor, backgroundColor: backgroundColor)
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

public func color(image: CIImage?, foregroundColor: UIColor, backgroundColor: UIColor) -> UIImage? {
    guard let imageToColor = image else { return nil }
    
    let foregroundCoreColor = convertToCIColor(foregroundColor)
    let backgroundCoreColor = convertToCIColor(backgroundColor)

    let colorFilter = CIFilter(name: "CIFalseColor", withInputParameters: ["inputImage": imageToColor, "inputColor0":foregroundCoreColor, "inputColor1":backgroundCoreColor])
    guard let finalCIImage = colorFilter?.outputImage else { return nil }
    
    return UIImage(CIImage: finalCIImage)
}

public func convertToCIColor(color: UIColor) -> CIColor {
    let foregroundColorRef = color.CGColor
    let foregroundColorString = CIColor(CGColor: foregroundColorRef).stringRepresentation
    
    return CIColor(string: foregroundColorString)
}