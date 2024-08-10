//
//  Common.swift
//  Interview
//
//  Created by Meet Goti on 10/08/24.
//

import Foundation
import SwiftUI

struct CustomTextFieldView: View {
    @Binding var text :String
    @State var placeHolder :String
    @State var inputType :UIKeyboardType = .default
    @State var alignment :TextAlignment = .leading
    @State var maxLength :Int = 50
//    var isPasswordFiled:Bool = falses
    var validationRule:[AllowCharacters]
    var body: some View {
        HStack(spacing: 0) {
            TextField(placeHolder, text: $text, onCommit: {
                
                print("DSDSDD")
            })
            //                .frame(height: height)
                .foregroundStyle(Color(hex: "#000000"))
                .placeholder(when: text.isEmpty) {
                    Text(placeHolder)
                        .font(.system(size: 13,weight: .medium))
                        .foregroundStyle(.clear)
                }
                .padding(.leading,10)
                .font(.system(size: 13,weight: .medium))
                .autocorrectionDisabled()
                .textContentType(.none)
                .keyboardType(inputType)
            
        }
        .setHeight(45)
        .setOverlay(
            RoundedRectangle(cornerRadius: 6).stroke(style: .init(lineWidth: 0.6))
        )
        .foregroundStyle(Color(hex: "#CBCBCB"))
    }
    
}

struct CustomSecureTextFieldView: View {
    @Binding var textString : String
    
    @State var placeHolder :String
    @FocusState var messageTxtFocused : Bool
    var suffixView :AnyView?
    var hasEye:Bool = false
    
    var body: some View {
        SecureField(placeHolder, text: $textString)
            .foregroundStyle(Color(hex: "#000000"))
            .placeholder(when: textString.isEmpty) {
                Text(placeHolder)
                    .font(.system(size: 13,weight: .medium))
                    .foregroundStyle(.clear)
            }
            .padding(.leading,10)
            .font(.system(size: 13,weight: .medium))
            .modifier(TextFieldSuffixModifier(view: suffixView))
            .focused($messageTxtFocused)
            .autocorrectionDisabled()
            .setHeight(45)
            .setOverlay(
                RoundedRectangle(cornerRadius: 6).stroke(style: .init(lineWidth: 0.6))
            )
            .foregroundStyle(Color(hex: "#CBCBCB"))
    }
    
}
struct TextFieldSuffixModifier: ViewModifier {
    var view:AnyView?
    func body(content: Content) -> some View {
        HStack(spacing: 5){
            content
            view
        }.padding(.trailing,10)
    }
    
}
