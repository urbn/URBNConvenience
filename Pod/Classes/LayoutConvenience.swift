//
//  ConstraintConvenience.swift
//  Pods
//
//  Created by Nick DiStefano on 12/11/15.
//
//

import Foundation

public func activateVFL(format format: String, options: NSLayoutFormatOptions = [], metrics: [String : AnyObject]? = nil, views: [String : AnyObject]) {
    NSLayoutConstraint.activateConstraints(
        NSLayoutConstraint.constraintsWithVisualFormat(
            format,
            options: options,
            metrics: metrics,
            views: views
        )
    )
}

public extension UIView {
    @available(*, deprecated, message="addSubviewsWithNoConstraints instead")
    public func addSubviewWithNoConstraints(subview: UIView) {
        addSubviewsWithNoConstraints(subview)
    }
    
    public func addSubviewsWithNoConstraints(subviews: UIView...) {
        addSubviewsWithNoConstraints(subviews)
    }
    
    public func addSubviewsWithNoConstraints(subviews: [UIView]) {
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
            addSubview(v)
        }
    }
    
    public func addSubviewsWithNoConstraints(subviews: LazyMapCollection<[String: UIView], UIView>) {
        addSubviewsWithNoConstraints(Array(subviews))
    }
}
