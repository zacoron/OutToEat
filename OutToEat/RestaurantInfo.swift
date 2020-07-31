//
//  RestaurantInfo.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/6/20.
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import SwiftUI

struct RestaurantInfo: View {
    @EnvironmentObject var restaurants: Restaurants
    @EnvironmentObject var people: People
    var restaurant: Restaurant
    
    var body: some View {
        VStack { // might be able to add horizontal padding to VStack instead of each HStack
            HStack {
                Text("Name:").font(.title)
                Spacer()
                Text(restaurant.name).font(.title)
            }.padding(.horizontal, 10)
            
            Divider()
            
            HStack {
                Text("Type:").font(.title)
                Spacer()
                Text(restaurant.type).font(.title)
            }.padding(.horizontal, 10)
            
            Divider()
            
            HStack {
                Text("Notes:").font(.title)
                Spacer()
                Text(restaurant.notes).font(.title)
            }.padding(.horizontal, 10)
            
            Divider()
            
            VStack {
                HStack {
                    Text("People:").font(.title)
                    Spacer()
                }.padding(.horizontal, 10)
                
                List {
                    ForEach(people.items) { person in
                        Group { // bug in swiftui that requires grouping https://developer.apple.com/forums/thread/130783
                            if(self.determineIfMatchedFavorite(person: person)!) {
                                NavigationLink(destination: InfoFavorite(person: person, favorite: self.findFavorite(person: person)!)) {
                                    Text("\(person.name)")
                                }
                            }
                        }
                    }
                }
                
            }

            
            Spacer()
        } // end VStack
        .navigationBarTitle("Info")
        .navigationBarItems(trailing:
            NavigationLink(destination: RestaurantEdit(restaurant: restaurant)) {
                Text("Edit").font(.title)
            }
        ) // end navigationBarItems
    } // end body
    
    // determine if the given person has a favorite of the restaurant we are looking for
    func determineIfMatchedFavorite(person: Person) -> Bool? {
        for i in person.favorites {
            if(i.restaurantName == restaurant.name) {
                // return Text(person.name)
                return true
            }
            else {
                print("false \(i.personName) - \(restaurant.name) != \(i.restaurantName)")
            }
        }
        
        // return Text("")
        return false
    }
    
    // return the favorite of a given person (for use in nav link to directly find the favorite in question)
    func findFavorite(person: Person) -> Favorite? {
        for i in person.favorites {
            if(i.restaurantName == restaurant.name) {
                return i
            }
        }
        
        return nil
    }
}

struct RestaurantInfo_Previews: PreviewProvider {
    // @ObservedObject var restaurants: Restaurants
    static var previews: some View {
        RestaurantInfo(restaurant: Restaurant(name: "", type: "", notes: ""))
    }
}
