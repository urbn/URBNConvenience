//
//  ConstraintConvenience.swift
//  Pods
//
//  Created by Nick DiStefano on 12/11/15.
//
//

import Foundation

public func activateVFL(format: String, options: NSLayoutFormatOptions = [], metrics: [String : AnyObject]? = nil, views: [String : AnyObject]) {
    NSLayoutConstraint.activate(
        NSLayoutConstraint.constraints(
            withVisualFormat: format,
            options: options,
            metrics: metrics,
            views: views
        )
    )
}

public extension UIView {
    @available(*, deprecated, message: "addSubviewsWithNoConstraints instead")
    public func addSubviewWithNoConstraints(_ subview: UIView) {
        addSubviewsWithNoConstraints(subview)
    }
    
    public func addSubviewsWithNoConstraints(_ subviews: UIView...) {
        addSubviewsWithNoConstraints(subviews)
    }
    
    public func addSubviewsWithNoConstraints(_ subviews: [UIView]) {
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
            addSubview(v)
        }
    }
    
    public func addSubviewsWithNoConstraints<T: UIView>(_ subviews: LazyMapCollection<[String: T], T>) {
        addSubviewsWithNoConstraints(Array(subviews))
    }
}
