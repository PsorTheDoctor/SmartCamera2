//
//  HomeView.swift
//  SmartCamera2
//
//  Created by Adam Wolkowycki on 08/12/2021.
//

import SwiftUI

struct HomeView: View {
    
    @State var item = Item(title: "", primaryImageSmall: "", artistDisplayName: "", creditLine: "")
    @State var itemList = [Item]()
    @State var searchText = ""
    @State var isSearching = false
    
    func fetchData() {
        for i in 10500...10519 {
            fetchItem(index: i)
        }
    }
    
    func fetchItem(index: Int) {
        let urlString = "https://collectionapi.metmuseum.org/public/collection/v1/objects/\(index)"
        let url = URL(string: urlString)
        var decodedData = Item(title: "", primaryImageSmall: "", artistDisplayName: "", creditLine: "")
        
        URLSession.shared.dataTask(with: url!) { data, _, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decodedData = try decoder.decode(Item.self, from: data)
                    self.itemList.append(decodedData)
                } catch {
                    print("Error")
                }
            }
        }.resume()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(searchText: $searchText, isSearching: $isSearching)
                List {
                    ForEach(self.itemList, id: \.self) { elem in
                        if elem.title.lowercased().contains(searchText.lowercased()) || searchText.isEmpty {
                            if elem.primaryImageSmall != "" {
                                VStack {
                                    Text("\(elem.title)").bold()
                                    URLImage(urlString: elem.primaryImageSmall)
                                    Text("\(elem.artistDisplayName)").foregroundColor(.gray)
                                    Text("\(elem.creditLine)").foregroundColor(.gray)
                                }.padding(3)
                            }
                        }
                    }
                }.onAppear { self.fetchData() }
            }.navigationTitle("Explore")
        }
    }
}
