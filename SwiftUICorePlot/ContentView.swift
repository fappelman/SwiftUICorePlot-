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
    @State var uuid = UUID()

    var body: some View {
        VStack {
            CorePlot(plotData: $data)
                .focusable()
            Button("recompute", action: {
                data = Self.newPlotData()
                uuid = UUID()
            })
        }
        .id(uuid)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
