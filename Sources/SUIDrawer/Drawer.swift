//
//  Drawer.swift
//  SUIDrawer
//
//  Created by Michael Berk on 12/19/23.
//

import SwiftUI
@_spi(Advanced) import SwiftUIIntrospect

extension View {
	
	/// Presents a drawer when binding to a Boolean value that you provide is true
	/// - Parameters:
	///   - isPresented: A binding to a Boolean value that determines whether to present the drawer that you create in the modifier’s content closure.
	///   - preferredEdge: The drawer's preferred, or default, edge.
	///   - content: A closure that returns the content of the drawer
	public func drawer<Content>(isPresented: Binding<Bool>, preferredEdge: NSRectEdge = .maxX, @ViewBuilder content: () -> Content) -> some View where Content: View {
		self
			.modifier(DrawerViewModifier(showDrawer: isPresented, preferredEdge: preferredEdge, drawerContent: content))
	}
}

private struct DrawerViewModifier<DrawerContent: View>: ViewModifier {
	@State private var drawer: NSDrawer!
	@Weak private var window: NSWindow?
	@State private var dn: DrawerNotifier!
	@Binding var showDrawer: Bool
	@State var preferredEdge: NSRectEdge
	private let drawerContent: DrawerContent
	
	init(showDrawer: Binding<Bool>, preferredEdge: NSRectEdge = .maxX, @ViewBuilder drawerContent: () -> DrawerContent) {
		self.drawerContent = drawerContent()
		_showDrawer = showDrawer
		self._preferredEdge = .init(initialValue: preferredEdge)
		self.dn = DrawerNotifier(showDrawer: showDrawer)
	}
	
	func body(content: Content) -> some View {
		content
			.introspect(.window, on: .macOS(.v14), customize: { window in
				self.window = window
				
			})
			.onChange(of: showDrawer, { old, new in
				if new == old {return}
				if new {
					let host = NSHostingView(rootView: self.drawerContent)
					host.sizingOptions = .intrinsicContentSize
					drawer = NSDrawer(contentSize: .init(width: 200, height: window!.frame.size.height), preferredEdge: preferredEdge)
					drawer.contentView = host
					drawer.parentWindow = window
					drawer.open(on: preferredEdge)
				} else {
					drawer?.close()
				}
			})
	}
	
	///Simple class used to recieve notifications for the drawer opening/closing
	private class DrawerNotifier: NSObject, NSDrawerDelegate {
		var showDrawer: Binding<Bool>
		init(showDrawer: Binding<Bool>) {
			self.showDrawer = showDrawer
		}
		
		func drawerDidOpen(_ notification: Notification) {
			showDrawer.wrappedValue = false
		}
		
		func drawerDidClose(_ notification: Notification) {
			showDrawer.wrappedValue = false
		}
	}

}


