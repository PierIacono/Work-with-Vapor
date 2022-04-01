//
//  VoloStore.swift
//  Concorrenza
//
//  Created by Pierluigi Iacono on 30/03/22.
//

//os: Coordinate the scheduling and synchronization of your app’s tasks, and log information to the console to diagnose issues.

import os
import SwiftUI
import Foundation

class VoloStore: ObservableObject {


    @Published var isFetching: Bool = false
    @Published var voli: [Volo] = []
    lazy var networkManager = NetworkManager()
    lazy var logger = Logger(subsystem: "developer.Volo.VoloStore", category: "ViewModel")
    
    
    func getAllVoli() async {
        
        self.isFetching = true
        logger.info("Start Get all voli")
        let voli = await networkManager.getAllVoli()
        self.voli = voli ?? []
        self.isFetching = false
        
        logger.info("Complete Get all voli")
    }
    
    func create(volo: Volo) async {
        self.isFetching = true
        
        logger.info("Start Create new Voli")

        let newVolo = await networkManager.create(volo)
        
        if let newVolo = newVolo { self.voli.append(newVolo)
        }
        self.isFetching = false
        logger.info("Complete Create new Voli")

    }
}
