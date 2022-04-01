//
//  ContentView.swift
//  Concorrenza
//
//  Created by Pierluigi Iacono on 30/03/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                Task {
                    await executeTask()
                }
            }
    }

    func executeTask() async {
        let basicTask = Task {
            return "This is the result of the task"
        }
        print(await basicTask.value)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
