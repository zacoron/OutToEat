//
//  RestaurantScroll.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/6/20.
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import SwiftUI

struct Restaurant: Identifiable, Codable {
    let id = UUID()
    var name: String
    var type: String
    var notes: String
    // let amount: Int
    
    public mutating func updateName(newName: String) {
        self.name = newName
    }
}

class Restaurants: ObservableObject {
    @Published var items = [Restaurant]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([Restaurant].self, from: items) {
                self.items = decoded
                return
            }
        }
        // else initialize to empty array
        self.items = []
    }
    
    public func setName(newName: String, index: Int) {
        items[index].updateName(newName: newName)
    }
}

struct RestaurantScroll: View {
    @ObservedObject var restaurants = Restaurants()
    @State private var showingRestaurantAdd = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(restaurants.items) { item in // items are identifiable so no need to specify id
                    NavigationLink(destination: RestaurantInfo(restaurants: self.restaurants, restaurant: item)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.title)
                            }
                            Spacer()
                            // Image(systemName: "arrow.right").font(.title) arrow automatically added for list
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("Restaurants")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingRestaurantAdd = true
                }) {
                    Image(systemName: "plus").font(.largeTitle)
                }
            )
            .sheet(isPresented: $showingRestaurantAdd) {
                RestaurantAdd(restaurants: self.restaurants)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        restaurants.items.remove(atOffsets: offsets)
    }
   
}


struct RestaurantScroll_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantScroll()
    }
}
