//
//  PeopleScroll.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/7/20.
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import SwiftUI

struct PeopleScroll: View {
    @EnvironmentObject var people: People
    @EnvironmentObject var restaurants: Restaurants
    @State private var showingPeopleAdd = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(people.items) { item in // items are identifiable (by UUID) so no need to specify id
                    NavigationLink(destination: PeopleInfo(people: self._people, person: item)) {
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
            .navigationBarTitle("People - \(people.items.count)")
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

}

struct PeopleScroll_Previews: PreviewProvider {
    static var previews: some View {
        PeopleScroll()
    }
}
