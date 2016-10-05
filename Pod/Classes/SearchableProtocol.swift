//
//  SearchableProtocol.swift
//  ANT
//
//  Created by Nick DiStefano on 12/10/15.
//  Copyright © 2015 Urban Outfitters. All rights reserved.
//

import Foundation
import CoreSpotlight
import MobileCoreServices

public struct UserActivityEligibility : OptionSet {
    public init(rawValue:Int) { self.rawValue = rawValue}
    public let rawValue : Int
    public static let Search = UserActivityEligibility(rawValue: 1 << 1)
    public static let Handoff = UserActivityEligibility(rawValue: 1 << 2)
    public static let PublicIndexing = UserActivityEligibility(rawValue: 1 << 3)
}

public protocol SearchInfoProvider {
    var userActivityEligibility: UserActivityEligibility { get }
    func searchURL() -> String
    func searchTitle() -> String
    func keywords() -> Set<String>
    func contentDescription() -> String
}

@available(iOS 9.0, *)
public protocol Searchable {
    func configureActivity(_ searchActivity: NSUserActivity, infoProvider: SearchInfoProvider) -> NSUserActivity
}

#if !os(tvOS)
@available(iOS 9.0, *)
public extension Searchable {
    public func configureActivity(_ searchActivity: NSUserActivity, infoProvider: SearchInfoProvider) -> NSUserActivity {
        searchActivity.title = infoProvider.searchTitle()
        searchActivity.webpageURL = URL(string: infoProvider.searchURL())
        searchActivity.keywords = infoProvider.keywords()
        searchActivity.contentAttributeSet = searchableAttributeSet(infoProvider)
        
        searchActivity.isEligibleForSearch = infoProvider.userActivityEligibility.contains(.Search)
        searchActivity.isEligibleForHandoff = infoProvider.userActivityEligibility.contains(.Handoff)
        searchActivity.isEligibleForPublicIndexing = infoProvider.userActivityEligibility.contains(.PublicIndexing)
        
        return searchActivity
    }
    
    fileprivate func searchableAttributeSet(_ infoProvider: SearchInfoProvider) -> CSSearchableItemAttributeSet {
        let attributes = CSSearchableItemAttributeSet(itemContentType: kUTTypeItem as String)
        
        attributes.title = infoProvider.searchTitle()
        attributes.displayName = infoProvider.searchTitle()
        
        attributes.relatedUniqueIdentifier = infoProvider.searchURL()
        attributes.contentDescription = infoProvider.contentDescription()
        
        attributes.keywords = Array(infoProvider.keywords())
        
        return attributes
    }
}
#endif
