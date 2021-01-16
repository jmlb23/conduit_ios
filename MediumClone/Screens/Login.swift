//
//  Login.swift
//  MediumClone
//
//  Created by jmlb23 on 9/1/21.
//

import SwiftUI

struct Login: View {
  @State var username: String = ""
  @State var password: String = ""

  var body: some View {
    VStack {
      VStack(spacing: 30) {
        Text("Log in").font(.title)
        TextField("username", text: $username)
          .textFieldStyle(RoundedBorderTextFieldStyle())
        SecureField("password", text: $password)
          .textFieldStyle(RoundedBorderTextFieldStyle())
        Button(action: {

        }) {
          Text("Log in")
        }.frame(maxWidth: .infinity)
          .padding()
          .background(Color.purple100)
          .foregroundColor(.white)
          .clipShape(RoundedRectangle(cornerRadius: 5))
      }.padding()
    }.padding()
  }
}

struct PreviewLogin: PreviewProvider {
  static var previews: some View {
    Login()
  }
}
