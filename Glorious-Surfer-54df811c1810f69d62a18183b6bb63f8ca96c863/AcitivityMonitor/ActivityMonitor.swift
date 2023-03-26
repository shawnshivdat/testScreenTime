////
////  ActivityMonitor.swift
////  Glorious Surfer
////
////  Created by Brian Seo on 2023-03-15.
////
//
//import Foundation
//import UIKit
//import SwiftUI
//import MobileCoreServices
//import DeviceActivity
//import ManagedSettings
//
//let placeHolder = "https://www."
//
//class ActivityMonitor: DeviceActivityMonitor {
//    override func intervalDidStart(for activity: DeviceActivityName) {
//        print("interval did start")
//        super.intervalDidStart(for: activity)
//        let model = Model.shared
//        print("SETTING SHIELD RESTRICTIONS")
//        model.setShieldRestrictions()
//    }
//    
//    override func intervalDidEnd(for activity: DeviceActivityName) {
//        print("interval did end")
//        print(activity)
//        super.intervalDidEnd(for: activity)
//        let model = Model.shared
//        print("TURNING OFF SHIELD RESTRICTIONS")
//        model.store.shield.applications = nil
//        model.store.dateAndTime.requireAutomaticDateAndTime = false
//    }
//}
//
////        let applications = model.selectionToDiscourage.applicationTokens
////        model.store.shield.applications = applications
////        for customURL in model.customURLstoBLock {
////            model.store.shield.webDomains?.insert(token)
////        }
