//
//  DetailView.swift
//  ForYouDicodingIOSExpertSub1
//
//  Created by Moh Zinnur Atthufail Addausi on 04/11/20.
// ??

import SwiftUI
//import SDWebImageSwiftUI
import Core
import Tourism

struct DetailView: View {
    
    @ObservedObject var presenter: DetailModulPresenter<Int, TourismModel,
     Interactor<Int, TourismModel,
                GetPartTourismRepository<GetFavoriteTourismLocaleDataSource, TourismTransformer>>,
     Interactor<Int, TourismModel,
                UpdateFavoriteTourismRepository<GetFavoriteTourismLocaleDataSource, TourismTransformer>>>
    var tourism: TourismModel
    
    @State private var imageheight: CGFloat = 0.0
    @State private var paddinngNavigationTop: CGFloat = 0.0
    @ObservedObject private var locationManager = LocationManager()
    @State private var bottomSheetShown = false
    @Environment(\.presentationMode) var presentationMode
   
    var body: some View {
            
            ZStack(alignment: .top) {
                
                MapView(latitude: self.presenter.item?.latitude ?? 0.0,
                        longtitude: self.presenter.item?.longitude ?? 0.0,
                        title: self.presenter.item?.name ?? "")
                
                navigation
                Spacer()
                mainBottomSheet
            }.navigationBarHidden(true)
            .ignoresSafeArea()
            .onAppear {
                if self.presenter.item == nil {
                    self.presenter.getTourism(request: tourism.id)
                }

            }
    }
}

extension DetailView {
    
    var navigation : some View {
        HStack {
            backButton
            Spacer()
            favoriteButton
        }
        .padding(EdgeInsets(top: paddinngNavigationTop, leading: 16, bottom: 0, trailing: 16))
    }
    
    var mainBottomSheet: some View {
        GeometryReader { geometry in
            
            BottomSheetView(
                isOpen: self.$bottomSheetShown,
                maxHeight: geometry.size.height * 0.87,
                minHeight: geometry.size.height * 0.41
            ) {
                
                content
                
            }.onAppear {
                self.imageheight =  (geometry.size.height * 0.87)/4
                self.paddinngNavigationTop = (geometry.size.height * 0.87)/20
            }
            
        }
    }
    
    var content : some View {
        
        GeometryReader { _ in
            
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    
                    titledetail
//                    imageDetail
                    addressdetail
                    descdetail
                    
                }
                
            }
            .padding(.horizontal, 16)
        }
    }
    
    var backButton : some View {
        
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.left")
            
        }).buttonStyle(CircleBackButtonStyle())
        
    }
    
    var favoriteButton : some View {
        Button(action: {
            self.presenter.updateFavoriteTourism(request: tourism.id)
            
        },
        label: {
            presenter.item?.favorite == true ?
                Image(systemName: "heart.fill"):
                Image(systemName: "heart")
            
        }).buttonStyle(CircleBackButtonStyle())
        
    }
    
//    var imageDetail: some View {
        
//        WebImage(url: URL(string: self.presenter.item?.image ?? ""))
//            .resizable()
//            .indicator(.activity)
//            .transition(.fade(duration: 0.5))
//            .aspectRatio(contentMode: .fill)
//            .frame(maxWidth: .infinity,
//                   maxHeight: imageheight)
//            .cornerRadius(20)
//
//    }
    
    var titledetail : some View {
        HStack {
            Spacer()
            Text(self.presenter.item?.name ?? "")
                .font(.title2)
                .bold()
                .frame( alignment: .center)
                .foregroundColor(Color("text"))
            
            Spacer()
        }
        
    }
    
    var addressdetail : some View {
        
        Text(self.presenter.item?.address ?? "")
            .font(.caption2)
            .foregroundColor(Color("text"))
            .padding(.top, -5)
        
    }
    
    var descdetail : some View {
        Text(self.presenter.item?.placeDescription ?? "")
            .fixedSize(horizontal: false, vertical: true)
            .foregroundColor(Color("text"))
            .font(.body)
    }
    
}
