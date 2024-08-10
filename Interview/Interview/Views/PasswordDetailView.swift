//
//  PasswordDetailView.swift
//  Interview
//
//  Created by Meet Goti on 10/08/24.
//

import SwiftUI
enum AuthenticateFor {
case update,password
}
struct PasswordDetailView: View {
    @Binding var isHideDetailView:Bool
    @Binding var isHideUpdate:Bool
    @Binding var data:PasswordsInfo?
    @EnvironmentObject var manager:PasswordManager
    @State var showPassword:Bool = false
    @State var showFacePermissionAlert:Bool = false
    
    @State var authenticateFor:AuthenticateFor = .password
    @ObservedObject var authManager:AuthenticatorManager = AuthenticatorManager()
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                if let data {
                    VStack(alignment:.leading) {
                        Text("Account Details")
                            .font(.system(size: 20,weight: .semibold))
                            .foregroundStyle(Color(hex: "#3F7DE3"))
                        DetailSectionView(title: "Account Type", value: data.name)
                            .padding(.top,29.0)
                        DetailSectionView(title: "Username/ Email", value: data.userNameEmail)
                            .padding(.top,27.0)
                        HStack(alignment:.center) {
                            DetailSectionView(title: "Password", value: data.password,isSecure: !showPassword)
                                
                            Spacer()
                            Button(action: {
                                if (self.showPassword) {
                                    self.showPassword.toggle()
                                    return
                                }
                                
                                self.authenticateFor = .password
                                authManager.authenticate()
                            }, label: {
                                Image("ic_password_eye")
                                    .foregroundStyle(.white)
                            })
                            
                        }
                        .padding(.top,23.0)
                        .onChange(of: authManager.isAuthenticate) { oldValue, newValue in
                            if (newValue) {
                                switch authenticateFor {
                                case .update:
                                    self.isHideDetailView = true
                                    self.isHideUpdate = false
                                case .password:
                                    self.showPassword.toggle()
                                }
                                self.authManager.isAuthenticate = false
                            }
                           
                        }
                        HStack(spacing: 18) {
                            Button(action: {
                                self.authenticateFor = .update
                                authManager.authenticate()
                            }, label: {
                                Text("Update")
                                    .font(.system(size: 16,weight: .bold))
                                    .foregroundStyle(.white)
                            })
                            .frame(maxWidth: .infinity)
                            .frame( height: 44)
                            .modifier(RoundedBorderOverlay(borderWidth: 0.0, backColor: Color(hex: "#2C2C2C"), borderColor: .clear))
                            .padding(.top,11)
                            .shadow(color:.black.opacity(0.25),radius: 4,y:2)
                            Button(action: {
                                self.manager.removeData(data)
                                self.isHideDetailView = true
                            }, label: {
                                Text("Delete")
                                    .font(.system(size: 16,weight: .bold))
                                    .foregroundStyle(.white)
                            })
                            .frame(maxWidth: .infinity)
                            .frame( height: 44)
                            .modifier(RoundedBorderOverlay(borderWidth: 0.0, backColor: Color(hex: "#F04646"), borderColor: .clear))
                            .padding(.top,11)
                            .shadow(color:.black.opacity(0.25),radius: 4,y:2)
                        }
                    }
                    .padding(.top,35)
                    .padding(.horizontal,20)
                    .padding(.bottom,24)
                    .frame(maxWidth: .infinity,alignment: .leading)
                }
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color(hex: "#E3E3E3"))
                    .frame(width:46.0, height: 4.0)
                    .padding(8.0)
            }
            .frame(alignment: .top)
            .background {
                UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topLeading: 17.0,topTrailing: 17.0))
                    .fill(Color(hex: "#F9F9F9")).ignoresSafeArea()
            }
            .modifier(
                AlertModifier(isPresented: $authManager.showFacePermissionAlert, message: .constant(authenticateFor == .password ? AlertConstants.allowFaceForPassword : AlertConstants.allowFaceForUpdate) ,title: "Location Permission",buttonTitle: "Open Setting",callBack: {
                    self.authManager.showFacePermissionAlert = false
                    AppUtilities.openSetting()
                })
            )
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .bottom)
        .background(.clear)
        .onChange(of: isHideDetailView) { oldValue, newValue in
            if (newValue) {
                self.showPassword = false
            }
        }
    }
}

#Preview {
    PasswordDetailView(isHideDetailView: .constant(true), isHideUpdate: .constant(true), data: .constant(PasswordsInfo(name: "Facebook", userNameEmail: "Amitshah165@maill.com", password: "1234567")) )
}


struct DetailSectionView : View {
    var title:String
    var value:String
    var isSecure:Bool = false
    var body: some View {
        VStack(alignment:.leading,spacing:2) {
            Text(title)
                .font(.system(size: 11,weight: .medium))
                .foregroundStyle(Color(hex: "#CCCCCC"))
            Text(isSecure ? self.securedString : value)
                .font(.system(size: 16,weight: .semibold))
                .foregroundStyle(Color(hex: "#333333"))
        }
    }
    var securedString :String {
        let secured = value.map({$0})
        return secured.prefix(8).map({_ in return "*"}).joined()
    }
}
