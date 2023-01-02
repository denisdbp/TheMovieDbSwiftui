//
//  ListFilmsContentView.swift
//  TheMovieDbSwiftUi
//
//  Created by Denis Bortoletto Pereira on 21/12/22.
//

import SwiftUI

struct ListFilmsContentView: View {
    
    @ObservedObject private var viewModel:ListFilmsViewModel = ListFilmsViewModel()
    
    var body: some View {
        self.navigation
    }
}

struct ListFilmsContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListFilmsContentView()
    }
}

extension ListFilmsContentView {
    var navigation: some View {
        NavigationView{
            self.listFilm
        }
        .overlay(content: {
            if self.viewModel.isLoading {
                LoadingContentView(isLoading: self.viewModel.isLoading)
            }
        })
        .onAppear(){
            self.viewModel.getNetwork(.listFilms)
        }
        .scrollContentBackground(.hidden)
        .background(Color.black)
        .ignoresSafeArea()
    }
}

extension ListFilmsContentView {
    var listFilm: some View {
        List {
            ForEach(self.viewModel.resultListFilmsModel){
                film in
                NavigationLink(destination: DetailsFilmsContentView(idFilm: film.id)){
                    HStack{
                        self.imageListFilm(film: film)
                        self.titleListFilm(film: film)
                    }
                }.listRowBackground(Color.black)
            }
        }
        .confirmationDialog("Erro", isPresented: self.$viewModel.isErrorLoading, actions: {
            Button("Sim"){
                self.viewModel.getNetwork(.listFilms)
            }
        }, message: {
            Text("Erro na requisição da lista de filmes, deseja tentar novamente ?")
        })
        .background(Color.black)
    }
}

extension ListFilmsContentView {
    func imageListFilm(film:ResultListFilmsModel) -> some View {
        return AsyncImage(url: URL(string: "\(self.viewModel.imageUrl)\(film.poster)"), content: { image in
            image
                .resizable()
        }, placeholder: {
            ProgressView()
                .tint(.white)
        })
        .frame(width: 100, height: 100)
        .cornerRadius(10)
    }
}

extension ListFilmsContentView {
    func titleListFilm(film:ResultListFilmsModel)-> some View {
        return Text(film.title)
            .foregroundColor(.white)
    }
}
