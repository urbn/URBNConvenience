//
//  SearchableProtocol.swift
//  Pods
//
//  Created by Nick DiStefano on 12/11/15.
//
//

import Foundation

enum SearchableElegibility {
    case SearchHandoff
    case SearchHandoffPublicIndexing
    
    func eligibleForSearch() -> Bool {
        return true
    }
    
    func elegibleForHandoff() -> Bool {
        return true
    }
    
    func elegibleForPublicIndexing() -> Bool {
        switch self {
        case .SearchHandoff: return false
        case .SearchHandoffPublicIndexing: return true
        }
    }
}

@available(iOS 9.0, *)
protocol Searchable {
    func searchURL() -> String
    func searchTitle() -> String
    func keywords() -> Set<String>
    func contentDescription() -> String
    func configActivity(searchActivity: NSUserActivity, elegibility: SearchableElegibility) -> NSUserActivity
}

@available(iOS 9.0, *)
extension Searchable {
    func configActivity(searchActivity: NSUserActivity, elegibility: SearchableElegibility) -> NSUserActivity {
        searchActivity.title = searchTitle()
        searchActivity.webpageURL = NSURL(string: searchURL())
        searchActivity.keywords = keywords()
        searchActivity.contentAttributeSet = searchableAttributeSet()
        
        searchActivity.eligibleForSearch = elegibility.eligibleForSearch()
        searchActivity.eligibleForHandoff = elegibility.elegibleForHandoff()
        searchActivity.eligibleForPublicIndexing = elegibility.elegibleForPublicIndexing()
        
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