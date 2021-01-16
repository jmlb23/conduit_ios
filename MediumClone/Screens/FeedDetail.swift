//
//  FeedDetail.swift
//  MediumClone
//
//  Created by jmlb23 on 15/1/21.
//

import SwiftUI

struct FeedDetail: View {
  let slug: String
  @EnvironmentObject<GlobalStore> var store

  var body: some View {
    VStack {
      VStack {
        Text("Example")
          .font(.title)
          .foregroundColor(.white)
          .bold()
          .frame(maxWidth: .infinity, alignment: .leading).padding()
        Spacer()
      }.background(Color.black)
    }.onAppear {
      //            store.dispatch(.)
    }
  }
}

struct FeedDetail_Previews: PreviewProvider {
  static var previews: some View {
    FeedDetail(slug: "example")
  }
}
