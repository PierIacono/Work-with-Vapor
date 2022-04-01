//
//  Error.swift
//  Concorrenza
//
//  Created by Pierluigi Iacono on 30/03/22.
//

import Foundation

//In caso di errori:

//Dichiariamo un Enum chiamato LearnerInfoError con il protocollo Error e LocalizedError entrambi i protocolli hanno lo scopo di identificare errori e lanciarli
enum InfoError: Error, LocalizedError {
    case itemNotFound, creationFailed, serverError

//    Vengono definiti 3 casi: itemNotFound, creationFailed e serverError con una variabile stringa che cambia valore in base all'errore
    
    var localizedDescription: String {
        switch self {
        case .itemNotFound:
            return "I could not find the item I was looking for, it could be a server problem or not..."
        case .creationFailed:
            return "I was unable to create the desired item, it could be a server problem or not..."
        case .serverError:
            return "This is definitely a server error, ask a mentor what is going on ..."
        }
    }
}

