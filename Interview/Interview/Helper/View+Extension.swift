//
//  View+Extension.swift
//  Interview
//
//  Created by Meet Goti on 09/08/24.
//

import Foundation
import SwiftUI
extension View {
    //// For Adding the placeholder to textfield
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
    
    
    func setHeight(_ height:CGFloat) -> some View {
        self.modifier(HeightModifier(height: height))
    }
    
    func setOverlay(_ view:any Shape) -> some View {
        self.modifier(OverlayModifier(overlayView: AnyView(view)))
    }
}

///`ViewModifier` for the set view height
struct HeightModifier:ViewModifier {
    var height:CGFloat = 50
    func body(content: Content) -> some View {
        return content.frame(height: height)
    }
    
}

///`ViewModifier` for  set overlay to the view
struct OverlayModifier:ViewModifier {
    var overlayView: AnyView
    func body(content: Content) -> some View {
        content.overlay {
            overlayView
        }
    }
    
}
