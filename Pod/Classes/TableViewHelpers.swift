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
    public final func registerReusableCell<T where T: UITableViewCell>(cell: ReusableCell<T>) {
        switch cell {
        case .Class(let identifier):
            registerClass(T.self, forCellReuseIdentifier: identifier)
        case .Nib(let identifier, let nibName, let bundle):
            let nib = UINib(nibName: nibName, bundle: bundle)
            registerNib(nib, forCellReuseIdentifier: identifier)
        }
    }
    
    public final func dequeueReusableCell<T where T: UITableViewCell>(cell: ReusableCell<T>, indexPath: NSIndexPath) -> T {
        guard let cell = dequeueReusableCellWithIdentifier(cell.identifier, forIndexPath: indexPath) as? T else {
            assertionFailure("type error how is this possible?")
            return T()
        }
        return cell
    }
}

public enum ReusableCell<Cell> {
    case Class(identifier: String)
    case Nib(identifier: String, nibName: String, bundle: NSBundle?)
    
    public var identifier: String {
        switch self {
        case .Class(let identifier):
            return identifier
        case .Nib(let identifier, _, _):
            return identifier
        }
    }
    
    public init(identifier: String) {
        self = .Class(identifier: identifier)
    }
    
    public init(identifier: String, nibName: String, bundle: NSBundle? = nil) {
        self = .Nib(identifier: identifier, nibName: nibName, bundle: bundle)
    }
}