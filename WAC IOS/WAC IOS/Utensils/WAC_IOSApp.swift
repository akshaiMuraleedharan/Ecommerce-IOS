//
//  WAC_IOSApp.swift
//  WAC IOS
//
//  Created by Subhosting's MacBook Pro on 17/08/24.
//

import SwiftUI

@main
struct WAC_IOSApp: App {
    init() {
        // Customize the tab bar appearance
        /*let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        
        let selectedItemAppearance = UITabBarItemAppearance()
        selectedItemAppearance.normal.iconColor = .gray
        selectedItemAppearance.selected.iconColor = .white
        
        tabBarAppearance.stackedLayoutAppearance = selectedItemAppearance
        tabBarAppearance.inlineLayoutAppearance = selectedItemAppearance
        tabBarAppearance.compactInlineLayoutAppearance = selectedItemAppearance
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance*/
        
        // Customize the navigation bar appearance
        let navAppearance = UINavigationBarAppearance()
        navAppearance.backgroundColor = UIColor(named: "greenColor")
        
        UINavigationBar.appearance().standardAppearance = navAppearance
        UINavigationBar.appearance().compactAppearance = navAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
        UINavigationBar.appearance().isTranslucent = false
    }
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                DashboardView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
