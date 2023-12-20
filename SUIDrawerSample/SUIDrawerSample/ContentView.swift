//
//  ContentView.swift
//  SUIDrawer
//
//  Created by Michael Berk on 12/19/23.
//

import SwiftUI
import SUIDrawer

struct ContentView: View {
	@Binding var showDrawer: Bool
	@State var coolModel: CoolSUIViewModel = .init()
	
    var body: some View {
        Form {
			Toggle("Show Drawer", isOn: $showDrawer)
				.controlSize(.large)
				.toggleStyle(.switch)
        }
		.formStyle(.grouped)
		.drawer(isPresented: $showDrawer, preferredEdge: .maxX) {
			CoolSUIView(model: coolModel)
		}
    }
}

#Preview {
	@State var showDrawer = false
    return ContentView(showDrawer: $showDrawer)
}
