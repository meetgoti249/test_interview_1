//
//  AddPasswordView.swift
//  Interview
//
//  Created by Meet Goti on 09/08/24.
//

import SwiftUI
import Combine

//MARK: Add password model view
struct AddPasswordView: View {
    /// `PasswordManager` is the get from its parent view
    @EnvironmentObject var manager:PasswordManager

    /// `passwordData` is for intital value of the Password
    @State var passwordData : PasswordsInfo = PasswordsInfo(name: "", userNameEmail: "", password: "")
    
    /// `isShowAlert` is for show the validation alert on the screen
    @Binding var isShowAlert : Bool
    
    /// `isAddHide` is flag for show/hide the password form view.
    @Binding var isAddHide : Bool
    
    /// `editableData` is for set the edit inital value of the Password
    @Binding var editableData : PasswordsInfo?

    var isForUpdate : Bool = false
    
    @State var systemGeneratedPassword :String = String(AppUtilities.randomStringWithLength(len: 16))
    @State var isSelectGeneratedPassword :Bool = false
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                VStack(spacing:22.0) {
                    
                    ///Add password elements
                    CustomTextFieldView(text: $passwordData.name, placeHolder: "Account Name", maxLength: 15, validationRule: [.name])
                    
                    CustomTextFieldView(text: $passwordData.userNameEmail, placeHolder: "Username/ Email", inputType: .emailAddress,validationRule: [.userName,.email])
                    
                    CustomTextFieldView(text: $passwordData.password, placeHolder: "Password", validationRule: [.password])
                        .disabled(self.isSelectGeneratedPassword)
                        .opacity(self.isSelectGeneratedPassword ? 0.5 : 1.0)
                    
                    if (!self.isForUpdate) {
                        HStack(spacing: 10) {
                            Button {
                                self.isSelectGeneratedPassword.toggle()
                            } label: {
                                Image(systemName: self.isSelectGeneratedPassword ? "checkmark.square.fill" : "checkmark.square")
                                    .foregroundStyle(.blue)
                            }
                            
                            Text("Use this password :")
                                .font(.system(size: 11,weight: .regular))
                                .foregroundStyle(Color(hex: "#CBCBCB"))
                            
                            Text(systemGeneratedPassword)
                                .font(.system(size: 13,weight: .medium))
                        }.frame(maxWidth: .infinity,alignment: .leading)
                    }
                    
                    Button(action: {
                        ///Setting the system generated password if `isSelectGeneratedPassword` is true.
                        if (isSelectGeneratedPassword) {
                            self.passwordData.password = self.systemGeneratedPassword
                        }
                        
                        ///Validate the password value
                        self.isShowAlert = manager.validateData(passwordData)
                        
                        if (!self.isShowAlert) {
                            self.isAddHide = true
                            
                            if (isForUpdate) {
                                
                                ///Edit the data
                                manager.editData(passwordData)
                            } else {
                                
                                ///Add the data
                                manager.addData(passwordData)
                            }
                            self.passwordData =  PasswordsInfo(name: "", userNameEmail: "", password: "")
                        }
                    }, label: {
                        Text(isForUpdate ? "Update" : "Add New Account")
                            .font(.system(size: 16,weight: .bold))
                            .foregroundStyle(.white)
                    })
                    .frame(maxWidth: .infinity)
                    .frame( height: 44)
                    .modifier(RoundedBorderOverlay(borderWidth: 0.0, backColor: Color(hex: "#2C2C2C"), borderColor: .clear))
                    .padding(.top,11)
                    .shadow(color:.black.opacity(0.25),radius: 4,y:2)
                }
                .padding(.top,48.0)
                .padding(.bottom,30.0)
                .padding(.horizontal,38.0)
                
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color(hex: "#E3E3E3"))
                    .frame(width:46.0,height: 4.0)
                    .padding(8.0)
            }
            .frame(alignment: .top)
            .background {
                UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topLeading: 17.0,topTrailing: 17.0))
                    .fill(Color(hex: "#F9F9F9")).ignoresSafeArea()
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .bottom)
        .background(.clear)
        .onChange(of: isAddHide) { oldValue, newValue  in
            if (newValue) {
                self.passwordData = PasswordsInfo(name: "", userNameEmail: "", password: "")
            }
            
            ///Setting the edit value to the initital value
            if (!newValue && isForUpdate) {
                if let data = self.editableData {
                    self.passwordData = data
                }
                
            }
        }
    }
}

#Preview {
    AddPasswordView(isShowAlert:  Binding<Bool>(
        get: { false },
        set: { _ in }
    ), isAddHide: .constant(false), editableData: .constant(PasswordsInfo(name: "", userNameEmail: "", password: "")), isForUpdate: false)
}


