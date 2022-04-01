//
//  Volo.swift
//  Concorrenza
//
//  Created by Pierluigi Iacono on 30/03/22.
//

import Foundation

struct Volo: Identifiable, Codable{
    
    let id : UUID
    let idA: UUID
    var aP : String
    var aD : String
    var oraP: Date
    var oraD: Date
    
    init(idA : UUID, aP: String, aD: String, oraP: Date, oraD: Date){
         self.id = UUID()
         self.idA = idA
         self.aP = aP
         self.aD = aD
         self.oraP = oraP
         self.oraD = oraD
     }
    init(_ data: Data) throws{
        
        let jsonDecoder = JSONDecoder()
        let volo = try jsonDecoder.decode (Volo.self, from: data)
        self.id = volo.id
        self.idA = volo.idA
        self.oraD = volo.oraD
        self.oraP = volo.oraP
        self.aD = volo.aD
        self.aP = volo.aD
    }
    
     init(volo : Volo){
         self.id = volo.id
         self.idA = volo.idA
         self.aP = volo.aP
         self.aD = volo.aD
         self.oraP = volo.oraP
         self.oraD = volo.oraD
     }
     
    static func decodeVolo(from data: Data) throws -> [Volo] {
        let jsonDecoder = JSONDecoder()
        return try jsonDecoder.decode([Volo].self, from: data)
    }
}
     
