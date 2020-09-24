//
//  ContentView.swift
//  HNSWUI
//
//  Created by Emir on 17.09.2020.
//  Copyright © 2020 Emir Beytekin. All rights reserved.
//

import SwiftUI
import RxSwift
import Combine
import Foundation
import struct Kingfisher.KFImage

struct ContentView: View {
    
    init() {
        self.hello()
    }
    
    var viewModel: HomeViewModel? = HomeViewModel()
    var id = UUID()
    var titleArr = ["Kategoriler", "Haftanın Hesaplıları", "Hesaplı Tarifler", "Kampanyalar"]
    
    func hello() {
        self.viewModel?.getHomeFeed().observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { resp in
            }, onError: { (error) in
                print(error.localizedDescription)
            })
    }
    
    var body: some View {
        ScrollView {
            ForEach(0 ..< titleArr.count) { item in
                VStack(alignment: .leading) {
                    HStack {
                        Text("\(self.titleArr[item])")
                            .font(.title)
                            .fontWeight(.regular)
                            .foregroundColor(.blue)
                            .multilineTextAlignment(.leading)
                        Spacer()
                        Text("Tümünü Gör")
                            .padding(.trailing).font(.system(size: 10))
                    }
                    
                    if item == 0 {
                        CategoryBarView(categories: self.viewModel?.resp?.categories)
                    } else if item == 1 {
                        WeeklyView(items: self.viewModel?.resp?.weeksDeals)
                    } else if item == 2 {
                        WeeklyRecipesView(items: self.viewModel?.resp?.recipes)
                    } else if item == 3 {
                        CampaignsView(items: self.viewModel?.resp?.campaigns)
                    }
                }
                .padding([.leading, .bottom])
            }
        }
    }
}

struct CategoryBarView: View {
    var categories: [Categories]? = [Categories]()
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack() {
                ForEach(0 ..< (categories!.count)) { item in
                    VStack(alignment: .center) {
                        KFImage(URL(string: "\(categories?[item].imageUrl ?? "-")")).resizable().frame(width: 55, height: 55, alignment: .center).cornerRadius(50).shadow(color: .gray, radius: 1, x: 2.0, y: 2.0).scaledToFill()
                        
                        Text("\(categories?[item].title ?? "-")").font(.system(size: 10)).multilineTextAlignment(.center).lineLimit(2).frame(height: 25.0)
                    }.padding(.init(4)).padding().frame(width: 70, height: 100, alignment: .center)
                }
            }.padding(.all, 0.0)
        }
        
    }
}

struct WeeklyView: View {
    
    var items: [WeeksDeals]? = [WeeksDeals]()
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 10.0) {
                ForEach(0 ..< (items!.count)) { item in
                    VStack(alignment: .center) {
                        VStack(alignment: .leading) {
                            KFImage(URL(string: "\(items?[item].imageUrl ?? "-")")).resizable().scaledToFit()
                        }
                        Text("\(items?[item].productTitle ?? "-")").font(.system(size: 10)).foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.218)).multilineTextAlignment(.center).lineLimit(2).frame(width: 45, height: 25, alignment: .top)
                        
                        Text("\(items?[item].price ?? "-")").font(.system(size: 10)).fontWeight(.bold).padding(.top, 1.0).frame(width: 45, height: 15, alignment: .top)
                        
                        VStack {
                            KFImage(URL(string: "\(items?[item].storeLogo ?? "-")")).resizable().scaledToFit()
                        }
                    }
                    .padding(.horizontal).frame(width: 100.0, height: 175.0).overlay(
                        RoundedRectangle(cornerRadius: 12).stroke(Color(.gray), lineWidth: 0.5)
                    )
                }
            }
            .padding(.all, 0.0)
        }
    }
}

struct WeeklyRecipesView: View {
    
    var items: [WeeksRecipes]? = [WeeksRecipes]()
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 10.0) {
                ForEach(0 ..< (items!.count)) { item in
                    VStack(alignment: .center) {
                        VStack(alignment: .leading) {
                            KFImage(URL(string: "\(items?[item].imageUrl ?? "-")")).resizable().scaledToFit()
                        }
                        VStack {
                            Text("\(items?[item].title ?? "-")").font(.system(size: 10)).foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.218)).multilineTextAlignment(.center).lineLimit(2).frame(width: 45, height: 25, alignment: .top)
                            
                            Text("\(items?[item].user ?? "")").font(.system(size: 8)).padding(.top, 1.0)
                            
                            HStack(alignment: .center, spacing: 15.0) {
                                HStack(spacing: 1.0) {
                                    Image(systemName: "arrow.right").font(.system(size: 4))
                                    Text("\(items?[item].user ?? "")").font(.system(size: 5))
                                }
                                HStack(spacing: 1.0) {
                                    Image(systemName: "arrow.right").font(.system(size: 4))
                                    Text("\(items?[item].service ?? "")").font(.system(size: 5))
                                }
                            }
                            .padding(.top, 1.0)
                            Text("\(items?[item].price ?? "0")")
                                .padding(.top, 1.0)
                        }
                        .padding(.vertical, 1.0)
                    }.padding(.horizontal).frame(width: 100.0, height: 175.0).overlay(
                        RoundedRectangle(cornerRadius: 12).stroke(Color(.gray), lineWidth: 0.5)
                    )
                }
            }.padding(.all, 0.0)
        }
    }
}

struct CampaignsView: View {
    
    var items: [Campaigns]? = [Campaigns]()
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 10.0) {
                ForEach(0 ..< (items!.count)) { item in
                    VStack(alignment: .center) {
                        HStack(alignment: .center) {
                            KFImage(URL(string: "\(items?[item].imageUrl ?? "-")")).resizable().scaledToFit()
                        }
                        .padding(.top, 5.0)
                        VStack { // resim altı
                            Text("\(items?[item].store ?? "-")").font(.system(size: 10)).foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.218)).multilineTextAlignment(.center).lineLimit(2).frame(width: 45, height: 25, alignment: .top)
                            
                            Text("\(items?[item].date ?? "")").font(.system(size: 8)).padding(.top, 1.0)
//
                            Text("\(items?[item].dayLeft ?? "0")")
                                .padding(.vertical, 1.0).font(.system(size: 8))
                        }.padding(.vertical, 1.0)
                    }.padding(.horizontal).frame(height: 175.0).overlay(
                        RoundedRectangle(cornerRadius: 12).stroke(Color(.gray), lineWidth: 0.5)
                    )
                }
            }.padding(.all, 0.0)
        }
    }
}
// Mark: asd

struct TitleBarView: View {
    @State public var index = -1
    var viewModel: HomeViewModel? = HomeViewModel()
    var body: some View {
        HStack() {
            if index == 0 {
                ForEach(0 ..< (self.viewModel?.resp?.categories!.count)!) { item in
                    VStack {
                            KFImage(URL(string: "\(self.viewModel?.resp?.categories?[item].imageUrl ?? "-")")).resizable().scaledToFill().frame(width: 75, height: 75, alignment: .center).cornerRadius(50)
                            Text("\(self.viewModel?.resp?.categories?[item].title ?? "-")").bold().padding()
                    }
                }
            } else if index == 1 {
                ForEach(0 ..< (self.viewModel?.resp?.weeksDeals!.count)!) { item in
                    HStack() {
                        Text("\(self.viewModel?.resp?.weeksDeals?[item].productTitle ?? "-")").bold()
                        Spacer()
                    }
                }
            } else if index == 2 {
                ForEach(0 ..< (self.viewModel?.resp?.recipes!.count)!) { item in
                    HStack() {
                        Text("\(self.viewModel?.resp?.recipes?[item].title ?? "-")").bold()
                        Spacer()
                    }
                }
            } else if index == 3 {
                ForEach(0 ..< (self.viewModel?.resp?.campaigns!.count)!) { item in
                    HStack() {
                        Text("\(self.viewModel?.resp?.campaigns?[item].title ?? "-")").bold()
                        Spacer()
                    }
                }
            }
        }.padding()
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


