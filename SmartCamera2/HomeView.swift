//
//  HomeView.swift
//  SmartCamera2
//
//  Created by Adam Wolkowycki on 08/12/2021.
//

import SwiftUI

struct URLImage: View {
    
    let urlString: String
    
    @State var data: Data?
    
    var body: some View {
        
        if let data = data, let uiimage = UIImage(data: data) {
            Image(uiImage: uiimage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .background(Color.gray)
        } else {
            Image(systemName: "camera")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .background(Color.gray)
                .onAppear { fetchData() }
        }
    }
    
    private func fetchData() {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
            self.data = data
        }
        task.resume()
    }
}

struct Item: Hashable, Codable {
    let name, image: String
}

class ViewModel: ObservableObject {
    
    @Published var items: [Item] = []
    
    func fetch() {
        guard let url = URL(string: "https://iosacademy.io/api/v1/courses/index.php") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            guard let data = data, error == nil else { return }
            do {
                let items = try JSONDecoder().decode([Item].self, from: data)
                
                DispatchQueue.main.async {
                    self.items = items
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}

struct HomeView: View {
    
    @State var searchText = ""
    @State var isSearching = false
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            // ScrollView {
            VStack {
                SearchBar(searchText: $searchText, isSearching: $isSearching)
                    
                List {
                    ForEach(viewModel.items, id: \.self) { item in
                        
                        if item.name.lowercased().contains(searchText.lowercased()) || searchText.isEmpty {
                            HStack {
                                URLImage(urlString: item.image)
                                Text(item.name).bold()
                            }.padding()
                        }
                    }
                }.onAppear {
                    viewModel.fetch()
                }
            }
        }.navigationTitle("Explore")
        // }
    }
}

struct SearchBar: View {
    
    @Binding var searchText: String
    @Binding var isSearching: Bool
    
    var body: some View {
        HStack {
            HStack {
                TextField("Search", text: $searchText).padding(.leading, 24)
            }
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(6)
            .padding(.horizontal)
            .onTapGesture(perform: { isSearching = true })
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    if isSearching {
                        Button(action: { searchText = "" }, label: {
                            Image(systemName: "xmark.circle.fill").padding(.vertical)
                        })
                    }
                }.padding(.horizontal, 32).foregroundColor(.gray)
            )
            .transition(.move(edge: .trailing))
            .animation(.spring())
            
            if isSearching {
                Button(action: {
                    isSearching = false
                    searchText = ""
                    
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    
                }, label: {
                    Text("Cancel")
                        .padding(.trailing)
                        .padding(.leading, 0)
                })
                .transition(.move(edge: .trailing))
                .animation(.spring())
            }
        }
    }
}
