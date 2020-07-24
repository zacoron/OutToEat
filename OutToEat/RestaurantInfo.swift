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
                
                /* *** LIST OF MATCHING PEOPLE THAT DOESNT QUITE WORK ***
                // swiftui (imo) doesn't handle loops very well (yet, hopefully). this section loops through each person , then each favorite of each person (i.e. nested for loops). in the inner HStack, i would have liked to define the indexes that i was looking at (from the loops iterations) but swiftui won't allow declarations inside view function builders so i "pretended" to add them as comments so i would know what i'm looking at. the if() statement is basically just using the indexes of each loop to look at every "favorite" name and compare it to the restaurant i am looking at. if they match, it presents a link to the respective "favorite" for whoever the match was found within. it's not a difficult concept, but swiftui apparently wants it to be
                List {
                    ForEach(people.items) { person in
                        Group { // bug in swiftui that requires grouping https://developer.apple.com/forums/thread/130783
                            ForEach(self.people.items[self.people.items.firstIndex(of: person)!].favorites) { favorite in
                                HStack {
                                    // let personIndex = self.people.items.firstIndex(of: person)
                                    // let favoriteIndex = self.people.items[self.people.items.firstIndex(of: person)!].favorites.firstIndex(of: favorite)
                                    
                                    
                                    if(self.people.items[self.people.items.firstIndex(of: person)!].favorites[self.people.items[self.people.items.firstIndex(of: person)!].favorites.firstIndex(of: favorite)!].restaurantName == self.restaurant.name) {
                                        NavigationLink(destination: InfoFavorite(favorite: favorite, person: person)) {
                                            Text(self.people.items[self.people.items.firstIndex(of: person)!].name)
                                        }
                                    }
                                    else {
                                        Text(self.people.items[self.people.items.firstIndex(of: person)!].name)
                                            .foregroundColor(Color.gray)
                                    }
                                    
                                }
                            }
                        }
                        
                    }
                }
                */
                
                
                List {
                    ForEach(people.items) { person in
                        Group { // bug in swiftui that requires grouping https://developer.apple.com/forums/thread/130783
                            if(self.determineIfMatchedFavorite(person: person)!) {
                                NavigationLink(destination: InfoFavorite(favorite: self.findFavorite(person: person)!, person: person)) {
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
            NavigationLink(destination: RestaurantEdit(restaurants: restaurants, restaurant: restaurant)) {
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
