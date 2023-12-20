//
//  CoolSUIView.swift
//  OldMacStuff
//
//  Created by Michael Berk on 12/18/23.
//


import SwiftUI
import Charts

@Observable
class CoolSUIViewModel {
	var toggleVal = false
	var text1 = ""
	var text2 = ""
}

struct CoolSUIView: View {
	
	@State var model: CoolSUIViewModel
	
	struct ValuePerCategory {
		var category: String
		var value: Double
	}

	let data: [ValuePerCategory] = [
		.init(category: "A", value: 5),
		.init(category: "B", value: 9),
		.init(category: "C", value: 7)
	]
	
    var body: some View {
		VStack {
			Form {
				Section {
					Toggle("Toggle 1", isOn: $model.toggleVal)
					TextField("Text 1", text: $model.text1, prompt: Text("Text 1"))
				}
				Section {
					TextField("Text 2", text: $model.text2, prompt: Text("Text 2"))
				}
				
			}
			.formStyle(.grouped)
			VStack {
				Text("Yes, this is a SwiftUI view running in an NSDrawer")
					.foregroundStyle(.secondary)
				Chart(data, id: \.category) { item in
					BarMark(
						x: .value("Category", item.category),
						y: .value("Value", item.value)
					)
				}
			}
		}
		.background()
    }
}

#Preview {
	CoolSUIView(model: .init())
}
