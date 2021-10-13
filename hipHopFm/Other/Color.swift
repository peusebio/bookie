//
//  Color.swift
//  hipHopFm
//
//  Created by Pedro Eusébio on 03/06/2021.
//

import UIKit

//122, 173, 255 - light blue
//143, 147, 255 - light purple
//

class Color {
    
    static var artistNameTextColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
    
    static func random() -> UIColor{
        let random = Int.random(in: 0...2)
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 1
        switch random {
        case 0:
            red = 220
            green = randomRGBColorLevel()
            blue = randomRGBColorLevel()
            break
        case 1:
            green = 220
            red = randomRGBColorLevel()
            blue = randomRGBColorLevel()
            break
        case 2:
            blue = 220
            red = randomRGBColorLevel()
            green = randomRGBColorLevel()
            break
        default:
            print("Random: \(random)")
        }
        
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 0.85)
    }
    
    static func randomRGBColorLevel() -> CGFloat{
        return CGFloat.random(in: 100...200)
    }
}
