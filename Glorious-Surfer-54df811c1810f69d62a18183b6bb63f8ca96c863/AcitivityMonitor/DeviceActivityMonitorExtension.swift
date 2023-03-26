//
//  DeviceActivityMonitorExtension.swift
//  AcitivityMonitor
//
//  Created by Brian Seo on 2023-03-15.
//
import Foundation
import DeviceActivity
import OSLog
import ManagedSettings

// Optionally override any of the functions below.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class DeviceActivityMonitorExtension: DeviceActivityMonitor {
    
    let store = ManagedSettingsStore()
    let model = Model.shared
    
    override func intervalDidStart(for activity: DeviceActivityName) {
        // Handle the start of the interval.

        super.intervalDidStart(for: activity)

        
        let applications = model.selectionToDiscourage.applicationTokens
        let categories = model.selectionToDiscourage.categoryTokens
        let webCategories = model.selectionToDiscourage.webDomainTokens
        
        if applications.isEmpty {
         print("No applications to restrict")
//        store.appStore.maximumRating = 200
        } else {
         store.shield.applications = applications
        }
        
        if categories.isEmpty {
         print("No categories to restrict")
//            store.appStore.maximumRating = 200
        } else {
         store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.specific(categories, except: Set())
        }
        
        if webCategories.isEmpty {
         print("No web categories to restrict")
        } else {
         store.shield.webDomains = webCategories
        }
        
//        store.dateAndTime.requireAutomaticDateAndTime = true
//        store.account.lockAccounts = true
//        store.passcode.lockPasscode = true
//        store.siri.denySiri = true
//        store.appStore.denyInAppPurchases = true
//        store.appStore.maximumRating = 200
//        store.appStore.requirePasswordForPurchases = true
//        store.media.denyExplicitContent = true
//        store.gameCenter.denyMultiplayerGaming = true
//        store.media.denyMusicService = false
//        store.application.denyAppInstallation = true
    }
    
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        print("INTERVAL DID END")
        

        store.shield.applications = nil
        store.shield.applicationCategories = nil
        store.shield.webDomains = nil
        store.shield.webDomainCategories = nil
        store.dateAndTime.requireAutomaticDateAndTime = nil
        store.account.lockAccounts = nil
        store.passcode.lockPasscode = nil
        store.siri.denySiri = nil
        store.appStore.denyInAppPurchases = nil
        store.appStore.maximumRating = nil
        store.appStore.requirePasswordForPurchases = nil
        store.media.denyExplicitContent = nil
        store.gameCenter.denyMultiplayerGaming = nil
        store.media.denyMusicService = nil
        store.application.denyAppInstallation = nil
        // Handle the end of the interval.
    }
    
    override func eventDidReachThreshold(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventDidReachThreshold(event, activity: activity)
        
        // Handle the event reaching its threshold.
    }
    
    override func intervalWillStartWarning(for activity: DeviceActivityName) {
        super.intervalWillStartWarning(for: activity)
        
        // Handle the warning before the interval starts.
    }
    
    override func intervalWillEndWarning(for activity: DeviceActivityName) {
        super.intervalWillEndWarning(for: activity)
        
        // Handle the warning before the interval ends.
    }
    
    override func eventWillReachThresholdWarning(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventWillReachThresholdWarning(event, activity: activity)
        
        // Handle the warning before the event reaches its threshold.
    }
}
