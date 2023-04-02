//
//  CategoryOverTime.swift
//  Sentimentalyst
//
//  Created by Jake Davies on 02/04/2023.
//

import SwiftUI
import Charts

protocol CategoricalPlottable: CustomStringConvertible, Hashable, Plottable {}

struct CategoryOverTime<C: CategoricalPlottable>: View {
    private let categories: [C]
    private let xLabel: String
    private let yLabel: String
    private let colorScheme: [C : Color]
    
    init(categories: [C], xLabel: String, yLabel: String, colorScheme: [C : Color] = [:]) {
        self.categories = categories
        self.xLabel = xLabel
        self.yLabel = yLabel
        self.colorScheme = colorScheme
    }
    
    var body: some View {
        Chart {
            ForEach(categories.indices, id: \.self) { index in
                let category = categories[index]
                BarMark(xStart: .value(xLabel, index + 1),
                        xEnd: .value(xLabel, index + 2),
                        y: .value(yLabel, category.description)
                )
                .foregroundStyle(colorScheme[category] ?? .blue)
            }
        }
        //.chartXScale(domain: 1...categories.count + 1)
        .chartXAxisLabel(xLabel, position: .bottom, alignment: .center)
    }
    
    
}
