//
//  Register.swift
//  MediumClone
//
//  Created by jmlb23 on 10/1/21.
//

import SwiftUI

struct Register: View {
  @State var username = ""
  @State var email = ""
  @State var password = ""

  var body: some View {
    VStack {
      VStack(spacing: 30) {
        Text("Sing up").font(.title)
        TextField("username", text: $username)
          .textFieldStyle(RoundedBorderTextFieldStyle())
        TextField("email", text: $email)
          .textFieldStyle(RoundedBorderTextFieldStyle())
        SecureField("password", text: $password)
          .textFieldStyle(RoundedBorderTextFieldStyle())
        Button(action: {

        }) {
          Text("Sign up")
        }.frame(maxWidth: .infinity)
          .padding()
          .background(Color.purple100)
          .foregroundColor(.white)
          .clipShape(RoundedRectangle(cornerRadius: 5))
      }.padding()
    }.padding()
  }
}

struct Register_Preview: PreviewProvider {
  static var previews: some View {
    Register()
  }
}
