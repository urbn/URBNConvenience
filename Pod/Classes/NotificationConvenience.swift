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
        func post() {
            post(notification)
        }
        
        mainQueue ? DispatchQueue.main.async { post() } : post()
    }
    
    public func post(notificationName: String, onMainQueue mainQueue: Bool, object: Any? = nil, userInfo: [AnyHashable: Any]? = nil) -> Void {
        
        let note = Notification(name: Notification.Name(rawValue: notificaitonName), object: object, userInfo: info)
        post(notification: note, onMainQueue: mainQueue)
    }
}
