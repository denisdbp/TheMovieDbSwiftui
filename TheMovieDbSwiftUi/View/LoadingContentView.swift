//
//  LoadingContentView.swift
//  TheMovieDbSwiftUi
//
//  Created by Denis Bortoletto Pereira on 01/01/23.
//

import SwiftUI

struct LoadingContentView: View {
    
    @State var isLoading:Bool
    
    var body: some View {
        ZStack{
            Color(.black)
                .ignoresSafeArea()
            if self.isLoading {
                Color(.black)
                    .ignoresSafeArea()
                ProgressView()
                    .tint(.white)
                    .scaleEffect(2)
            }
        }
    }
}

struct LoadingContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingContentView(isLoading: false)
    }
}
