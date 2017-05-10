//
//  UIImageConvenience.swift
//  Pods
//
//  Created by Ashley Beck on 12/9/16.
//
//

import Foundation

public extension UIImage {
    public func tintedImage(color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContext(self.size)
        let context = UIGraphicsGetCurrentContext()

        context?.scaleBy(x: 1.0, y: -1.0)
        context?.translateBy(x: 0.0, y: -self.size.height)
        context?.setBlendMode(CGBlendMode.multiply)

        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)

        if let cGImage = self.cgImage {
            context?.clip(to: rect, mask: cGImage)
        }

        color.setFill()
        context?.fill(rect)

        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()

        return newImage
    }

    //TODO: Check this logic in a different PR. Seems brands aren't really using it.
    public static func imageDrawnWithKey(key: NSString, size: CGSize, drawBlock: URBNConvenienceImageDrawBlock) -> UIImage? {
        assert(size.width > 0 && size.height > 0, "Invalid image size (both dimensions must be greater than zero")

        let imageCache = NSCache<NSString, UIImage>()
        guard var image = imageCache.object(forKey: key) else { return nil }

        UIGraphicsBeginImageContextWithOptions(size, true, UIScreen.main.scale)
        if let context = UIGraphicsGetCurrentContext() {
            drawBlock(CGRect(x: 0, y: 0, width: size.width, height: size.height), context)

            guard let currentContext = UIGraphicsGetImageFromCurrentImageContext() else { return nil }

            image = currentContext
            imageCache.setObject(image, forKey: key)
            UIGraphicsEndImageContext()
        }

        return image
    }

    public static func screenShot(view: UIView, afterScreenUpdates: Bool) -> UIImage? {
        UIGraphicsBeginImageContext(CGSize(width: view.frame.size.width, height: view.frame.size.height))
        view.drawHierarchy(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), afterScreenUpdates: afterScreenUpdates)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }

    public static func scaleAndCropped(image: UIImage, radius: CGFloat) -> UIImage? {
        let scaledImage = image.scaleImage(size: CGSize(width: radius, height: radius))?.squareCroppedImageFromCenter(width: radius)

        UIGraphicsBeginImageContextWithOptions(CGSize(width: radius, height: radius), false, 0.0)

        let context = UIGraphicsGetCurrentContext()
        let circlePath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: radius, height: radius))
        context?.addPath(circlePath.cgPath)
        context?.clip()

        var newImage = UIImage()

        guard let width = scaledImage?.size.height, let height = scaledImage?.size.height else { return nil }
        image.draw(in: CGRect(x: 0, y: 0, width: width, height: height))

        if let currentContext = UIGraphicsGetImageFromCurrentImageContext() {
            newImage = currentContext
        }

        UIGraphicsEndImageContext()

        return newImage
    }

    #if !os(tvOS) 
    public static func roundedStretchableImage(color: UIColor, cornerRadius: CGFloat) -> UIImage {
        let rectSize = max(cornerRadius, 4.0) * 2.0
        let rect = CGRect(x: 0, y: 0, width: rectSize, height: rectSize)

        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()

        let inset: CGFloat = cornerRadius == 0 ? 0.0 : 0.5
        UIBezierPath(roundedRect: rect.insetBy(dx: inset, dy: inset), cornerRadius: cornerRadius).fill()

        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        UIGraphicsEndImageContext()

        let rectWidth = rect.size.width / 2
        let rectHeight = rect.size.height / 2

        return image.stretchableImage(withLeftCapWidth: Int(rectWidth), topCapHeight: Int(rectHeight))
    }

    public static func stretchableImage(color: UIColor) -> UIImage {
        return roundedStretchableImage(color: color, cornerRadius: 0.0)
    }
    #endif

    public func scaleImage(size: CGSize) -> UIImage? {
        let hRatio = size.width / self.size.width
        let vRatio = size.height / self.size.height
        let ratio = max(hRatio, vRatio)
        var newRect = CGRect(x: 0.0, y: 0.0, width: self.size.width * ratio, height: self.size.height * ratio).integral

        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            newRect = CGRect(x: 0.0, y: 0.0, width: self.size.width * ratio, height: self.size.height * ratio)
            break
        default:
            break
        }

        UIGraphicsBeginImageContext(CGSize(width: self.size.width * ratio, height: self.size.height * ratio))

        guard let context = UIGraphicsGetCurrentContext(), let transform = transformForOrientation(newSize: newRect.size), let cgImage = self.cgImage else { return nil}
        context.concatenate(transform)
        context.draw(cgImage, in: newRect)

        guard let newImageRef = context.makeImage() else { return nil }
        let newImage = UIImage(cgImage: newImageRef)

        return newImage
    }

    public func squareCroppedImageFromCenter(width: CGFloat) -> UIImage? {
        let cropRect = CGRect(x: self.size.width - width / 2, y: self.size.height - width, width: width, height: width)

        guard let cgImage = self.cgImage, let imageReference = cgImage.cropping(to: cropRect) else { return nil }
        let croppedImage = UIImage(cgImage: imageReference)

        return croppedImage
    }

    public func transformForOrientation(newSize: CGSize) -> CGAffineTransform? {
        var transform = CGAffineTransform.identity

        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
            break
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat(Double.pi / 2))
            break
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat(-(Double.pi / 2)))
            break
        case .up, .upMirrored:
            break
        }

        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform.translatedBy(x: size.width, y: 0)
            transform.scaledBy(x: -1, y: 1)
            break
        case .leftMirrored, .rightMirrored:
            transform.translatedBy(x: size.height, y: 0)
            transform.scaledBy(x: -1, y: 1)
            break
        case .up, .down, .left, .right:
            break
        }

        return transform
    }

    public func orientImage(orientation: UIImageOrientation) -> UIImage? {
        if imageOrientation == orientation {
            return self
        }

        var degreesRotate = 0.0
        let rightAngel = 90.0
        let imageIsUp = imageOrientation == .up || imageOrientation == .upMirrored
        let imageIsDown = imageOrientation == .down || imageOrientation == .downMirrored
        let imageIsLeft = imageOrientation == .left || imageOrientation == .leftMirrored
        let imageIsRight = imageOrientation == .right || imageOrientation == .rightMirrored

        if imageIsUp || imageIsDown {
            let multiplier: Double = imageIsUp ? 1 : -1

            switch orientation {
            case .left, .leftMirrored:
                degreesRotate = multiplier * -rightAngel
                break
            case .right, .rightMirrored:
                degreesRotate = multiplier * rightAngel
                break
            case .down, .downMirrored, .up, .upMirrored:
                degreesRotate = rightAngel * 2
                break
            }
        }
        else if imageIsRight || imageIsLeft {
            let multiplier: Double = imageIsRight ? 1 : -1

            switch orientation {
            case .up, .upMirrored:
                degreesRotate = multiplier * -rightAngel
                break
            case .down, .downMirrored:
                degreesRotate = multiplier * rightAngel
                break
            case .left, .leftMirrored, .right, .rightMirrored:
                degreesRotate = rightAngel * 2
                break
            }
        }

        guard let image = rotateImage(degrees: CGFloat(degreesRotate)) else { return nil }

        return image
    }

    public func rotateImage(degrees: CGFloat) -> UIImage? {
        let radians = Double(degrees / 180.0) * Double.pi
        let rotatedViewBox = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.size.width, height: self.size.height))
        let transform = CGAffineTransform(rotationAngle: CGFloat(radians))
        rotatedViewBox.transform = transform

        let rotatedSize = rotatedViewBox.frame.size

        UIGraphicsBeginImageContextWithOptions(rotatedSize, false, 0.0)

        guard let bitmap = UIGraphicsGetCurrentContext(), let cgImage = self.cgImage else { return nil }
        bitmap.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
        bitmap.rotate(by: CGFloat(radians))
        bitmap.scaleBy(x: 1.0, y: -1.0)
        bitmap.draw(cgImage, in: CGRect(x: -self.size.width / 2, y: -self.size.height / 2, width: self.size.width, height: self.size.height))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()

        return newImage
    }
}
