//
//  AereoStore.swift
//  Concorrenza
//
//  Created by Pierluigi Iacono on 30/03/22.
//

import Foundation
import os
import SwiftUI

class AereoStore : ObservableObject{
    
    //  **************  MVVM    ************
        @Published var isFetching: Bool = false
        @Published var aerei: [Aereo] = []
        lazy var networkManager = NetworkManager()
        lazy var logger = Logger(subsystem: "developer.Aereo.AereoStore", category: "ViewModel")
        
        
        func getAllAerei() async {
            
            self.isFetching = true
            logger.info("Start Get all Aerei")
        
            let aerei = await networkManager.getAllAerei()
            self.aerei = aerei ?? []
            self.isFetching = false
            logger.info("Complete Get all Aerei")
        }
        

        func create(aereo: Aereo) async {
            self.isFetching = true
            
            logger.info("Start Create new aereo")
            let newAereo = await networkManager.create(aereo)
            if let newAereo = newAereo { self.aerei.append(newAereo)
            }
            
            self.isFetching = false
            logger.info("Complete Create new aereo")
        }
}
