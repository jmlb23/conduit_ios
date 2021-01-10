//
//  Home.swift
//  MediumClone
//
//  Created by jmlb23 on 11/12/20.
//

import SwiftUI
import os

struct Home: View {
    @EnvironmentObject<GlobalStore> var store
    @State var isModalVisible = false
    
    var body: some View {
        TabView{
            NavigationView{
                Feed()
            }.tabItem {
                Image(systemName: "house")
                    .renderingMode(.original)
            }
            Text("Favorites").onAppear{
                if(store.state.token == nil){
                    isModalVisible = true
                }
            }.tabItem {
                Image(systemName: "bookmark.fill")
                    .renderingMode(.original)
            }
            Text("Editor").tabItem {
                Image(systemName: "text.badge.plus")
                    .renderingMode(.original)
            }
            Text("Profile").tabItem {
                Image(systemName: "person.fill")
                    .renderingMode(.original)
            }
        }.onAppear{
            store.dispatch(AppActions.feed(.addPage))
        }.sheet(isPresented: $isModalVisible) {
            LoginOrRegister()
        }
    }
}

struct Home_Previews: PreviewProvider {
    
    static var previews: some View {
        Home().environmentObject(store)
    }
}
