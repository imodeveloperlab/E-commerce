//
//  Home1ViewController.swift
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

open class Home1ViewController: DSViewController {
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        update()
    }
    
    func update() {
        
        show(content: [userProfileSection(),
                       productsGallery(),
                       newArrivals()])
    }
}

// MARK: - User Profile

extension Home1ViewController {
    
    /// User profile section
    /// - Returns: DSSection
    func userProfileSection() -> DSSection {
        
        let composer = DSTextComposer()
        composer.add(type: .headlineWithSize(30), text: "Shop")
        composer.add(type: .subheadline, text: "Over 45k items available for you")
        
        var action = composer.actionViewModel()
        action.rightRoundImage(url: URL.profileUrl(), size: CGSize(width: 60, height: 60))
        action.style.displayStyle = .default
        
        return action.list()
    }
}

// MARK: - Gallery

extension Home1ViewController {
    
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

// MARK: - New arrivals

extension Home1ViewController {
    
    /// New arrivals
    /// - Returns: DSSection
    func newArrivals() -> DSSection {
        
        let composer = DSTextComposer()
        composer.add(type: .headline, text: "New Arrivals")
        var header = composer.actionViewModel()
        header.style.displayStyle = .default
        
        header.rightButton(title: "View all", sfSymbolName: "chevron.right", style: .medium) { [unowned self] in
            self.dismiss()
        }
        
        let newTrend = newArrival(title: "New trend", description: "Colourfull sneakers", imageUrl: URL.sneakersThreePairs)
        let shirts = newArrival(title: "Shirts", description: "Fresh prints of Bel-Air", imageUrl: URL.shirtsThreePairs)
        let shoes = newArrival(title: "Shoes", description: "Bring power to your...", imageUrl: URL.shoesThreePairs)
        let watches = newArrival(title: "Watches", description: "Time is what you make", imageUrl: URL.watchesOnYellowBg)
        let jeans = newArrival(title: "Jeans", description: "Quality newer goes down", imageUrl: URL.jeansOnBlackBg)
        let tShirts = newArrival(title: "T-Shirts", description: "Blink if you want me", imageUrl: URL.tShirtGirlOnYellowBg)
        
        let section = [newTrend, shirts, shoes, watches, jeans, tShirts].grid()
        section.header = header
        return section
    }
    
    /// New arrival view model
    /// - Parameters:
    ///   - title: String
    ///   - description: String
    ///   - imageUrl: URL?
    /// - Returns: DSViewModel
    func newArrival(title: String, description: String, imageUrl: URL?) -> DSViewModel {
        
        let composer = DSTextComposer(alignment: .natural)
        composer.add(type: .headlineWithSize(15), text: title)
        composer.add(type: .subheadlineWithSize(12), text: description)
        
        var action = composer.actionViewModel()
        action.topImage(url: imageUrl, height: .unknown, contentMode: .scaleAspectFill)
        action.height = .absolute(180)
        action.style.displayStyle = .default
        
        return action
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct Home1ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: Home1ViewController(), BlackToneAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
