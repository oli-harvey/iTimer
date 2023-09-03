//
//  iTimerApp.swift
//  iTimer
//
//  Created by Oliver Harvey on 13/08/2023.
//

import SwiftUI

@main
struct iTimerApp: App {
    @StateObject private var timerConfigStorage = TimerConfigStorage()
    
    var body: some Scene {
        WindowGroup {
            TimerSelectorView()
                .environmentObject(timerConfigStorage)
        }
    }
}
