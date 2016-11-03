//
//  NotificationConvenience.swift
//  Pods
//
//  Created by Ray Migneco on 11/3/16.
//
//

import Foundation


public extension NotificationCenter {
    
    public func post(notification: Notification, onMainQueue mainQueue: Bool) -> Void {
        func postNote() {
            post(notification)
        }
        
        mainQueue ? DispatchQueue.main.async { postNote() } : postNote()
    }
    
    public func post(notificationName: String, onMainQueue mainQueue: Bool, object: Any? = nil, userInfo: [AnyHashable: Any]? = nil) -> Void {
        let note = Notification(name: Notification.Name(rawValue: notificationName), object: object, userInfo: userInfo)
        post(notification: note, onMainQueue: mainQueue)
    }
}
