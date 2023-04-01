//
//  TextAnalyser.swift
//  Sentimentalyst
//
//  Created by Jake Davies on 01/04/2023.
//

import Foundation

protocol TextAnalyser {
    associatedtype Label
    
    var labelPerSentence: [Label] { get }
    
    var labelOverall: Label { get }
}
