//
//  ContentView.swift
//  SwiftUICorePlot
//
//  Created by Fred Appelman on 14/12/2020.
//

import SwiftUI

struct ContentView: View {
    static func newPlotData() -> [Double]
    {
        var newData = [Double]()

        for _ in 0 ..< 10 {
            newData.append(1.2 * Double(arc4random()) / Double(UInt32.max) + 1.2)
        }

        return newData
    }

    @State var data: [Double] = Self.newPlotData()

    var body: some View {
        VStack {
            CorePlot(plotData: $data)
                .padding(left: 0)
                .padding(right: 0)
                .focusable()
            CorePlot(plotData: $data)
                .padding(left: 40)
                .padding(right: 50)
                .focusable()
            CorePlot(plotData: $data)
                .padding(bottom: 0)
                .padding(top: 60)
                .focusable()
            Divider()
            Button("recompute", action: {
                data = Self.newPlotData()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
