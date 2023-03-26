//
//  ContentView.swift
//  Glorious Surfer
//
//  Created by Brian Seo on 2023-03-14.
//

import SwiftUI
import FamilyControls
import ManagedSettings

struct ContentView: View {
    @State private var showDiscouragedAppsPicker = false
    
    @State private var isAdultFilterOn = false {
        didSet {
            model.adultFilterToggled()
        }
    }
    @State private var isDatingFilterOn = false
    @State private var isDrugFilterOn = false
    
    @EnvironmentObject var model: Model
    
    var body: some View {
        TabView {
            CustomBlockListView(model: _model)
                .tabItem {
                    Label("Custom", systemImage: "")
                }
            
            VStack(spacing: 35.0) {
                Button(action: {
                    showDiscouragedAppsPicker = true
                }, label: {
                    VStack {
                        Image(systemName: "xmark.shield.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.red)
                        
                        Text("Select Apps to Discourage")
                            .font(.title2)
                            .foregroundColor(.primary)
                            .scaledToFill()
                    }
                    .padding()
                    .frame(width: 270.0, height: 130.0)
                    .background(.orange)
                    .cornerRadius(15.0)
                    .toolbarColorScheme(.light, for: .tabBar)
                })
                .familyActivityPicker(isPresented: $showDiscouragedAppsPicker, selection: $model.selectionToDiscourage)
//                .onChange(of: model.selectionToDiscourage) { newValue in
//                    print("selection to discourage")
//                    print(model.selectionToDiscourage)
////                    model.initiateMonitoring()
//                }
                
                Button(action: {
                    let model = Model.shared
                    
                    let applications = model.selectionToDiscourage.applicationTokens
                    let categories = model.selectionToDiscourage.categoryTokens
                    let webCategories = model.selectionToDiscourage.webDomainTokens
                    
                    let store = ManagedSettingsStore()

                    if applications.isEmpty {
                     print("No applications to restrict")
                    } else {
                        print("Found applications to restrict")
                     store.shield.applications = applications
                    }
                    
                    if categories.isEmpty {
                     print("No categories to restrict")
                    } else {
                        print("Found categories to restrict")
                     store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.specific(categories, except: Set())
                    }
//                    
                    if webCategories.isEmpty {
                     print("No web categories to restrict")
                    } else {
                        print("Found web categories to restrict")

                     store.shield.webDomains = webCategories
                    }
                }) {
                    Text("Restrict the selected apps")
                }
                
                Button(action: {
                    let store = ManagedSettingsStore()

                    store.shield.applications = nil
                    store.shield.applicationCategories = nil
                    store.shield.webDomains = nil
                    store.shield.webDomainCategories = nil
                }) {
                    Text("Unrestrict the apps")
                }
                
                
                Toggle(isOn: $isAdultFilterOn) {
                    Label("Adult", systemImage: "19.circle.fill")
                        .foregroundColor(.red)
                }
                .padding(.horizontal)
                
                Toggle(isOn: $isDrugFilterOn) {
                    Label("Drug", systemImage: "pills.circle.fill")
                        .foregroundColor(.green)
                }
                .padding(.horizontal)
                
                Toggle(isOn: $isDatingFilterOn) {
                    Label("Dating", systemImage: "heart.circle.fill")
                        .foregroundColor(.red)
                }
                .padding(.horizontal)

            }
            .tabItem {
                Label("Set Not Allowed Apps", systemImage: "xmark.shield.fill")
                    .font(.title3)
            }
            
            
            
            SettingView()
                .tabItem {
                    Label("Setting", systemImage: "gear.circle.fill")
                }
        }
        .accentColor(.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Model.shared)
    }
}
