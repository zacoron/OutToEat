//
//  OtherView.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/7/20.
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import SwiftUI

struct OtherView: View {
    var body: some View {
        VStack {
            Text("Out To Eat")
                .font(.largeTitle)
                .padding(.vertical, 150)
            
            Text("Brought to you by:")
                .font(.title)
                .padding(.vertical, 15)
            
            Text("Zack Smalley")
                .font(.title)
                .foregroundColor(Color.blue)
            
            Text("(my name isn't a button but the blue looks nice")
                .font(.subheadline)
            
            Spacer()
            
            Text("version 1.0")
                .foregroundColor(Color.gray)
                .padding()
        }
    }
}

struct OtherView_Previews: PreviewProvider {
    static var previews: some View {
        OtherView()
    }
}
