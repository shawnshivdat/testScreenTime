//
//  Glorious_SurferApp.swift
//  Glorious Surfer
//
//  Created by Brian Seo on 2023-03-14.
//

import SwiftUI
import FamilyControls
import ManagedSettings

@main
struct Glorious_SurferApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    let center = AuthorizationCenter.shared
    @StateObject var model = Model.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
                .onAppear {
                    Task {
                        do {
                            try await center.requestAuthorization(for: .individual)
                        } catch {
                            print("Failed to authorized \(error.localizedDescription)")
                        }
//                        model.initiateMonitoring()
//                        print("selection to discourage")
//                        print(model.selectionToDiscourage)
                    }
                    let store = ManagedSettingsStore()

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
                }
        }
    }
}

