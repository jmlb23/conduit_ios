//
//  LoginRegister.swift
//  MediumClone
//
//  Created by jmlb23 on 10/1/21.
//

import SwiftUI

struct LoginOrRegister: View {
  @State var selection = 0
  @Environment(\.presentationMode) var presentationMode
  var body: some View {
    VStack {
      HStack {
        Spacer()
        Text("Close").padding().onTapGesture {
          presentationMode.wrappedValue.dismiss()
        }
      }
      TabView(selection: $selection) {
        Login().tabItem {
          Text("Login")
        }.tag(0)
        Register().tabItem {
          Text("Register")
        }.tag(1)
      }.tabViewStyle(PageTabViewStyle())
      Text(selection == 0 ? "Swipe to register" : "Swipe to login")
    }
  }
}

struct LoginOrRegister_Preview: PreviewProvider {
  static var previews: some View {
    LoginOrRegister()
  }
}
