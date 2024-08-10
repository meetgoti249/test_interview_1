//
//  PasswordRow.swift
//  Interview
//
//  Created by Meet Goti on 09/08/24.
//

import SwiftUI
//MARK: View for the password element.
struct PasswordRow: View {
    @ObservedObject var password:PasswordsInfo
    
    var body: some View {
        HStack(alignment: .center,spacing: 12) {
            Text(password.name)
                .foregroundStyle(Color(hex: "#333333"))
                .lineLimit(1)
            
            Text("*******")
                .foregroundStyle(Color(hex: "#C6C6C6"))
                .padding(.top,5)
            
            Spacer()
            Image("ic_right_arrow")
            
        }
        .frame(height: 66.19)
        .font(.system(size: 20,weight: .semibold))
        .padding(.leading,25.0)
        .padding(.trailing,20.0)
        .frame(maxWidth: .infinity,alignment: .leading)
        .presentationCornerRadius(20)
        .modifier(RoundedBorderOverlay(borderWidth: 1, backColor: .white, borderColor: Color(hex: "#EDEDED")))
    }
}

#Preview {
    PasswordRow(password: PasswordsInfo(name: "123", userNameEmail: "", password: ""))
}

///`ViewModifier` for showing the border along with corner radius.
struct RoundedBorderOverlay:ViewModifier {
    var borderWidth:CGFloat
    var backColor:Color
    var borderColor:Color
    func body(content:Content) -> some View {
        
        content
            .background {
                GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: geometry.size.height / 2)
                    //                        .stroke(style: .init(lineWidth: 1))
                        .fill(backColor)
                        .overlay {
                            RoundedRectangle(cornerRadius: geometry.size.height / 2)
                                .stroke(lineWidth: 1.0)
                                .foregroundStyle(borderColor)
                        }
                    //                        .foregroundStyle(borderColor)
                }
            }
    }
}
