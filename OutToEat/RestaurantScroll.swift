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
    let name: String
    let type: String
    let notes: String
    // let amount: Int
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
}

struct RestaurantScroll: View {
    @ObservedObject var restaurants = Restaurants()
    @State private var showingRestaurantAdd = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(restaurants.items) { item in // items are identifiable so no need to specify id
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        Text("\(item.notes)")
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
