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
    
    public func post(notificationName: Notification.Name, queue: DispatchQueue = DispatchQueue.main, object: Any? = nil, userInfo: [AnyHashable: Any]? = nil) -> Void {
        let note = Notification(name: notificationName, object: object, userInfo: userInfo)
        post(notification: note, queue: queue)
    }
    
    public func post(notificationName: String, queue: DispatchQueue = DispatchQueue.main, object: Any? = nil, userInfo: [AnyHashable: Any]? = nil) -> Void {
        let note = Notification(name: Notification.Name(rawValue: notificationName), object: object, userInfo: userInfo)
        post(notification: note, queue: queue)
    }
}
