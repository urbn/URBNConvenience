//
//  TableViewHelpers.swift
//  Pods
//
//  Created by Nick DiStefano on 5/20/16.
//
//

import Foundation

//based on https://medium.com/@calebd/swift-reusable-cells-31391d2f2906#.owjb1kpk2
extension UITableView {
    public final func registerReusableCell<T>(_ cell: ReusableCell<T>) where T: UITableViewCell {
        switch cell {
        case .class(let identifier):
            register(T.self, forCellReuseIdentifier: identifier)
        case .nib(let identifier, let nibName, let bundle):
            let nib = UINib(nibName: nibName, bundle: bundle)
            register(nib, forCellReuseIdentifier: identifier)
        }
    }
    
    public final func dequeueReusableCell<T>(_ cell: ReusableCell<T>, indexPath: IndexPath) -> T where T: UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: cell.identifier, for: indexPath) as? T else {
            assert(false, "type error how is this possible?")
            return T()
        }
        return cell
    }
}

public enum ReusableCell<Cell> {
    case `class`(identifier: String)
    case nib(identifier: String, nibName: String, bundle: Bundle?)
    
    public var identifier: String {
        switch self {
        case .class(let identifier):
            return identifier
        case .nib(let identifier, _, _):
            return identifier
        }
    }
    
    public init(identifier: String) {
        self = .class(identifier: identifier)
    }
    
    public init(identifier: String, nibName: String, bundle: Bundle? = nil) {
        self = .nib(identifier: identifier, nibName: nibName, bundle: bundle)
    }
}
