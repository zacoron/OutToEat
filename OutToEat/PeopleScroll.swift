//
//  PeopleScroll.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/7/20.
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import SwiftUI

struct Person: Identifiable, Codable, Equatable {
    let id = UUID()
    var name: String
    var notes: String
    var favorites = [String]() // TODO: change favorite to array of restaurants (or restaurant UUID's)
    
    // define methods to update elements of the struct
    public mutating func updateName(newName: String) {
        self.name = newName
    }
    
    public mutating func updateNotes(newNotes: String) {
        self.notes = newNotes
    }
    
    public mutating func addFavorite(newFavorite: String) {
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
    
    public func addFavorite(newFavorite: String, index: Int) {
        items[index].addFavorite(newFavorite: newFavorite)
    }
}

struct PeopleScroll: View {
    @ObservedObject var people = People()
    @State private var showingPeopleAdd = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(people.items) { item in // items are identifiable (by UUID) so no need to specify id
                    NavigationLink(destination: PeopleInfo(people: self.people, person: item)) {
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
            .navigationBarTitle("People")
            .navigationBarItems(
                trailing:
                    Button(action: {
                        self.showingPeopleAdd = true
                    }) {
                        Image(systemName: "plus").font(.title)
                    }
            ) // end navigationBarItems
            .sheet(isPresented: $showingPeopleAdd) {
                PeopleAdd(people: self.people)
            }
        } // end NavigationView
    }
    
    /* dont need anymore
    func removeItems(at offsets: IndexSet) {
        people.items.remove(atOffsets: offsets)
    }
    */
}

struct PeopleScroll_Previews: PreviewProvider {
    static var previews: some View {
        PeopleScroll()
    }
}
