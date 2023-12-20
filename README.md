# SUIDrawer

A package that enables use of the deprecated `NSDrawer` API with SwiftUI. Yes, really.

<img src="https://github.com/MichaelJBerk/SUIDrawer/blob/main/Sample.png">

> [!CAUTION]
> It should go without saying, but _please_ don't use this in production. `NSDrawer` has been deprecated since macOS 10.13 (before SwiftUI was introduced!), and it's anyone's guess how much longer it will be around.  

## Usage

If you're _dying_ to use `NSDrawer` in your SwiftUI App, just use the `.drawer` modifier. 
The snippet below creates the window you see above.  

```swift
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

```
## Limitations
 - Drawer is a fixed width of 300
 - Requires macOS 14 or later, due to the use of `@Observable`
