//
//  AppView.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/7/20.
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

struct Favorite: Identifiable, Codable, Equatable {
    let id = UUID()
    var personName: String
    var personUUID: UUID
    var restaurantName: String
    var restaurantUUID: UUID
    var order: String
    var cost: Double
    var notes: String
}

struct Person: Identifiable, Codable, Equatable {
    let id = UUID()
    var name: String
    var notes: String
    var favorites = [Favorite]() // TODO: change favorite to array of restaurants (or restaurant UUID's)
    
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
    @Published var items = [Person]() {
        didSet {
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
    
    public func addFavorite(newFavorite: Favorite, index: Int) {
        items[index].addFavorite(newFavorite: newFavorite)
    }
}

struct AppView: View {
    var body: some View {
        TabView {
            RestaurantScroll()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Restaurants")
                }
            
            PeopleScroll()
                .tabItem {
                    Image(systemName: "person.2")
                    Text("People")
                }
            
            OtherView()
                .tabItem {
                    Image(systemName: "tortoise")
                    Text("Other")
            }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    // static let people = PeopleScroll()
    static var previews: some View {
        AppView() // .environmentObject(people)
    }
}
