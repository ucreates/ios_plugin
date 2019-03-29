// ======================================================================
// Project Name    : ios_foundation
//
// Copyright © 2019 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
// ======================================================================
import Firebase
import FirebaseInstanceID
import Foundation
import UIKit
import UserNotifications
public class FCMNotifierPlugin: NSObject, UNUserNotificationCenterDelegate, MessagingDelegate {
    fileprivate static var instance: FCMNotifierPlugin?
    public override init() {}
    public static func getInstance() -> FCMNotifierPlugin! {
        if (FCMNotifierPlugin.instance == nil) {
            FCMNotifierPlugin.instance = FCMNotifierPlugin()
        }
        return FCMNotifierPlugin.instance!
    }
    open func regist() -> Void {
        FirebaseApp.configure()
        let messaging: Messaging = Messaging.messaging()
        let notificationCenter: NotificationCenter = NotificationCenter.default
        messaging.delegate = self
        notificationCenter.addObserver(self, selector: #selector(self.tokenRefreshNotification), name: NSNotification.Name.InstanceIDTokenRefresh, object: nil)
        if #available(iOS 10.0, *) {
            func callback(granted: Bool, error: Error?) -> Void {
                if (granted == false) {
                    return
                }
                if (error != nil) {
                    NSLog(error.debugDescription)
                } else {
                    let firInstance: InstanceID = InstanceID.instanceID()
                    let fcmToken: String? = firInstance.token()
                    let app: UIApplication = UIApplication.shared
                    app.registerForRemoteNotifications()
                    NSLog(String(format: "fcmToken::%@", arguments: [fcmToken!]))
                }
                return
            }
            let userNotificationCenter: UNUserNotificationCenter = UNUserNotificationCenter.current()
            userNotificationCenter.delegate = self
            userNotificationCenter.requestAuthorization(options: [.alert, .badge, .sound], completionHandler: callback)
        } else {
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            let app: UIApplication = UIApplication.shared
            app.registerUserNotificationSettings(settings)
        }
        return
    }
    @objc
    open func tokenRefreshNotification(_ notification: Notification) -> Void {
        let firInstance: InstanceID = InstanceID.instanceID()
        let messaging: Messaging = Messaging.messaging()
        let fcmToken: String? = firInstance.token()
        if (fcmToken == nil) {
            NSLog("fcmToken is null")
            return
        }
        func callback(error: Error?) -> Void {
            if (error != nil) {
                NSLog(error.debugDescription)
            } else {
                NSLog("success connect to fcm")
            }
            return
        }
        messaging.disconnect()
        messaging.connect(handler: callback)
        NSLog("fcmToken::" + firInstance.token()!)
        return
    }
    public func applicationReceivedRemoteMessage(_ remoteMessage: MessagingRemoteMessage) -> Void {
        NSLog("Received data message: \(remoteMessage.appData)")
        return
    }
    open func reset() -> Void {
        let app: UIApplication = UIApplication.shared
        app.applicationIconBadgeNumber = 0
        return
    }
    @available(iOS 10.0, *)
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        NSLog("execute fcm notification.")
        self.reset()
        completionHandler([.alert, .badge, .sound])
        return
    }
    @available(iOS 10.0, *)
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Swift.Void) {
        NSLog("press fcm notification message in notify area.")
        self.reset()
        completionHandler()
        return
    }
}
