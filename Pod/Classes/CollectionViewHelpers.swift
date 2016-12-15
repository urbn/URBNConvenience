//
//  CollectionViewHelpers.swift
//  Pods
//
//  Created by Jason Grandelli on 12/6/16.
//
//

import Foundation

extension UICollectionView {
    public final func registerReusableCell<T>(_ cell: ReusableCell<T>) where T: UICollectionViewCell {
        switch cell {
        case .class(let identifier):
            self.register(T.self, forCellWithReuseIdentifier: identifier)
        case .nib(let identifier, let nibName, let bundle):
            let nib = UINib(nibName: nibName, bundle: bundle)
            register(nib, forCellWithReuseIdentifier: identifier)
        }
    }
    
    public final func dequeueReusableCell<T>(_ cell: ReusableCell<T>, indexPath: IndexPath) -> T where T: UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cell.identifier, for: indexPath) as? T else {
            assert(false, "type error how is this possible?")
            return T()
        }

        return cell
    }
}
