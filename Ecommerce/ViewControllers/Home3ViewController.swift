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

open class Home3ViewController: DSViewController {
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        update()
    }
    
    func update() {
        
        show(content: [userProfileSection(),
                       productsGallery(),
                       categoriesSection(),
                       discountsSection()])
    }
}

// MARK: - User Profile

extension Home3ViewController {
    
    /// User profile section
    /// - Returns: DSSection
    func userProfileSection() -> DSSection {
        
        let composer = DSTextComposer()
        composer.add(type: .headlineWithSize(29), text: "Jane Doe")
        composer.add(type: .subheadline, text: "4 Items in cart")
        var action = composer.actionViewModel()
        action.rightRoundImage(url: URL.profileOnRedBg, size: CGSize(width: 60, height: 60))
        action.style.displayStyle = .default
        action.height = .absolute(60)
        
        return action.list()
    }
}

// MARK: - Gallery

extension Home3ViewController {
    
    /// Products gallery
    /// - Returns: DSSection
    func productsGallery() -> DSSection {
        
        let sneakers = DSImageVM(imageUrl: URL.personOnYellowBg, height: .absolute(200))
        let sneakers2 = DSImageVM(imageUrl: URL.sneakersBlackOnBlueBg, height: .absolute(200))
        let sneakers3 = DSImageVM(imageUrl: URL.sneakersThreePairs, height: .absolute(200))
        let pageControl = DSPageControlVM(type: .viewModels([sneakers, sneakers2, sneakers3]))
        
        return pageControl.list().zeroLeftRightInset()
    }
}

// MARK: - Categories

extension Home3ViewController {
    
    /// Products gallery
    /// - Returns: DSSection
    func categoriesSection() -> DSSection {
        
        let shoes = category(title: "Shoes")
        let shirts = category(title: "Shirts")
        let jeans = category(title: "Jeans")
        let watches = category(title: "Watches")
        
        let section = [shoes, shirts, jeans, watches].gallery(type: .default)
        
        return section
    }
    
    func category(title: String) -> DSViewModel {
        
        var category = DSLabelVM(.headlineWithSize(14), text: title, alignment: .center)
        category.width = .fractional(0.28)
        category.height = .absolute(40)
        category.style.displayStyle = .grouped(inSection: false)
        return category
    }
}

// MARK: - New arrivals

extension Home3ViewController {
    
    /// Discounts
    /// - Returns: DSSection
    func discountsSection() -> DSSection {
        
        let newTrend = discount(title: "New trend", description: "Colourful life", imageUrl: URL.personOnPurpleBg2)
        let shirts = discount(title: "Shirts", description: "Fresh prints of Bel-Air", imageUrl: URL.personOnPurpleBg)
        let shoes = discount(title: "Shoes", description: "Bring power to your LIFE", imageUrl: URL.sneakersOnBlackBg)
        let watches = discount(title: "Watches", description: "Time is what you make", imageUrl: URL.watchesOnYellowBg)
        let jeans = discount(title: "Jeans", description: "Quality newer goes down", imageUrl: URL.personOnBlueBg)
        let tShirts = discount(title: "T-Shirts", description: "Blink if you want me", imageUrl: URL.tShirtGirlOnYellowBg)
        
        let section = [jeans, tShirts, newTrend, shirts, shoes, watches].grid()
        section.header = header(title: "Discounts")
        return section
    }
    
    /// Discounts section
    /// - Parameters:
    ///   - title: String
    ///   - description: String
    ///   - imageUrl: URL?
    /// - Returns: DSViewModel
    func discount(title: String, description: String, imageUrl: URL?) -> DSViewModel {
        
        let composer = DSTextComposer(alignment: .natural)
        //composer.add(type: .headline, text: title)
        composer.add(type: .subheadline, text: description)
        
        let price = DSPrice.randomDiscountWithBadge()
        composer.add(price: price)
        
        var action = composer.actionViewModel()
        action.topImage(url: imageUrl, height: .unknown, contentMode: .scaleAspectFill)
        action.height = .absolute(180)
        
        return action
    }
}

// MARK: - Header

extension Home3ViewController {
    
    /// Header view model
    /// - Parameter title: String
    /// - Returns: DSViewModel
    func header(title: String) -> DSViewModel {
        
        // Text
        let composer = DSTextComposer()
        composer.add(type: .headline, text: title)
        
        // Header
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

struct Home3ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: Home3ViewController(), BlackToneAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
