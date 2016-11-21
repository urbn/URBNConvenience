//
//  NotificationConvenience.swift
//  Pods
//
//  Created by Ray Migneco on 11/3/16.
//
//

import Foundation


public extension NotificationCenter {
    
    public func post(notification: Notification, queue: DispatchQueue = DispatchQueue.main) -> Void {
        queue.async { [weak self] in
            self?.post(notification)
        }
    }
    
    // Needed for objc compatibility
    public func post(notification: Notification) -> Void {
        post(notification:notification, queue: DispatchQueue.main)
    }
    
    public func post(notificationName: Notification.Name, queue: DispatchQueue = DispatchQueue.main, object: Any? = nil, userInfo: [AnyHashable: Any]? = nil) -> Void {
        let note = Notification(name: notificationName, object: object, userInfo: userInfo)
        post(notification: note, queue: queue)
    }
    
    public func post(name: String, queue: DispatchQueue = DispatchQueue.main, object: Any? = nil, userInfo: [AnyHashable: Any]? = nil) -> Void {
        post(notificationName: Notification.Name(rawValue: name), queue: queue, object: object, userInfo: userInfo)
    }
}
