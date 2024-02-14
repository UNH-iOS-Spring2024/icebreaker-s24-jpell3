//
//  Icebreaker_Pelletier_S24App.swift
//  Icebreaker-Pelletier-S24
//
//  Created by Justin Pelletier on 2/6/24.
//

import SwiftUI
import Firebase

@main
struct Icebreaker_Pelletier_S24App: App {
	
	init() {
		let providerFactory = AppCheckDebugProviderFactory()
		AppCheck.setAppCheckProviderFactory(providerFactory)
		FirebaseApp.configure()
	}
	
	var body: some Scene {
		WindowGroup {
				ContentView()
		}
	}
}
