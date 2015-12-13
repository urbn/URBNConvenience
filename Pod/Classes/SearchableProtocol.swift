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

struct UserActivityEligibility : OptionSetType {
    let rawValue : Int
    static let Search = UserActivityEligibility(rawValue: 1 << 1)
    static let Handoff = UserActivityEligibility(rawValue: 1 << 2)
    static let PublicIndexing = UserActivityEligibility(rawValue: 1 << 3)
}

protocol SearchInfoProvider {
    var userActivityEligibility: UserActivityEligibility { get }
    func searchURL() -> String
    func searchTitle() -> String
    func keywords() -> Set<String>
    func contentDescription() -> String
}

@available(iOS 9.0, *)
protocol Searchable {
    func configActivity(searchActivity: NSUserActivity, infoProvider: SearchInfoProvider) -> NSUserActivity
}

@available(iOS 9.0, *)
extension Searchable {
    func configActivity(searchActivity: NSUserActivity, infoProvider: SearchInfoProvider) -> NSUserActivity {
        searchActivity.title = infoProvider.searchTitle()
        searchActivity.webpageURL = NSURL(string: infoProvider.searchURL())
        searchActivity.keywords = infoProvider.keywords()
        searchActivity.contentAttributeSet = searchableAttributeSet(infoProvider)
        
        searchActivity.eligibleForSearch = infoProvider.userActivityEligibility.contains(.Search)
        searchActivity.eligibleForHandoff = infoProvider.userActivityEligibility.contains(.Handoff)
        searchActivity.eligibleForPublicIndexing = infoProvider.userActivityEligibility.contains(.PublicIndexing)
        
        searchActivity.becomeCurrent()
        
        return searchActivity
    }
    
    private func searchableAttributeSet(infoProvider: SearchInfoProvider) -> CSSearchableItemAttributeSet {
        let attributes = CSSearchableItemAttributeSet(itemContentType: kUTTypeItem as String)
        
        attributes.title = infoProvider.searchTitle()
        attributes.displayName = infoProvider.searchTitle()
        
        attributes.relatedUniqueIdentifier = infoProvider.searchURL()
        attributes.contentDescription = infoProvider.contentDescription()
        
        attributes.keywords = Array(infoProvider.keywords())
        
        return attributes
    }
}