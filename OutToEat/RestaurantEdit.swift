//
//  RestaurantEdit.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/7/20.
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import SwiftUI

extension View {

    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<SomeView: View>(to view: SomeView, when binding: Binding<Bool>) -> some View {
        modifier(NavigateModifier(destination: view, binding: binding))
    }
}


// MARK: - NavigateModifier
fileprivate struct NavigateModifier<SomeView: View>: ViewModifier {

    // MARK: Private properties
    fileprivate let destination: SomeView
    @Binding fileprivate var binding: Bool


    // MARK: - View body
    fileprivate func body(content: Content) -> some View {
        NavigationView {
            ZStack {
                content
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                NavigationLink(destination: destination
                    .navigationBarTitle("")
                    .navigationBarHidden(true),
                               isActive: $binding) {
                    EmptyView()
                }
            }
        }
    }
}

// TODO: addMode instead of presentationMode???
struct RestaurantEdit: View {
    @ObservedObject var restaurants: Restaurants
    var restaurant: Restaurant
    
    @State var name = ""
    @State var type = ""
    @State var notes = ""
    
    @Environment(\.presentationMode) var presentationMode
    @State var showScroll = false // keep track of whether we want to jump to the restaurant scroll view
    
    var body: some View {
        VStack {
            Divider().padding(.top, 10)
            
            HStack {
                Text("Name:").font(.title)
                Spacer()
                TextField(restaurant.name, text: $name).font(.title)
            }.padding(.horizontal, 10)
            
            Divider()
            
            HStack {
                Text("Type:").font(.title)
                Spacer()
                TextField(restaurant.type, text: $type).font(.title)
            }.padding(.horizontal, 10)
            
            Divider()
            
            HStack {
                Text("Notes:").font(.title)
                Spacer()
                TextField(restaurant.notes, text: $notes).font(.title)
            }.padding(.horizontal, 10)
            
            Spacer()
            
            Button("Delete") { // TODO: go back to main restaurants screen after deleting
                if(self.restaurants.items.firstIndex(of: self.restaurant) != nil) { // make sure there is actually something there to delete before attempting to do so
                    self.restaurants.removeAtIndex(index: self.restaurants.items.firstIndex(of: self.restaurant)!)
                }
                // self.presentationMode.wrappedValue.dismiss()
                self.showScroll = true
            }
            .padding(.bottom, 50)
            .font(.title)
            // .navigate(to: RestaurantScroll(), when: $showScroll)
            // .navigationBarHidden(true)
            // .navigationBarBackButtonHidden(true)
            
            
            NavigationLink(destination: RestaurantScroll(), isActive: $showScroll) {
                EmptyView()
            }
            
        } // end VStack
        .navigationBarTitle("Editing: \(restaurant.name)")
        .navigationBarItems(
            trailing:
                Button("Save") { // TODO: don't want to overwrite notes sooo figure something out for that
                    // this checks each box for empty values to determine whether to update or not
                    if !self.name.isEmpty {
                        self.restaurants.setName(newName: self.name, index: self.restaurants.items.firstIndex(of: self.restaurant)!)
                    }
                    if !self.type.isEmpty {
                        self.restaurants.setType(newType: self.type, index: self.restaurants.items.firstIndex(of: self.restaurant)!)
                    }
                    // TODO: 121 throws error if finds nil (when editing type and notes at same time on restaurant entry that has not been edited before). dont know why
                    if !self.notes.isEmpty {
                        self.restaurants.setNotes(newNotes: self.notes, index: self.restaurants.items.firstIndex(of: self.restaurant)!)
                    }
                    
                    self.presentationMode.wrappedValue.dismiss()
                }.font(.title)
        ) // end navigationBarItems
    } // end body
}


struct RestaurantEdit_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantEdit(restaurants: Restaurants(), restaurant: Restaurant(name: "", type: "", notes: ""))
    }
}

