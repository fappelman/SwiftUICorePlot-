//
//  ContentView.swift
//  SwiftUICorePlot
//
//  Created by Fred Appelman on 14/12/2020.
//

import SwiftUI


struct ContentView: View {
    func newPlotData() -> [Double]
    {
        var newData = [Double]()

        for _ in 0 ..< 10 {
            newData.append(1.2 * Double(arc4random()) / Double(UInt32.max) + 1.2)
        }

        return newData
    }

    var body: some View {
        CorePlot(plotData: newPlotData())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
