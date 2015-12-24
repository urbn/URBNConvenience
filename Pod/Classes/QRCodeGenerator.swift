//
//  QRCodeGenerator.swift
//  Pods
//
//  Created by Nick DiStefano on 12/23/15.
//
//

import Foundation


public typealias Filter = CIImage? -> CIImage?

infix operator >>> { associativity left }

func >>> ( Filter1 : Filter , Filter2 : Filter ) -> Filter {
    return { image in Filter2 ( Filter1 (image)) }
}

public func qrImage(text: String, foregroundColor: UIColor, backgroundColor: UIColor, size: CGSize) -> UIImage? {
    let qrFilter = scale(size) >>> falseColor(foregroundColor: foregroundColor, backgroundColor: backgroundColor)

    return qrFilter(qrImage(text))?.mapToUIImage()
}

public func qrImage(text: String) -> CIImage? {
    let data = text.dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)
    let filter = CIFilter(name: "CIQRCodeGenerator")
    
    filter?.setValue(data, forKey: "inputMessage")
    filter?.setValue("Q", forKey: "inputCorrectionLevel")
    
    return filter?.outputImage
}

public func scale(size: CGSize) -> Filter {
    return { image in
        guard let imageToScale = image else { return nil }

        let scaleX = size.width / imageToScale.extent.size.width
        let scaleY = size.height / imageToScale.extent.size.height
        
        return imageToScale.imageByApplyingTransform(CGAffineTransformMakeScale(scaleX, scaleY))
    }
}

public func falseColor(foregroundColor foregroundColor: UIColor, backgroundColor: UIColor) -> Filter {
    return { image in
        guard let imageToColor = image else { return nil }
        
        let foregroundCoreColor = convertToCIColor(foregroundColor)
        let backgroundCoreColor = convertToCIColor(backgroundColor)
        
        let colorFilter = CIFilter(name: "CIFalseColor", withInputParameters: ["inputImage": imageToColor, "inputColor0":foregroundCoreColor, "inputColor1":backgroundCoreColor])
        
        return colorFilter?.outputImage
    }
}

public extension CIImage {
    public func mapToUIImage() -> UIImage? {
        return UIImage(CIImage: self)
    }
}

public func convertToCIColor(color: UIColor) -> CIColor {
    let foregroundColorRef = color.CGColor
    let foregroundColorString = CIColor(CGColor: foregroundColorRef).stringRepresentation
    
    return CIColor(string: foregroundColorString)
}