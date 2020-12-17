//
//  CorePlot.swift
//  SwiftUICorePlot
//
//  Created by Fred Appelman on 14/12/2020.
//

import SwiftUI
import CorePlot

public struct CorePlot: NSViewRepresentable {
    private let oneDay : Double = 24 * 60 * 60
    @Binding var plotData: [Double]

    public func makeNSView(context: Context) -> CPTGraphHostingView {
        // self.plotData = newPlotData()

        let refDate = DateFormatter().date(from: "12:00 Dec 14, 2020")

        // Create graph
        let newGraph = CPTXYGraph(frame: .zero)

        let theme = CPTTheme(named: .darkGradientTheme)
        newGraph.apply(theme)

        // if let host = self.hostView {
        //     host.hostedGraph = newGraph
        // }
        let hostView = CPTGraphHostingView()
        hostView.hostedGraph = newGraph

        let plotSpace = newGraph.defaultPlotSpace as! CPTXYPlotSpace

        plotSpace.xRange = CPTPlotRange(location: 0.0, length: (oneDay * 5.0) as NSNumber)
        plotSpace.yRange = CPTPlotRange(location: 1.0, length: 3.0)

        let axisSet = newGraph.axisSet as! CPTXYAxisSet
        if let x = axisSet.xAxis {
            x.majorIntervalLength   = oneDay as NSNumber
            x.orthogonalPosition    = 2.0
            x.minorTicksPerInterval = 0
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            let timeFormatter = CPTTimeFormatter(dateFormatter:dateFormatter)
            timeFormatter.referenceDate = refDate
            x.labelFormatter            = timeFormatter
        }

        if let y = axisSet.yAxis {
            y.majorIntervalLength   = 0.5
            y.minorTicksPerInterval = 5
            y.orthogonalPosition    = oneDay as NSNumber

            y.labelingPolicy = .none
        }

        let dataSourceLinePlot = CPTScatterPlot(frame: .zero)
        dataSourceLinePlot.identifier = "Date Plot" as NSString

        if let lineStyle = dataSourceLinePlot.dataLineStyle?.mutableCopy() as? CPTMutableLineStyle {
            lineStyle.lineWidth              = 3.0
            lineStyle.lineColor              = .green()
            dataSourceLinePlot.dataLineStyle = lineStyle
        }

        // dataSourceLinePlot.dataSource = self
        dataSourceLinePlot.dataSource = context.coordinator
        newGraph.add(dataSourceLinePlot)

        // self.graph = newGraph
        return hostView
    }

    public func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self, data: plotData)
    }

    public func updateNSView(_ nsView: CPTGraphHostingView, context: Context) {
        guard let graph = nsView.hostedGraph as? CPTXYGraph else { return }
        context.coordinator.data = plotData
        graph.reloadData()
    }

    public class Coordinator: NSObject, CPTPlotDataSource {
        var data: [Double]
        let parent: CorePlot

        init(parent: CorePlot, data: [Double]) {
            self.parent = parent
            self.data = data
        }

        // MARK: - Plot Data Source Methods
        
        public func numberOfRecords(for plot: CPTPlot) -> UInt {
            return UInt(parent.plotData.count)
        }

        public func number(for plot: CPTPlot, field: UInt, record: UInt) -> Any?
        {
            switch CPTScatterPlotField(rawValue: Int(field))! {
            case .X:
                return (parent.oneDay * Double(record)) as NSNumber

            case .Y:
                return data[Int(record)] as NSNumber

            @unknown default:
                return nil
            }
        }
    }
}
