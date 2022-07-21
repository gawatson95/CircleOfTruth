//
//  CircleOfTruthApp.swift
//  CircleOfTruth
//
//  Created by Grant Watson on 5/27/22.
//

import SwiftUI

@main
struct CircleOfTruthApp: App {
    
    @StateObject private var vm = HomeVM()
    @State private var showLaunchView: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if showLaunchView {
                    LaunchView(showLaunchView: $showLaunchView)
                        .transition(.move(edge: .top))
                } else {
                    HomeView()
                        .environmentObject(vm)
                }
            }
        }
    }
}
