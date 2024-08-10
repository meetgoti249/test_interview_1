//
//  ContentView.swift
//  Interview
//
//  Created by Meet Goti on 09/08/24.
//

import SwiftUI

//MARK: Main View
struct ContentView: View {
    @State var isAddHide : Bool = true
    @State var isUpdateHide : Bool = true
    @State var isDetailHide : Bool = true
    @State var manager:PasswordManager = PasswordManager.shared
    @State var isShowAlert :Bool = false
    @State var data: PasswordsInfo?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomTrailing) {
//                if (isAddShow) {
                    
//                }
                VStack(spacing: 0) {
                    HeaderView()
                    PasswordListView(
                        isDetailHide: $isDetailHide,
                        data: $data
                    ).environmentObject(manager)
                    
                }
                .frame(maxHeight: .infinity,alignment:.top)
                .background(Color(hex: "#F3F5FA"))
                
                Button(action: {
                    self.isAddHide = false
                }, label: {
                    Image("ic_plus")
                })
                .frame(width: 60,height: 60)
                .background(Color(hex: "#3F7DE3"))
                .clipShape(.rect(cornerRadius: 10, style: .circular))
                .padding(.trailing,30.79)
                .padding(.bottom,30.4)
                
//                AddPasswordView(hide: $isAddShow)
                   
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .bottomTrailing)
            .modifier(
                ModelViewPresentation(
                    modelView:AnyView(
                        AddPasswordView(isShowAlert: $isShowAlert, isAddHide: $isAddHide,editableData: .constant(nil))
                            .environmentObject(manager)
                    ) ,
                    hide: $isAddHide
                )
            ).modifier(
                ModelViewPresentation(
                    modelView:AnyView(
                        AddPasswordView(isShowAlert: $isShowAlert, isAddHide: $isUpdateHide,editableData: $data, isForUpdate: true)
                            .environmentObject(manager)
                    ) ,
                    hide: $isUpdateHide
                )
            )
            
            .modifier(AlertModifier(isPresented: $isShowAlert, message: $manager.validationMessage))
            .modifier(
                ModelViewPresentation(
                    modelView: AnyView(
                        PasswordDetailView(
                            isHideDetailView: $isDetailHide, isHideUpdate: $isUpdateHide,data: $data
                        ).environmentObject(manager)
                    ),
                    hide: $isDetailHide
                )
            ).onChange(of: isAddHide) { oldValue, newValue in
                if (newValue) {
                    data = nil
                }
            }
        }
        .ignoresSafeArea(edges:.bottom)
    }
}


//MARK: Top HeaderView
struct HeaderView: View {
    var body: some View {
        HStack(spacing: 0) {
            Text("Password Manager")
                .font(.system(size: 18,weight: .semibold))
                .foregroundStyle(Color(hex: "#333333"))
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        .padding(.top,24)
        .padding(.leading,15)
        .padding(.bottom,15)
        .background(.clear)
        .modifier(BorderModifier(borderWidth: 1))
    }
}

#Preview {
    ContentView()
}

/// `ViewModifier` for apply border over the `View`
struct BorderModifier:ViewModifier {
    var borderWidth:CGFloat
    func body(content:Content) -> some View {
        content.overlay {
            VStack {
                Rectangle()
                    .frame(height: borderWidth)
                    .foregroundStyle(Color(hex: "#E8E8E8"))
                    
            }.frame(maxHeight: .infinity,alignment: .bottom)
        }
    }
    
}

/// `ViewModifier` for show mode over the screen
struct ModelViewPresentation :ViewModifier {
    var modelView:AnyView
    @Binding var hide:Bool
    func body(content:Content) -> some View {
        GeometryReader { geometry in
            ZStack {
                content
                Color.clear
                    .background(.black.opacity(0.6))
                    .onTapGesture {
//                    withAnimation {
                        self.hide = true
//                    }
                }
                    .offset(y:self.hide ? geometry.size.height : 0.0 )
                
                VStack {
                    modelView
                }
                .frame(width: geometry.size.width,height: geometry.size.height,alignment: .bottomTrailing)
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                .offset(y:self.hide ? geometry.size.height : 0.0 )
            }
            
        }
    }
}

/// `ViewModifier` for showing the alerts
struct AlertModifier: ViewModifier {
    
    @Binding var isPresented:Bool
    @Binding var message:String
    var title:String = Bundle.main.ApplicationName ?? ""
    var buttonTitle:String = "OK"
    var callBack :(() -> Void)?
    func body(content: Content) -> some View {
        content
            .alert(title,
                      isPresented: $isPresented,
                      actions: {
            Button(buttonTitle, role: .cancel) {
                isPresented = false
                callBack?()
            }
        },message: {
            Text(message)
                .font(.system(size: 17,weight: .regular))
        })
    }
}
