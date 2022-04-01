//
//  FetchImageasync.swift
//  Concorrenza
//
//  Created by Pierluigi Iacono on 30/03/22.
//

import SwiftUI

struct FetchImageAsync: View {
    @State var image: UIImage?

    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
            } else {
                Text("Loading...")
            }
        }.onAppear {
            Task {
                do {
                    image = try await fetchImage()
                } catch {
                    print("Image loading failed: \(error)")
                }
            }
        }
    }

    //Funzione Asincrona che fetcha l'immagine
    func fetchImage() async throws -> UIImage? {
        
        //Definiamo un Task che ritorna un UIImage? (è come una funzione)
        let imageTask = Task { () -> UIImage? in
            
            //Salvo l'immagine tramite l'URL
            let imageURL = URL(string: "https://source.unsplash.com/random")!
            
            //Inizia l'accesso al network che ritorna un tipo Data
            print("Starting network request...")
            let (imageData, _) = try await URLSession.shared.data(from: imageURL)
            
            return UIImage(data: imageData)
        }
        
        //nometask.value ritorna il valore del task. Il try è nel caso in cui lancia errori mentre await aspetta che il task completa il suo processo
        return try await imageTask.value
    }
    
}

struct FetchImageAsync_Previews: PreviewProvider {
    static var previews: some View {
        FetchImageAsync()
    }
}
