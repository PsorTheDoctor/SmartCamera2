//
//  HomeView.swift
//  SmartCamera2
//
//  Created by Adam Wolkowycki on 08/12/2021.
//

import SwiftUI

struct HomeView: View {
    
    @State var item = Item(title: "title", primaryImageSmall: "primaryImageSmall")
    @State var searchText = ""
    @State var isSearching = false
    
    func getData(index: Int) {
        let urlString = "https://collectionapi.metmuseum.org/public/collection/v1/objects/\(index)"
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!) { data, _, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(Item.self, from: data)
                    self.item = decodedData
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
                Button("Refresh") { self.getData(index: 1000) }
                
                if item.title.lowercased().contains(searchText.lowercased()) || searchText.isEmpty {
                    VStack {
                        Text("\(item.title)")
                        URLImage(urlString: item.primaryImageSmall)
                    }
                }
            }
        }.navigationTitle("Explore")
    }
}
