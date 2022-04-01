//
//  Aeroporto.swift
//  Concorrenza
//
//  Created by Pierluigi Iacono on 30/03/22.
//

import Foundation

struct Aeroporto : Identifiable, Codable{
    
    let id : UUID
    var name: String
    
    init(name: String){
        self.id = UUID()
        self.name = name
    }
    
    init(data: Data) throws{
        let jsonDecoder = JSONDecoder()
        let aeroporto = try jsonDecoder.decode (Aeroporto.self, from: data)
        
        self.id = aeroporto.id
        self.name = aeroporto.name
    }
    static func decodeAeroporto(from data: Data) throws -> [Aeroporto] {
        let jsonDecoder = JSONDecoder()
        return try jsonDecoder.decode([Aeroporto].self, from: data)
    }
}
