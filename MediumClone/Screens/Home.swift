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

    var body: some View {
        TabView{
            NavigationView{
                Feed()
            }.tabItem {
                Image(systemName: "house")
                    .renderingMode(.original)
            }
            Text("Favorites").tabItem {
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
            store.dispatch(.addPage)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
