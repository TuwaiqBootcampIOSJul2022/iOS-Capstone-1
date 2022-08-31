//
//  DarkMode.swift
//  TaskListProject
//
//  Created by Anaal Albeeshi on 04/02/1444 AH.
//

import SwiftUI

struct DarkMode: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing: 20){
                    
                    Text("This text is P").foregroundColor(.primary)
                    Text("This text")
                    Text("This text").foregroundColor(.secondary)
                    Text("This text").foregroundColor(.black)
                    Text("This text").foregroundColor(.white)
                    Text("This text").foregroundColor(Color("AdaptiveColor"))
                        .foregroundColor(colorScheme == .light ? .black : .blue)
                }
            }
            .navigationTitle("Dark Mode")
        }
    }
}

struct DarkMode_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DarkMode()
                .preferredColorScheme(.light)
        }
        DarkMode()
            .preferredColorScheme(.dark)
    }
}
