//
//  Home3ViewController.swift
//  DSKit
//
//  Docs https://dskit.app/components
//  Get started: https://dskit.app/get-started
//  Layout: https://dskit.app/layout
//  Appearance: https://dskit.app/appearance
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class Home4ViewController: DSViewController {
    
    var selected = "Nike"
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        update()
    }
    
    func update() {
        
        show(content: [userProfileSection(),
                       productsGallery(),
                       categoriesSection(),
                       productsSection()])
    }
}

// MARK: - User Profile

extension Home4ViewController {
    
    /// User profile section
    /// - Returns: DSSection
    func userProfileSection() -> DSSection {
        
        let composer = DSTextComposer()
        composer.add(type: .headlineWithSize(25), text: "Shoes Shop")
        composer.add(type: .subheadline, text: "You have ")
        
        composer.add(badge: "4",
                     type: .text(font: .subheadline, color: .white),
                     backgroundColor: appearance.brandColor, cornerRadius: 10, newLine: false)
        
        composer.add(type: .subheadline,
                     text: " items in your cart",
                     newLine: false)
        
        var action = composer.actionViewModel()
        action.rightRoundImage(url: URL.profileOnYellowBg, size: CGSize(width: 55, height: 55))
        
        action.style.displayStyle = .default
        return action.list()
    }
}

// MARK: - Gallery

extension Home4ViewController {
    
    /// Products gallery
    /// - Returns: DSSection
    func productsGallery() -> DSSection {
        
        // 1
        var sneakers = DSImageVM(imageUrl: URL.sneakersOnWhiteBg, height: .absolute(200))
        sneakers.supplementaryItems = [label(title: "Nike", subtitle: "Top quality")]
        
        // 2
        var sneakers2 = DSImageVM(imageUrl: URL.sneakersWhiteOnYellowBg, height: .absolute(200))
        sneakers2.supplementaryItems = [label(title: "Converse", subtitle: "All the stars in the world")]
        
        // 3
        var sneakers3 = DSImageVM(imageUrl: URL.sneakersThreePairs, height: .absolute(200))
        sneakers3.supplementaryItems = [label(title: "Love", subtitle: "Bring the future to light")]
        
        let pageControl = DSPageControlVM(type: .viewModels([sneakers, sneakers2, sneakers3]))
        return pageControl.list().zeroLeftRightInset()
    }
    
    /// Supplementary view label
    /// - Parameters:
    ///   - title: Title
    ///   - subtitle: Subtitle
    ///   - color: Color
    ///   - position: Position
    /// - Returns: DSSupplementaryView
    func label(title: String,
               subtitle: String,
               color: UIColor = .black) -> DSSupplementaryView {
        
        let composer = DSTextComposer(alignment: .right)
        composer.add(type: .headlineWithSize(20), text: title)
        composer.add(type: .headlineWithSize(12), text: subtitle, spacing: 6)
        
        return composer.textViewModel().asSupplementary(position: .rightBottom,
                                                        background: .lightBlur,
                                                        insets: .interItemSpacing,
                                                        cornerRadius: .custom(5))
    }
}

// MARK: - Categories

extension Home4ViewController {
    
    /// Products gallery
    /// - Returns: DSSection
    func categoriesSection() -> DSSection {
        
        let nike = product(title: "Nike", count: 12)
        let puma = product(title: "Puma", count: 42)
        let vans = product(title: "Vans", count: 32)
        let crocs = product(title: "Crocs", count: 45)
        
        let section = [nike, puma, crocs, vans].gallery()
        return section
    }
    
    /// Product
    /// - Parameters:
    ///   - title: String
    ///   - count: Int
    /// - Returns: DSViewModel
    func product(title: String, count: Int) -> DSViewModel {
        
        let selected = title == self.selected
        
        let composer = DSTextComposer(alignment: .center)
        
        composer.add(type: .headline, text: "\(title) ")
        composer.add(badge: count.string(),
                     type: .body,
                     backgroundColor: appearance.primaryView.background,
                     cornerRadius: 10,
                     newLine: false)
        
        var category = composer.actionViewModel()
        
        if selected {
            
            var colors = DSAppearance.shared.main.secondaryView
            colors.background = colors.button.background
            colors.text.headline = colors.button.title
            colors.text.subheadline = colors.button.title
            category.style.colorStyle = .custom(colors)
            
        }
        
        category.width = .fractional(0.3)
        category.style.displayStyle = .grouped(inSection: false)
        
        category.didTap { [unowned self] (_: DSActionVM) in
            self.selected = title
            self.update()
        }
        
        return category
    }
}

// MARK: - Products

extension Home4ViewController {
    
    /// Discounts
    /// - Returns: DSSection
    func productsSection() -> DSSection {
        
        let prod1 = product(title: "Total Orange", description: "Air Max 95 x Kim Jones", imageName: "nike_1")
        let prod2 = product(title: "All-Star", description: "Kobe 6 Protro", imageName: "nike_2")
        let prod3 = product(title: "Bacon", description: "Air Max 90", imageName: "nike_5")
        let prod4 = product(title: "Midnight Navy", description: "Air Jordan 3", imageName: "nike_6")
        let prod5 = product(title: "College Navy", description: "Women's Dunk Low", imageName: "nike_3")
        let prod6 = product(title: "Black", description: "Dunk Low", imageName: "nike_4")
        
        let section = [prod1, prod2, prod3, prod4, prod5, prod6].shuffled().grid()
        
        section.header = header(title: "Sneakers")
        return section
    }
    
    /// Discounts section
    /// - Parameters:
    ///   - title: String
    ///   - description: String
    ///   - imageUrl: URL?
    /// - Returns: DSViewModel
    func product(title: String, description: String, imageName: String) -> DSViewModel {
        
        // Composer
        let composer = DSTextComposer(alignment: .natural)
        composer.add(type: .headline, text: title)
        composer.add(type: .subheadline, text: description)
        composer.add(price: DSPrice.random())
        
        // Transform composer to action view model
        var action = composer.actionViewModel()
        
        let image = UIImage(named: imageName,
                            in: Bundle(for: self.classForCoder),
                            compatibleWith: nil)
        
        action.topImage(image: image)
        
        action.height = .absolute(200)
        
        return action
    }
}

// MARK: - Header

extension Home4ViewController {
    
    /// Header view model
    /// - Parameter title: String
    /// - Returns: DSViewModel
    func header(title: String) -> DSViewModel {
        
        let composer = DSTextComposer()
        composer.add(type: .headline, text: title)
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

struct Home4ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: Home4ViewController(), BlackToneAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
