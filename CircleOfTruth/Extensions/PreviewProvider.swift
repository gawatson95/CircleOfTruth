//
//  PreviewProvider.swift
//  CircleOfTruth
//
//  Created by Grant Watson on 6/2/22.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
    
}

class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    private init() { }
    
    let homeVM = HomeVM()
}
