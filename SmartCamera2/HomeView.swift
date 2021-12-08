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
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.items, id: \.self) { item in
                    HStack {
                        URLImage(urlString: item.image)
                        Text(item.name).bold()
                    }.padding(3)
                }
            }.onAppear {
                viewModel.fetch()
            }
        }
    }
}
