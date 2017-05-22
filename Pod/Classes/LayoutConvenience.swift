//
//  ConstraintConvenience.swift
//  Pods
//
//  Created by Nick DiStefano on 12/11/15.
//
//

import Foundation

public typealias InsetConstraint = (constant: CGFloat, priority: UILayoutPriority)
fileprivate var defaultInsetConstraint: InsetConstraint {
    return (constant: 0.0, priority: UILayoutPriorityRequired)
}

public struct InsetConstraints {
    var top: InsetConstraint = defaultInsetConstraint
    var left: InsetConstraint = defaultInsetConstraint
    var right: InsetConstraint = defaultInsetConstraint
    var bottom: InsetConstraint = defaultInsetConstraint
}

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
    
    @available(iOS 9, *)
    public func wrapInView(_ view: UIView? = nil, withInsetConstraints insetConstraints: InsetConstraints) -> UIView {
        var container: UIView
        if let view = view {
            container = view
        }
        else {
            container = UIView()
            container.translatesAutoresizingMaskIntoConstraints = false
        }
        
        container.addSubviewsWithNoConstraints(self)
        let topAnchor = container.topAnchor.constraint(equalTo: self.topAnchor, constant: insetConstraints.top.constant)
        topAnchor.priority = insetConstraints.top.priority
        topAnchor.isActive = true
        
        let leftAnchor = container.leftAnchor.constraint(equalTo: self.leftAnchor, constant: insetConstraints.left.constant)
        leftAnchor.priority = insetConstraints.left.priority
        leftAnchor.isActive = true
        
        let bottomAnchor = container.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -insetConstraints.bottom.constant)
        bottomAnchor.priority = insetConstraints.bottom.priority
        bottomAnchor.isActive = true
        
        let rightAnchor = container.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -insetConstraints.right.constant)
        rightAnchor.priority = insetConstraints.right.priority
        rightAnchor.isActive = true
        
        return container
    }
}

@available(iOS 9.0, *)
public extension UIStackView {
    
    public func addArrangedSubviews(_ subviews: UIView...) {
        addArrangedSubviews(subviews)
    }
    
    public func addArrangedSubviews(_ subviews: [UIView]) {
        for v in subviews {
            addArrangedSubview(v)
        }
    }
}
