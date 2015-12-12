//
//  SearchableProtocol.swift
//  ANT
//
//  Created by Nick DiStefano on 12/10/15.
//  Copyright © 2015 Urban Outfitters. All rights reserved.
//

import Foundation

struct UserActivityEligibility : OptionSetType {
    let rawValue : Int
    static let Search = UserActivityEligibility(rawValue: 1 << 1)
    static let Handoff = UserActivityEligibility(rawValue: 1 << 2)
    static let PublicIndexing = UserActivityEligibility(rawValue: 1 << 3)
}

@available(iOS 9.0, *)
protocol Searchable {
    func searchURL() -> String
    func searchTitle() -> String
    func keywords() -> Set<String>
    func contentDescription() -> String
    func configActivity(searchActivity: NSUserActivity, eligibilityOptions: UserActivityEligibility) -> NSUserActivity
}

@available(iOS 9.0, *)
extension Searchable {
    func configActivity(searchActivity: NSUserActivity, eligibilityOptions: UserActivityEligibility) -> NSUserActivity {
        searchActivity.title = searchTitle()
        searchActivity.webpageURL = NSURL(string: searchURL())
        searchActivity.keywords = keywords()
        searchActivity.contentAttributeSet = searchableAttributeSet()
        
        searchActivity.eligibleForSearch = eligibilityOptions.contains(.Search)
        searchActivity.eligibleForHandoff = eligibilityOptions.contains(.Handoff)
        searchActivity.eligibleForPublicIndexing = eligibilityOptions.contains(.PublicIndexing)
        
        searchActivity.becomeCurrent()
        
        return searchActivity
    }
    
    private func searchableAttributeSet() -> CSSearchableItemAttributeSet {
        let attributes = CSSearchableItemAttributeSet(itemContentType: kUTTypeItem as String)
        
        attributes.title = searchTitle()
        attributes.displayName = searchTitle()
        
        attributes.relatedUniqueIdentifier = searchURL()
        attributes.contentDescription = contentDescription()
        
        attributes.keywords = Array(keywords())
        
        return attributes
    }
}