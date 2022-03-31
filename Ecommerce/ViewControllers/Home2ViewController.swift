//
//  Home2ViewController.swift
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

open class Home2ViewController: DSViewController {
    
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

extension Home2ViewController {
    
    /// User profile section
    /// - Returns: DSSection
    func userProfileSection() -> DSSection {
        
        let composer = DSTextComposer()
        composer.add(type: .headlineWithSize(30), text: "Your Shop")
        var action = composer.actionViewModel()
        action.rightRoundImage(url: URL.profileUrl(), size: CGSize(width: 50, height: 50))
        action.style.displayStyle = .default
        return action.list()
    }
}

// MARK: - Gallery

extension Home2ViewController {
    
    /// Products gallery
    /// - Returns: DSSection
    func productsGallery() -> DSSection {
        
        let sneakers = DSImageVM(imageUrl: URL.sneakersWhiteOnYellowBg, height: .absolute(200))
        let sneakers2 = DSImageVM(imageUrl: URL.sneakersBlackOnBlueBg, height: .absolute(200))
        let sneakers3 = DSImageVM(imageUrl: URL.sneakersThreePairs, height: .absolute(200))
        let pageControl = DSPageControlVM(type: .viewModels([sneakers, sneakers2, sneakers3]))
        
        return pageControl.list().zeroLeftRightInset()
    }
}

// MARK: - Categories

extension Home2ViewController {
    
    /// Products gallery
    /// - Returns: DSSection
    func categoriesSection() -> DSSection {
        
        let shoes = category(title: "Shoes")
        let shirts = category(title: "Shirts")
        let jeans = category(title: "Jeans")
        let watches = category(title: "Watches")
        let section = [shoes, shirts, jeans, watches].grid()
        section.header = header(title: "Categories")
        
        return section
    }
    
    func category(title: String) -> DSViewModel {
        return DSActionVM(title: title)
    }
}

// MARK: - New arrivals

extension Home2ViewController {
    
    /// Discounts
    /// - Returns: DSSection
    func discountsSection() -> DSSection {
        
        let newTrend = discount(title: "New trend", description: "Colourfull sneakers", imageUrl: URL.sneakersThreePairs)
        let shirts = discount(title: "Shirts", description: "Fresh prints of Bel-Air", imageUrl: URL.shirtsThreePairs)
        let shoes = discount(title: "Shoes", description: "Bring power to your...", imageUrl: URL.shoesThreePairs)
        let watches = discount(title: "Watches", description: "Time is what you make", imageUrl: URL.watchesOnYellowBg)
        let jeans = discount(title: "Jeans", description: "Quality newer goes down", imageUrl: URL.jeansOnBlackBg)
        let tShirts = discount(title: "T-Shirts", description: "Blink if you want me", imageUrl: URL.tShirtGirlOnYellowBg)
        let section = [newTrend, shirts, shoes, watches, jeans, tShirts].grid()
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
        composer.add(type: .headline, text: title)
        composer.add(type: .subheadline, text: description)
        
        let price = DSPrice.randomDiscount()
        composer.add(price: price)
        
        var action = composer.actionViewModel()
        action.topImage(url: imageUrl, height: .unknown, contentMode: .scaleAspectFill)
        action.height = .absolute(180)
        action.style.displayStyle = .default
        
        return action
    }
}

// MARK: - Header

extension Home2ViewController {
    
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

struct Home2ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: Home2ViewController(), BlackToneAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
