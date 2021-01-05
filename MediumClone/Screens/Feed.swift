//
//  Feed.swift
//  MediumClone
//
//  Created by jmlb23 on 24/12/20.
//

import SwiftUI
import os
import Combine


struct FeedItem : View{
    var item: Article
    var fav: (Article) -> ()
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Image(systemName: "pencil")
                    .scaledToFit()
                    .frame(width: 36, height: 36)
                    .clipShape(Circle())
                VStack(alignment: .leading){
                    Text(item.author?.username ?? "").font(.title3)
                    Text(item.createdAt ?? "").font(.caption)
                }
                Spacer()
                HStack{
                    Image(systemName:"heart.fill").frame(width: 24, height: 24)
                    Text("(0)")
                }.padding(2).clipShape(RoundedRectangle(cornerRadius: 5))
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 2))
                .onTapGesture {
                    fav(item)
                }
                
            }.frame(minWidth: .zero, maxWidth: .infinity)
            Spacer()
            VStack(alignment:.leading){
                Text("some boring title").font(.title2)
                Text("some boring body").font(.body)
            }
            
        }.navigationTitle("MediumClone")
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading){
                
            }
        })
        .padding()
    }
}


struct PreviewFeedItem : PreviewProvider {
    
    static var previews: some View {
        Feed()
    }
}

struct Feed: View{
    @EnvironmentObject<GlobalStore> var store
    
    var body: some View{
        List(store.state.articles ,id: \Article.slug){i in
            NavigationLink(destination: EmptyView()) {
                FeedItem(item: i, fav: {item in
                }).onAppear{
                    if i.slug == store.state.articles.last?.slug {
                        store.dispatch(.addPage)
                    }
                }
            }
        }
    }
    
}
