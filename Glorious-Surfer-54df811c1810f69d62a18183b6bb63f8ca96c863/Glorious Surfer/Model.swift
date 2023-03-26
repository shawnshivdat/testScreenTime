//
//  Model.swift
//  Glorious Surfer
//
//  Created by Brian Seo on 2023-03-15.
//

import Foundation
import FamilyControls
import DeviceActivity
import ManagedSettings

class Model: ObservableObject {
    
    static let shared: Model = Model()
    let store = ManagedSettingsStore()
    
    private init() {}
    
    var selectionToDiscourage = FamilyActivitySelection()
    {
      willSet {
        let applications = newValue.applicationTokens
        let categories = newValue.categoryTokens
        let webCategories = newValue.webDomainTokens
//          print("selection to discourage")
//          print(selectionToDiscourage)
          self.initiateMonitoring()
//        store.shield.applications = applications.isEmpty ? nil : applications
//        store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.specific(categories, except: Set())
//        store.shield.webDomains = webCategories
       }
    }
        
    // Change this line later! (should have no default custom list.)
    @Published var customDomainsToBlock: [WebDomain] = [].compactMap { domain in
        WebDomain(domain: domain)
    } {
        didSet {
            print(customDomainsToBlock)
        }
    }
    
    func unblock() {
        store.webContent.blockedByFilter = WebContentSettings.FilterPolicy.none
    }
    
    func adultFilterToggled() {
        if store.webContent.blockedByFilter == .auto() {
            store.webContent.blockedByFilter = WebContentSettings.FilterPolicy.none
        } else {
            store.webContent.blockedByFilter = .auto()
        }
    }

    func initiateMonitoring() {
        print("initiate monitoring called")
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
        
        print("Making schedule...")
        let schedule = DeviceActivitySchedule(intervalStart: DateComponents(hour: 16, minute: 44), intervalEnd: DateComponents(hour: 23, minute: 59), repeats: true)
                
        print("interval start: ", schedule.intervalStart)
        print("interval end: ", schedule.intervalEnd)

        let center = DeviceActivityCenter()
        
        do {
            print("Calling start monitoring...")
            print("SELECTION TO DISCOURAGE: ")
            print(selectionToDiscourage)
            try center.startMonitoring(.daily, during: schedule)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addToBlockList(url: String) {
        let domain = WebDomain(domain: url)
        customDomainsToBlock.append(domain)
        guard let token = domain.token else { return }
        store.shield.webDomains?.insert(token)
    }
}

extension DeviceActivityName {
    static let daily = Self("daily")
}

extension DeviceActivityEvent.Name {
    static let discouraged = Self("discouraged")
}
