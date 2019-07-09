//
//  NewsItem.swift
//  StretchMyHeader
//
//  Created by Cameron Mcleod on 2019-07-09.
//  Copyright © 2019 Cameron Mcleod. All rights reserved.
//

import Foundation
import UIKit

struct NewsItem {
    
    enum NewsCategory: String {
        case world = "World"
        case americas = "Americas"
        case europe = "Europe"
        case middleEast = "Middle East"
        case africa = "Africa"
        case asiaPacific = "Asia Pacific"
    }
    
    let category: NewsCategory
    let headline: String
    
    func categoryColor() -> UIColor {
        
        switch self.category {
        case .world:
            return UIColor.red
        case .americas:
            return UIColor.blue
        case .europe:
            return UIColor.green
        case .middleEast:
            return UIColor.yellow
        case .africa:
            return UIColor.orange
        case .asiaPacific:
            return UIColor.purple
        }
    }
}
