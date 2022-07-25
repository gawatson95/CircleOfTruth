//
//  ColorExtension.swift
//  CircleOfTruth
//
//  Created by Grant Watson on 6/1/22.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
    static let progress = ColorProgress()
}

struct ColorTheme {
    let redBackground = Color("RedBackground")
    let orangeBackground = Color("OrangeBackground")
    let greenBackground = Color("GreenBackground")
    let background = Color("Background")
    let background2 = Color("Background2")
    let accent = Color("AccentColor")
    let listBackground = Color("ListBackground")
}

struct ColorProgress {
    let redProgress = Color("RedProgress")
    let orangeProgress = Color("OrangeProgress")
    let greenProgress = Color("GreenProgress")
}
