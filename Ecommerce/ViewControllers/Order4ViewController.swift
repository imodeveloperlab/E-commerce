//
//  Order4ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 17.12.2020.
//

import UIKit
import DSKit
import DSKitFakery

class Order4ViewController: DSViewController {
    
    var selectedMethod: String = "Standard Shipping"
    let faker = DSFaker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Order details"
        update()
    }
    
    func update() {
        show(content: messageSection())
        showBottom(content: [trendingProductsSection(), bottomContentSection()])
    }
}

// MARK: - Bottom Content

extension Order4ViewController {
    
    /// Bottom content section
    /// - Returns: DSSection
    func messageSection() -> DSSection {
        return [DSSpaceVM(type: .custom(50))
                ,successIcon(),
                DSSpaceVM(type: .custom(30)),
                successMessage()].list()
    }
    
    /// Icon
    /// - Returns: DSViewModel
    func successIcon() -> DSViewModel {
        
        let icon: DSImageContent = .sfSymbol(name: "checkmark.circle.fill",
                                             style: .custom(size: 50, weight: .bold))
        
        var image = DSImageVM(imageValue: icon, contentMode: .scaleAspectFit)
        image.tintColor = .text(.custom(appearance.semanticGreenColor))
        image.height = .absolute(90)
        return image
    }
    
    /// Message
    /// - Returns: DSViewModel
    func successMessage() -> DSViewModel {
        
        let composer = DSTextComposer(alignment: .center)
        composer.add(type: .headlineWithSize(30), text: "It's Ordered")
        composer.add(type: .subheadline, text: "Hi John - thanks for your order,\nwe hope you enjoyed shopping\nwith us.")
        return composer.textViewModel()
    }
}

// MARK: - Bottom Content

extension Order4ViewController {
    
    /// Bottom content section
    /// - Returns: DSSection
    func bottomContentSection() -> DSSection {
        
        let icon = DSSFSymbolConfig.buttonIcon( "bag.fill")
        
        let button = DSButtonVM(title: "Continue Shopping", icon: icon, type: .secondaryView) { [unowned self] _ in
            self.dismiss()
        }
        
        return button.list()
    }
}

// MARK: - Trending products

extension Order4ViewController {
    
    /// Products gallery
    /// - Returns: DSSection
    func trendingProductsSection() -> DSSection {
        
        // 1
        let product1 = trendingProduct(title: "New Balance All Fits",
                                       description: "Balance",
                                       image: URL.sneakersWhiteOnYellowBg)
        
        // 2
        let product2 = trendingProduct(title: "Big Pony Mesh Shoes",
                                       description: "Rebook",
                                       image: URL.sneakersThreePairs)
        
        // 3
        let product3 = trendingProduct(title: "Mesh Long-Sleeve Sneakers All Fits",
                                       description: "Nike",
                                       image: URL.sneakersOnWhiteBg)
        
        let section = [product1, product3, product2].gallery()
        section.subheadlineHeader("You may also like")
        
        return section
    }
    
    /// Product
    /// - Parameters:
    ///   - title: String
    ///   - description: String
    ///   - image: URL?
    ///   - badge: String?
    /// - Returns: DSViewModel
    func trendingProduct(title: String, description: String, image: URL? = nil) -> DSViewModel {
        
        // Text
        let composer = DSTextComposer(alignment: .natural)
        composer.add(type: .headlineWithSize(14), text: title)
        composer.add(type: .subheadline, text: description)
        composer.add(price: DSPrice.random(), spacing: 5)
        
        // Action
        var action = composer.actionViewModel()
        action.leftImage(url: image, size: .size(.init(width: 80, height: 80)))
        
        action.width = .fractional(0.7)
        action.rightButton(sfSymbolName: "cart.fill.badge.plus",
                           style: .custom(size: 18, weight: .regular)) { [unowned self] in
            self.dismiss()
        }
        
        action.height = .absolute(110)
        
        // Handle did tap
        action.didTap { [unowned self] (_ :DSCardVM) in
            self.dismiss()
        }
        
        return action
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct Order4ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: Order4ViewController(), ShopAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
