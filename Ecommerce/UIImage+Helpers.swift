//
//  UIImage+Helpers.swift
//  DSKit+EcommerceDemo
//
//  Created by Borinschi Ivan on 23.03.2021.
//  Copyright © 2021 Borinschi Ivan. All rights reserved.
//

import UIKit

extension UIImage {
    static func named(_ name: String) -> UIImage? {
        UIImage(named: name, in: Bundle(for: Home1ViewController.classForCoder()), compatibleWith: nil)
    }
}
