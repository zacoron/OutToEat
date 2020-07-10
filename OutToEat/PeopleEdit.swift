//
//  PeopleEdit.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/9/20.
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import SwiftUI

struct PeopleEdit: View {
    @ObservedObject var people: People
    var person: Person
    
    var body: some View {
        Text("People Edit")
    }
}

struct PeopleEdit_Previews: PreviewProvider {
    static var previews: some View {
        PeopleEdit(people: People(), person: Person(name: "", notes: ""))
    }
}
