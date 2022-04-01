//
//  File.swift
//  
//
//  Created by Pierluigi Iacono on 31/03/22.
//

import Fluent
import Vapor
import Foundation

final class Volo: Model, Content {
    static let schema = "volo"
    
    struct Volo: Content{
        
        let id : UUID
        let idA: UUID
        var aP : String
        var aD : String
        var oraP: Date
        var oraD: Date
    }
        
    @ID(key: "id")
    var id: UUID?
    
//    IdAereo
    @Field(key: "idA")
    var idA: UUID
    
//    Aeroporto Partenza
    @Field(key: "aP")
    var aP: String
    
    @Field(key: "aD")
    var aD: String
    
    @Timestamp(key: "oraP", on: .create)
    var oraP: Date?
    
    @Timestamp(key: "oraD", on: .create)
    var oraD: Date?
    
    init() {}
    
    init(id: UUID? , idA: UUID, aP: String, aD : String, oraP: Date, oraD: Date) {
      
        self.id = id
      self.idA = idA
      self.aP = aP
      self.aD = aD
      self.oraP = oraP
      self.oraD = oraD
    }

