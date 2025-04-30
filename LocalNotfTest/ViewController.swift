//
//  ViewController.swift
//  LocalNotfTest
//
//  Created by Drasko Vucenovic on 2025-04-30.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        UNUserNotificationCenter.current().delegate = self //Set self as delegate so you can receive UNUserNotificationCenterDelegate delegate callbacks

    }

    ///Trigger a push notification after 2 seconds
    ///Notification should arrive whether app is in foreground or background
    @IBAction func btnClicked(_ sender: Any) {
        
        let content = UNMutableNotificationContent()
        content.title = "Hello"
        content.body = "This is a test notification"
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error adding notification: \(error)")
            }
        }
    }
    
    /// Request push notifiation permissions
    @IBAction func permissionsClicked(_ sender: Any) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted.")
            } else {
                print("Notification permission denied.")
            }
        }
    }
    
    //MARK: - UNUserNotificationCenterDelegate
    
    // Show notification even when app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound]) // or .alert for older iOS styles
    }
    
}

