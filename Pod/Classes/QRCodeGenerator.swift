//
//  QRCodeGenerator.swift
//  Pods
//
//  Created by Nick DiStefano on 12/23/15.
//
//

import Foundation


public func qrImage(textToEncode text: String, foregroundColor: UIColor, backgroundColor: UIColor, size: CGSize) -> UIImage? {
    return qrImage(textToEncode: text)?.scale(size)?.color(foregroundColor: foregroundColor, backgroundColor: backgroundColor)?.mapToUIImage()
}

public func qrImage(textToEncode text: String) -> CIImage? {
    let data = text.dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)
    let filter = CIFilter(name: "CIQRCodeGenerator")
    
    filter?.setValue(data, forKey: "inputMessage")
    filter?.setValue("Q", forKey: "inputCorrectionLevel")
    
    return filter?.outputImage
}

public extension CIImage {
    public func mapToUIImage() -> UIImage? {
        return UIImage(CIImage: self)
    }
    
    public func scale(size: CGSize) -> CIImage? {
        let scaleX = size.width / extent.size.width
        let scaleY = size.height / extent.size.height
        
        return imageByApplyingTransform(CGAffineTransformMakeScale(scaleX, scaleY))
    }
    
    public func color(foregroundColor foregroundColor: UIColor, backgroundColor: UIColor) -> CIImage? {
        let foregroundCoreColor = convertToCIColor(foregroundColor)
        let backgroundCoreColor = convertToCIColor(backgroundColor)
        
        let colorFilter = CIFilter(name: "CIFalseColor", withInputParameters: ["inputImage": self, "inputColor0":foregroundCoreColor, "inputColor1":backgroundCoreColor])
        
        return colorFilter?.outputImage
    }
}

public func convertToCIColor(color: UIColor) -> CIColor {
    let foregroundColorRef = color.CGColor
    let foregroundColorString = CIColor(CGColor: foregroundColorRef).stringRepresentation
    
    return CIColor(string: foregroundColorString)
}
