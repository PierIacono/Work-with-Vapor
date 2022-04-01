//
//  AeroportoStore.swift
//  Concorrenza
//
//  Created by Pierluigi Iacono on 30/03/22.
//

import Foundation
import os
import SwiftUI



class AeroportoStore: ObservableObject {

//  **************  MVVM    ************
    @Published var isFetching: Bool = false
    @Published var aeroporti: [Aeroporto] = []
    lazy var networkManager = NetworkManager()
    lazy var logger = Logger(subsystem: "developer.Volo.VoloStore", category: "ViewModel")
    
    
    func getAllAeroporti() async {
        
        self.isFetching = true
        logger.info("Start Get all Aeroporti")
    
        let aeroporti = await networkManager.getAllAeroporti()
        self.aeroporti = aeroporti ?? []
        self.isFetching = false
        
        logger.info("Complete Get all aeroporti")
    }
    

    func create(aeroporto: Aeroporto) async {
        self.isFetching = true
        
        logger.info("Start Create new aeroporto")

        let newAeroporto = await networkManager.create(aeroporto)
        
        if let newAeroporto = newAeroporto { self.aeroporti.append(newAeroporto)
        }
        self.isFetching = false
        logger.info("Complete Create new aeroporto")

    }
}
