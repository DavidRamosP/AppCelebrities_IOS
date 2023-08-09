//
//  ButtonExtension.swift
//  appCelebrities
//
//  Created by DavidEmanuel on 7/10/23.
//

import UIKit

extension UIButton {
    
    func round(){
        
        layer.cornerRadius = 10
        clipsToBounds = true
        
    }
}
