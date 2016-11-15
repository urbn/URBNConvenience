//
//  ConstraintConvenience.swift
//  Pods
//
//  Created by Nick DiStefano on 12/11/15.
//
//

import Foundation

public func activateVFL(format: String, options: NSLayoutFormatOptions = [], metrics: [String : Any]? = nil, views: [String : Any]) {
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
    @available(*, unavailable, message: "use addSubviewsWithNoConstraints instead")
    public func addSubviewWithNoConstraints(_ subview: UIView) { }
    
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
    
    public func wrapInView(_ view: UIView? = nil, withInsets insets: UIEdgeInsets = UIEdgeInsets.zero) -> UIView {
        var container: UIView
        if let view = view {
            container = view
        }
        else {
            container = UIView()
            container.translatesAutoresizingMaskIntoConstraints = false
        }
        
        container.addSubviewsWithNoConstraints(self)
        
        let metrics = ["top": insets.top, "left": insets.left, "bottom": insets.bottom, "right": insets.right]
        activateVFL(format: "H:|-left-[view]-right-|", metrics: metrics, views: ["view": self])
        activateVFL(format: "V:|-top-[view]-bottom-|", metrics: metrics, views: ["view": self])
        
        return container
    }
}
