//
//  LoginGuard.swift
//  MediumClone
//
//  Created by jmlb23 on 10/1/21.
//

import SwiftUI

struct LoginGuard<Content>: View where Content: View {

  @EnvironmentObject<GlobalStore> var store
  @State var isModalVisible = false

  var content: Content

  init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }

  var body: some View {
    if store.state.token != nil {
      content
    } else {
      Button(action: {
        isModalVisible = true
      }) {
        Text("Login or Register to access.")
      }.fullScreenCover(isPresented: $isModalVisible) {
        LoginOrRegister()
      }
    }
  }
}
