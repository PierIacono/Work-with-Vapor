//
//  NetworkManager.swift
//  Concorrenza
//
//  Created by Pierluigi Iacono on 30/03/22.
//


import os
import SwiftUI

//Tipo enum per i metodi http
enum HTTPMethods: String {
    case post = "POST"
    case get = "GET"
    case delete = "DELETE"
    case put = "PUT"
}

class NetworkManager {
    
    private var urlComponents = URLComponents(string: "https://mc3-ws-http.herokuapp.com/")!
    lazy var jsonDecoder = JSONDecoder()
    lazy var jsonEncoder = JSONEncoder()
    lazy var logger = Logger(subsystem: "developer.NetworkManager", category: "ViewModel")

    
    
    private func getRequest(url: URL, method: HTTPMethods = HTTPMethods.get) -> URLRequest{
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        logger.log("Create a new URLRequest")
        return request
    }
    

    func getAllVoli() async -> [Volo]? {
    
        urlComponents.path = "/classroom"
        do {
            let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
            guard let httpResponse = response as? HTTPURLResponse,

                    httpResponse.statusCode == 200 else {
                    throw InfoError.creationFailed
                  }
            return try Volo.decodeVolo(from: data)
        }catch{
            logger.error("Error getting all Volo: \(error.localizedDescription)")
            return nil
        }
    }
    
//    POST VOLI
    func create(_ volo: Volo) async -> Volo? {
        
        urlComponents.path = "/classroom"

        guard let jsonData = try? JSONEncoder().encode(volo) else {
            logger.error("Error: Trying to convert model to JSON data Volo")
            return nil
        }

        var request = getRequest(url: urlComponents.url!, method: .post)
        request.httpBody = jsonData
        do {

            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200
            else {
                return nil
            }
            let newVolo = try Volo(data)
            return newVolo
        }catch{
            logger.error("Error create new volo: \(InfoError.creationFailed.localizedDescription)")
            return nil
        }
    }
    
    
    func getAllAeroporti() async -> [Aeroporto]? {

        urlComponents.path = "/classroom"
        do {
            let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
            guard let httpResponse = response as? HTTPURLResponse,

                    httpResponse.statusCode == 200 else {
                    throw InfoError.creationFailed
                    }
            return try Aeroporto.decodeAeroporto(from: data)
        }catch{
            logger.error("Error getting all Volo: \(error.localizedDescription)")
            return nil
        }
    }
    

    func create(_ aeroporto: Aeroporto) async -> Aeroporto? {

        urlComponents.path = "/classroom"

        guard let jsonData = try? JSONEncoder().encode(aeroporto) else {
            logger.error("Error: Trying to convert model to JSON data aeroporto")
            return nil
        }

        var request = getRequest(url: urlComponents.url!, method: .post)
        request.httpBody = jsonData
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200
            else {
                return nil
            }
            let newAeroporto = try Aeroporto(data: data)
            return newAeroporto
            
        }catch{
            logger.error("Error create new Aeroporto: \(InfoError.creationFailed.localizedDescription)")
            return nil
        }
    }
    
    func getAllAerei() async -> [Aereo]? {

        urlComponents.path = "/classroom"
        do {
            let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
            guard let httpResponse = response as? HTTPURLResponse,

                    httpResponse.statusCode == 200 else {
                    throw InfoError.creationFailed
                    }
            return try Aereo.decodeAereo(from: data)
        }catch{
            logger.error("Error getting all Aereo: \(error.localizedDescription)")
            return nil
        }
    }
    

    func create(_ aereo: Aereo) async -> Aereo? {

        urlComponents.path = "/classroom"
        guard let jsonData = try? JSONEncoder().encode(aereo) else {
            logger.error("Error: Trying to convert model to JSON data aeroporto")
            return nil
        }

        var request = getRequest(url: urlComponents.url!, method: .post)
        request.httpBody = jsonData
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200
            else {
                return nil
            }
            let newAereo = try Aereo(data: data)
            return newAereo
        }catch{
            logger.error("Error create new Aereo: \(InfoError.creationFailed.localizedDescription)")
            return nil
        }
    }
}
