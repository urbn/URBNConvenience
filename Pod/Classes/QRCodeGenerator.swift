//
//  QRCodeGenerator.swift
//  Pods
//
//  Created by Nick DiStefano on 12/23/15.
//
//

import Foundation


public extension String {
    public func qrImage() -> CIImage? {
        let data = dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue("Q", forKey: "inputCorrectionLevel")
        
        return filter?.outputImage
    }
    
    public func qrImage(foregroundColor foregroundColor: UIColor, backgroundColor: UIColor, size: CGSize) -> UIImage? {
        return qrImage()?.scale(size)?.color(foregroundColor: foregroundColor, backgroundColor: backgroundColor)?.mapToUIImage()
    }
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
        let foregroundCoreColor = CIColor(uiColor: foregroundColor)
        let backgroundCoreColor = CIColor(uiColor: backgroundColor)
        
        let colorFilter = CIFilter(name: "CIFalseColor", withInputParameters: ["inputImage": self, "inputColor0":foregroundCoreColor, "inputColor1":backgroundCoreColor])
        
        return colorFilter?.outputImage
    }
}

extension CIColor {
    convenience init(uiColor: UIColor) {
        let foregroundColorRef = uiColor.CGColor
        let foregroundColorString = CIColor(CGColor: foregroundColorRef).stringRepresentation
        
        self.init(string: foregroundColorString)
    }
}
