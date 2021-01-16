//
//  FeedDetail.swift
//  MediumClone
//
//  Created by jmlb23 on 15/1/21.
//

import Kingfisher
import SwiftUI

struct FeedDetail: View {
  let slug: String
  @EnvironmentObject<GlobalStore> var store

  var body: some View {
    NavigationView {
      VStack {
        VStack {
          ScrollView {
            Text("asdda")
              .font(.body)
              .foregroundColor(.black)
              .frame(maxWidth: .infinity, alignment: .leading).padding()
          }
        }
        HStack(spacing: 20) {
          KFImage(URL(string: "item.author?.image"))
            .resizable()
            .frame(width: 50, height: 50, alignment: .leading)
            .clipShape(Circle())
            .overlay(Circle().stroke(lineWidth: 1))
          VStack {
            NavigationLink(
              destination: Text("Destination"),
              label: {
                Text("name")
              })
            Text("2020-01-20")
          }
          Button(
            action: {},
            label: {
              Text("Follow")
            })
          Button(
            action: {},
            label: {
              Text("Fav")
            })
        }.frame(maxWidth: .infinity, alignment: .leading).padding()
        Spacer()
      }.navigationTitle("TITLE")

    }.onAppear {
      store.dispatch(.detail(.loadDetail(slug)))
    }
  }
}

struct FeedDetail_Previews: PreviewProvider {
  static var previews: some View {
    FeedDetail(slug: "article-two-ncyeh8").environmentObject(store)
  }
}
