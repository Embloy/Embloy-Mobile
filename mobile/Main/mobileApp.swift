//
//  mobileApp.swift
//  mobile
//
//  Created by cb on 15.08.23.
//

import SwiftUI

@main
struct mobileApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        let errorHandlingManager = ErrorHandlingManager()
        let authenticationManager = AuthenticationManager(errorHandlingManager: errorHandlingManager)
        let jobManager = JobManager(authenticationManager: authenticationManager, errorHandlingManager: errorHandlingManager)
        let applicationManager = ApplicationManager(authenticationManager: authenticationManager, errorHandlingManager: errorHandlingManager)
        
        WindowGroup {
            ContentView()
            .environmentObject(errorHandlingManager)
            .environmentObject(authenticationManager)
            .environmentObject(jobManager)
            .environmentObject(applicationManager)
            .accentColor(Color("PrimaryColor"))
        }
    }
}
