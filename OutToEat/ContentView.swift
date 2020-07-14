//
//  ContentView.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/6/20.
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import Combine
import SwiftUI

// TODO: make not in FAQ that deleting a restaurant will not delete entries for that restuarant in the favorites of each person that previously had that restaurant as a favorite
struct Restaurant: Identifiable, Codable, Equatable {
    let id = UUID()
    var name: String
    var type: String
    var notes: String
    var peopleFavorited = [Person]()
    
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
    var didChange = PassthroughSubject<Void, Never>() // needed to notify environment variable of changes
    
    @Published var items = [Restaurant]() {
        didSet {
            didChange.send() // notify environment variable of change
            
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
    
    public func removeAtIndex(index: Int) {
        items.remove(at: index)
    }
}

struct Order: Identifiable, Codable, Equatable {
    let id = UUID()
    var orderDetails: String
    var orderNotes: String
    var orderCost: Double
}

struct Favorite: Identifiable, Codable, Equatable {
    let id = UUID()
    var personName: String
    var personUUID: UUID
    var restaurantName: String
    var restaurantUUID: UUID
    var orders = [Order]()
    var cost: Double
    var notes: String
}

struct Person: Identifiable, Codable, Equatable {
    let id = UUID()
    var name: String
    var notes: String
    var favorites = [Favorite]()
    
    // define methods to update elements of the struct
    public mutating func updateName(newName: String) {
        self.name = newName
    }
    
    public mutating func updateNotes(newNotes: String) {
        self.notes = newNotes
    }
    
    public mutating func addFavorite(newFavorite: Favorite) {
        favorites.append(newFavorite)
    }
}

class People: ObservableObject {
    var didChange = PassthroughSubject<Void, Never>() // needed to notify environment variable of changes
    
    @Published var items = [Person]() {
        didSet {
            didChange.send() // notify environment variable of change
            
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "People")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "People") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([Person].self, from: items) {
                self.items = decoded
                return
            }
        }
        // else initialize to empty array
        self.items = []
    }
    
    // define methods to change person data ("index" refers to the index of the person)
    public func setName(newName: String, index: Int) {
        items[index].updateName(newName: newName)
    }
        
    public func setNotes(newNotes: String, index: Int) {
        items[index].updateNotes(newNotes: newNotes)
    }
    
    public func removeAtIndex(index: Int) {
        items.remove(at: index)
    }
    
    public func addFavorite(newFavorite: Favorite, index: Int) {
        items[index].addFavorite(newFavorite: newFavorite)
    }
}

struct ContentView: View {
    // don't think i need to instantiate the environment objects here but it doesn't hurt
    @EnvironmentObject var restaurants: Restaurants
    @EnvironmentObject var people: People
    
    var body: some View {
        VStack() {
            RestaurantScroll()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
