//
//  DetailsFilmsContentView.swift
//  TheMovieDbSwiftUi
//
//  Created by Denis Bortoletto Pereira on 27/12/22.
//

import SwiftUI

struct DetailsFilmsContentView: View {
    
    @ObservedObject var viewModel:DetailsFilmsViewModel = DetailsFilmsViewModel()
    
    @Environment(\.dismiss) private var dismiss
    
    public var idFilm:Int = 0
    
    var body: some View {
        VStack{
            if self.viewModel.detailsFilmsModel.count > 0 {
                self.imageDetailFilm
                VStack{
                    self.titleDetailFilm
                    self.descriptionDetailFilm
                    Spacer()
                }
                .background(.black)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear(){
            self.viewModel.getNetwork(.detailsFilm, idFilm: String(self.idFilm))
        }
        .confirmationDialog("Erro", isPresented: self.$viewModel.isErrorLoading, actions: {
            Button("Sim"){
                self.viewModel.getNetwork(.detailsFilm, idFilm: String(self.idFilm))
            }
        }, message: {
            Text("Erro na requisição dos detalhes do filme, deseja tentar novamente ?")
        })
        .background(.black)
    }
}

struct DetailsFilmsContentView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsFilmsContentView()
    }
}

extension DetailsFilmsContentView {
    var imageDetailFilm: some View {
        VStack{
            AsyncImage(url: URL(string: "\(self.viewModel.imageUrl)\(self.viewModel.detailsFilmsModel[0].poster)"), content: { image in
                image
                    .resizable()
            }, placeholder: {
                ProgressView()
                    .tint(.white)
            })
            .frame(maxWidth: .infinity, maxHeight: 400)
        }
        .overlay(alignment: .topLeading, content: {
            self.returnButton
        })
    }
}

extension DetailsFilmsContentView {
    var returnButton: some View {
        Button {
            self.dismiss()
        } label: {
            Image("return")
                .resizable()
        }
        
        .frame(width: 50, height: 50)
        .padding()
    }
}

extension DetailsFilmsContentView {
    var titleDetailFilm: some View {
        Text(self.viewModel.detailsFilmsModel[0].title)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.system(size: 25, weight: .semibold))
            .foregroundColor(.white)
            .padding()
    }
}

extension DetailsFilmsContentView {
    var descriptionDetailFilm: some View {
        ScrollView {
            Text(self.viewModel.detailsFilmsModel[0].description)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 20, weight: .regular))
                .foregroundColor(.white)
        }
        .padding()
    }
}
