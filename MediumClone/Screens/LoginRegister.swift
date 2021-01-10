//
//  LoginRegister.swift
//  MediumClone
//
//  Created by jmlb23 on 10/1/21.
//

import SwiftUI

struct LoginOrRegister : View {
    @State var selection = 0
    var body: some View{
        VStack{
            TabView(selection: $selection){
                Login().tabItem { Text("Login") }.tag(0)
                Register().tabItem { Text("Register") }.tag(1)
            }.tabViewStyle(PageTabViewStyle())
            Text(selection == 0 ? "Swipe to register" : "swipe to login")
        }
    }
}

struct LoginOrRegister_Preview : PreviewProvider{
    static var previews: some View{
        LoginOrRegister()
    }
}

