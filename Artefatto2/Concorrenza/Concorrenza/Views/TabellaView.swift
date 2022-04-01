//
//  Tabella.swift
//  Concorrenza
//
//  Created by Pierluigi Iacono on 31/03/22.

import Foundation
import SwiftUI
import os

struct TabellaView: View {
        
    @State var searchText = ""
    @StateObject var voloStore = VoloStore()
        
        var body: some View {
            NavigationView{
                
                List {
                    Text(searchText)
                        .searchable(text: $searchText)
                        .opacity(0)
                        .listRowBackground(Color.clear)
                    ForEach(voloStore.voli) { volo in
                            HStack {
                                VStack{
                                    Text("")
                                }
                                VStack{
                                    
                                    
                                }
                                VStack{
                                    
                                    
                                }
                            }
                        }
                        .navigationTitle("Tabella Voli")
            }
            .task {
                    if !self.voloStore.isFetching {
                        await voloStore.getAllVoli()
                    }
            }
            }.navigationViewStyle(.stack)
        }
}



struct TabellaView_Previews: PreviewProvider {
    static var previews: some View {
        TabellaView()
    }
}
