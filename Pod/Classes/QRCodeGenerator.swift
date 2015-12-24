//
//  QRCodeGenerator.swift
//  Pods
//
//  Created by Nick DiStefano on 12/23/15.
//
//

import Foundation

public func qrImage(text: String, foregroundColor: UIColor, backgroundColor: UIColor, height: CGFloat, width: CGFloat) -> UIImage? {
    let foregroundColorRef = foregroundColor.CGColor
    let foregroundColorString = CIColor(CGColor: foregroundColorRef).stringRepresentation
    let foregroundCoreColor = CIColor(string: foregroundColorString)
    let backgroundColorRef = backgroundColor.CGColor
    let backgroundColorString = CIColor(CGColor: backgroundColorRef).stringRepresentation
    let backgroundColor = CIColor(string: backgroundColorString)
    
    let data = text.dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)
    
    let filter = CIFilter(name: "CIQRCodeGenerator")
    
    filter?.setValue(data, forKey: "inputMessage")
    filter?.setValue("Q", forKey: "inputCorrectionLevel")
    
    guard let qrcodeImage = filter?.outputImage else { return nil }
    
    let scaleX = width / qrcodeImage.extent.size.width
    let scaleY = height / qrcodeImage.extent.size.height
    
    let transformedImage = qrcodeImage.imageByApplyingTransform(CGAffineTransformMakeScale(scaleX, scaleY))
    
    let colorFilter = CIFilter(name: "CIFalseColor", withInputParameters: ["inputImage": transformedImage, "inputColor0":foregroundCoreColor, "inputColor1":backgroundColor])
    guard let finalCIImage = colorFilter?.outputImage else { return nil }
    
    return UIImage(CIImage: finalCIImage)
}