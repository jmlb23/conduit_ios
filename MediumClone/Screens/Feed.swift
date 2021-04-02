//
//  Feed.swift
//  MediumClone
//
//  Created by jmlb23 on 24/12/20.
//

import Combine
import struct Kingfisher.KFImage
import SwiftUI
import os

struct FeedItem: View {
  var item: Article
  var fav: (Article) -> Void

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        KFImage(URL(string: item.author?.image ?? ""))
          .resizable()
          .frame(width: 50, height: 50)
          .clipShape(Circle())
          .overlay(Circle().stroke(lineWidth: 1))
        VStack(alignment: .leading) {
          Text(item.author?.username ?? "").font(.body).bold()
          Text(item.createdAt ?? "").font(.caption)
        }
        Spacer()
        HStack {
          Image(systemName: item.favorited == true ? "heart.fill" : "heart").foregroundColor(
            Color.red
          ).frame(width: 24, height: 24)
          Text("\(item.favoritesCount ?? 0)")
        }.padding(5).clipShape(RoundedRectangle(cornerRadius: 5))
          .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
          .onTapGesture {
            fav(item)
          }

      }.frame(minWidth: .zero, maxWidth: .infinity)
      Spacer()
      VStack(alignment: .leading) {
        Text(item.title ?? "").font(.title3).bold()
        Text(item.description ?? "").font(.body)
      }

    }.navigationTitle("MediumClone")
      .toolbar(content: {
        ToolbarItem(placement: .navigationBarLeading) {

        }
      })
      .padding()
  }
}

struct PreviewFeedItem: PreviewProvider {

  static var previews: some View {
    Feed()
      .environmentObject(store)
      .onAppear {
        store.dispatch(AppActions.feed(.addPage))
      }
  }
}

struct Feed: View {
  @EnvironmentObject<GlobalStore> var store

  var body: some View {
    List {
      ForEach(store.state.feed.articles, id: \Article.slug) { i in
        NavigationLink(destination: FeedDetail(slug: i.slug ?? "", store: store)) {
          FeedItem(
            item: i,
            fav: { item in }
          )
        }
        if i.slug == store.state.feed.articles.last?.slug {
            Button("more"){
                store.dispatch(AppActions.feed(.addPage))
                store.dispatch(AppActions.feed(.getPage))
            }
        }
      }
    }
  }

}
