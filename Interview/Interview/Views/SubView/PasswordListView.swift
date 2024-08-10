//
//  PasswordListView.swift
//  Interview
//
//  Created by Meet Goti on 09/08/24.
//

import SwiftUI
import RealmSwift

//MARK: Password List View
struct PasswordListView: View {
    @EnvironmentObject var passwordManager : PasswordManager
    @State var fitInScreen:Bool = false
    @Binding var isDetailHide : Bool
    @Binding var data:PasswordsInfo?
    @ObservedResults(PasswordDataModel.self) var contacts
    var body: some View {
        VStack {
            if(passwordManager.listOfPassword.count <= 0) {
                
                ///Placeholder for passwords
                Text("No Passwords")
                    .font(.system(size: 20,weight: .medium))
                    .foregroundStyle(.gray)
            } else {
                GeometryReader { gp in
                    ScrollView {
                        VStack(spacing: 18.18) {
                            ForEach(passwordManager.listOfPassword,id:\.id) { datum in
                                PasswordRow(password: datum)
                                    .onTapGesture {
                                        if let index = passwordManager.listOfPassword.firstIndex(of: datum) {
                                            self.data = datum
                                            self.isDetailHide = false
                                        }
                                    }
                            }
                        }
                        .padding(.horizontal,15)
                        .padding(.top,25)
                        .background(GeometryReader {
                            Color.clear.preference(key: ViewHeightKey.self,
                                                   value: $0.frame(in: .local).size.height) })
                    }
                    .scrollIndicators(.hidden)
                    .scrollDisabled(self.fitInScreen)
                    
                    .onPreferenceChange(ViewHeightKey.self) {
                        self.fitInScreen = $0 < gp.size.height    // << here !!
                    }
                    .background(.clear)
                }
            }
            
        }.frame(maxHeight: .infinity,alignment: passwordManager.listOfPassword.count <= 0 ? .center :.top)
    }
    
}

#Preview {
    PasswordListView(isDetailHide: .constant(false),data: .constant(PasswordsInfo(name: "", userNameEmail: "", password: "")))
}
struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}
