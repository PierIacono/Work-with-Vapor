//
//  Aereo.swift
//  Concorrenza
//
//  Created by Pierluigi Iacono on 30/03/22.
//

import Foundation

struct Aereo : Identifiable, Codable{
    
    let id : UUID
    var modello: String
    var capienza: Int
    var pilot : String
    
    init(modello : String, capienza: Int, pilot: String){
        self.id = UUID()
        self.modello = modello
        self.capienza = capienza
        self.pilot = pilot
    }
    
    init(data: Data) throws{
        let jsonDecoder = JSONDecoder()
        let aereo = try jsonDecoder.decode (Aereo.self, from: data)
        
        self.id = aereo.id
        self.modello = aereo.modello
        self.capienza = aereo.capienza
        self.pilot = aereo.pilot
    }
    
    init(aereo: Aereo){

        self.id = aereo.id
        self.modello = aereo.modello
        self.capienza = aereo.capienza
        self.pilot = aereo.pilot
    }
    
    static func decodeAereo(from data: Data) throws -> [Aereo] {
        let jsonDecoder = JSONDecoder()
        return try jsonDecoder.decode([Aereo].self, from: data)
    }
}
