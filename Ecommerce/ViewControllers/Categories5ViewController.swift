//
//  Categories5ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class Categories5ViewController: DSViewController {
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Categories"
        update()
    }
    
    func update() {
        show(content: shoesSection(), accessoriesSection(), jeansSection())
    }
}

// MARK: - Shoes Section

extension Categories5ViewController {

    func shoesSection() -> DSSection {
        
        // 1
        let sneakers = product(title: "Rez Casual Sneakers",
                               description: "Tommy Hilfiger",
                               image: URL.sneakersBlackOnBlueBg)
        
        // 2
        let sneakers2 = product(title: "Ward Low Sneakers",
                                description: "Vans",
                                image: URL.sneakersWhiteOnYellowBg)
        
        // 3
        let sneakers3 = product(title: "Air Max Motion",
                                description: "Nike",
                                image: URL.sneakersThreePairs)
        
        let section = [sneakers, sneakers2, sneakers3].gallery()
        section.header = header(title: "Shoes")
        return section
    }
}

// MARK: - Accessories Section

extension Categories5ViewController {
    
    func accessoriesSection() -> DSSection {
        
        // 1
        let product1 = product(title: "Lakme Insta Eye Liner",
                               description: "Lakme",
                               image: a1)
        
        // 2
        let product2 = product(title: "Translucent Loose",
                               description: "Laura Mecin",
                               image: a2)
        
        // 3
        let product3 = product(title: "Kajal with Liner Magique",
                               description: "L'Oreal",
                               image: a3)
        
        let section = [product2, product3, product1].gallery()
        section.header = header(title: "Accessories")
        return section
    }
}

// MARK: - Jeans Section

extension Categories5ViewController {

    func jeansSection() -> DSSection {
        
        // 1
        let product1 = product(title: "Krista Super Skinny",
                               description: "HUDSON Jeans",
                               image: j1)
        
        // 2
        let product2 = product(title: "High Rise Skinny Jeans",
                               description: "Madewell",
                               image: j2)
        
        // 3
        let product3 = product(title: "Kajal with Liner Magique",
                               description: "L'Oreal",
                               image: j3)
        
        let section = [product3, product1, product2].gallery()
        section.header = header(title: "Jeans")
        return section
    }
}

// MARK: - Product

extension Categories5ViewController {

    /// P
    /// - Parameters:
    ///   - title: String
    ///   - description: String
    ///   - image: String
    /// - Returns: DSViewModel
    func product(title: String, description: String, image: URL?) -> DSViewModel {
        
        let composer = DSTextComposer(alignment: .natural)
        composer.add(type: .headlineWithSize(14), text: title)
        composer.add(type: .subheadline, text: description)
        composer.add(price: DSPrice.random())
        
        var action = composer.actionViewModel()
        action.topImage(url: image)
        action.height = .absolute(200)
        action.width = .fractional(0.45)
        action.style.displayStyle = .default
        
        // Handle tap
        action.didTap { [unowned self] (_ :DSActionVM) in
            self.dismiss()
        }
     
        return action
    }
}

// MARK: - Header

extension Categories5ViewController {
    
    /// Header view model
    /// - Parameter title: String
    /// - Returns: DSViewModel
    func header(title: String) -> DSViewModel {
        
        let composer = DSTextComposer()
        composer.add(type: .headlineWithSize(20), text: title)
        var header = composer.actionViewModel()
        header.style.displayStyle = .default

        header.rightButton(title: "View all", sfSymbolName: "chevron.right", style: .medium) { [unowned self] in
            self.dismiss()
        }
        
        return header
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct Categories5ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: Categories5ViewController(), BlackToneAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}

fileprivate let j1 = URL(string: "https://images.pexels.com/photos/4505458/pexels-photo-4505458.jpeg?cs=srgb&dl=pexels-cottonbro-4505458.jpg&fm=jpg")

fileprivate let j2 = URL(string: "https://images.pexels.com/photos/1598507/pexels-photo-1598507.jpeg?cs=srgb&dl=pexels-mnz-1598507.jpg&fm=jpg")

fileprivate let j3 = URL(string: "https://images.pexels.com/photos/1082526/pexels-photo-1082526.jpeg?cs=srgb&dl=pexels-mica-asato-1082526.jpg&fm=jpg")

fileprivate let a1 = URL(string: "https://images.pexels.com/photos/1554740/pexels-photo-1554740.jpeg?cs=srgb&dl=pexels-myicahel-tamburini-1554740.jpg&fm=jpg")

fileprivate let a2 = URL(string: "https://images.pexels.com/photos/1926620/pexels-photo-1926620.jpeg?cs=srgb&dl=pexels-marcelo-moreira-1926620.jpg&fm=jpg")

fileprivate let a3 = URL(string: "https://images.pexels.com/photos/4355346/pexels-photo-4355346.jpeg?cs=srgb&dl=pexels-murat-esibatir-4355346.jpg&fm=jpg")
