//
//  SUIDrawerSampleApp.swift
//  SUIDrawerSample
//
//  Created by Michael Berk on 12/19/23.
//

import SwiftUI

@main
struct SUIDrawerSampleApp: App {
	@State var showDrawer = false
	
	var body: some Scene {
		WindowGroup {
			ContentView(showDrawer: $showDrawer)
		}
		.defaultSize(width: 300, height: 300)
	}
}
