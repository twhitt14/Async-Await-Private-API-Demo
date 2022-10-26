//
//  ContentView.swift
//  Async Await Private API Demo
//
//  Created by Trevor Whittingham on 10/25/22.
//

import SwiftUI

struct ContentView: View {
    
    @State
    var people: [StarWarsPerson] = []
    
    @State var isLoading = false
    
    var body: some View {
        List {
            if isLoading {
                Text("Loading")
            } else {
                LazyVStack(alignment: .leading) {
                    ForEach(people) { person in
                        Text(person.name)
                            .backgroundStyle(.white)
                            .padding()
                    }
                }
            }
        }
        .onAppear {
            Task {
                isLoading = true
                people = try await AsyncAPI().loadPeopleAsync()
                isLoading = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
