//
//  RestaurantScroll.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/6/20.
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import SwiftUI

struct Restaurant: Identifiable, Codable, Equatable {
    let id = UUID()
    var name: String
    var type: String
    var notes: String
    
    // define methods to update elements of the struct
    public mutating func updateName(newName: String) {
        self.name = newName
    }
    
    public mutating func updateType(newType: String) {
        self.type = newType
    }
    
    public mutating func updateNotes(newNotes: String) {
        self.notes = newNotes
    }
}

// TODO: implement manual delete
class Restaurants: ObservableObject {
    @Published var items = [Restaurant]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Restaurants")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Restaurants") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([Restaurant].self, from: items) {
                self.items = decoded
                return
            }
        }
        // else initialize to empty array
        self.items = []
    }
    
    // define methods to change restaurant data
    public func setName(newName: String, index: Int) {
        items[index].updateName(newName: newName)
    }
    
    public func setType(newType: String, index: Int) {
        items[index].updateType(newType: newType)
    }
    
    public func setNotes(newNotes: String, index: Int) {
        items[index].updateNotes(newNotes: newNotes)
    }
}

struct RestaurantScroll: View {
    @ObservedObject var restaurants = Restaurants()
    @State private var showingRestaurantAdd = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(restaurants.items) { item in // items are identifiable (by UUID) so no need to specify id
                    NavigationLink(destination: RestaurantInfo(restaurants: self.restaurants, restaurant: item)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name).font(.title)
                            }
                            Spacer()
                        }
                    }
                }
                .deleteDisabled(true)
                // .onDelete(perform: removeItems)
            } // end List
            .navigationBarTitle("Restaurants")
            .navigationBarItems(
                trailing:
                    Button(action: {
                        self.showingRestaurantAdd = true
                    }) {
                        Image(systemName: "plus").font(.title)
                    }
            ) // end navigationBarItems
            .sheet(isPresented: $showingRestaurantAdd) {
                RestaurantAdd(restaurants: self.restaurants)
            }
        } // end NavigationView
    }
    
    /* don't need anymore
    func removeItems(at offsets: IndexSet) {
        restaurants.items.remove(atOffsets: offsets)
    }
    */
}


struct RestaurantScroll_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantScroll()
    }
}
