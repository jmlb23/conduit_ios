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
            LoginGuard{ Text("Favorites") }.tabItem {
                Image(systemName: "bookmark.fill")
                    .renderingMode(.original)
            }
            LoginGuard{ Text("Editor") }.tabItem {
                Image(systemName: "text.badge.plus")
                    .renderingMode(.original)
            }
            LoginGuard{ Text("Profile") }.tabItem {
                Image(systemName: "person.fill")
                    .renderingMode(.original)
            }
        }.onAppear{
            store.dispatch(AppActions.feed(.addPage))
        }
    }
}

struct Home_Previews: PreviewProvider {
    
    static var previews: some View {
        Home().environmentObject(store)
    }
}
