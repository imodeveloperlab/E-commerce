//
//  ItemsCart5ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class ItemsCart5ViewController: DSViewController {
    
    var itemsCount = 4
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Cart"
        update()
        
        updateTotalView()
    }
    
    // Call every time some data have changed
    func update() {
        show(content: productsSection())
    }
    
    /// Update total view
    func updateTotalView() {
        
        // Total label
        var totalText = DSLabelVM(.title2, text: "Total")
        let forString = "for \(itemsCount) \(itemsCount.getCorrectForm(singular: "Items", plural: "Items")) "
        
        // Text
        let composer = DSTextComposer(alignment: .right)
        composer.add(type: .subheadline, text: forString)
        composer.add(price: DSPrice.random(min: 400, max: 700), size: .large, newLine: false)
        
        // Price
        let priceVM = composer.textViewModel()
        totalText.supplementaryItems = [priceVM.asSupplementary(position: .rightCenter, offset: .custom(.zero))]
        
        // Continue button
        var button = DSButtonVM(title: "Checkout", icon: UIImage(systemName: "creditcard.fill"))
        button.didTap { [unowned self] (button: DSButtonVM) in
            self.pop()
        }
        
        showBottom(content: [trendingProductsSection(), [totalText, button].list()])
    }
}

// MARK: - Trending products

extension ItemsCart5ViewController {
    
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
    func trendingProduct(title: String, description: String, image: URL? = nil, badge: String? = nil) -> DSViewModel {
        
        // Text
        let composer = DSTextComposer(alignment: .natural)
        composer.add(type: .headlineWithSize(14), text: title)
        composer.add(price: DSPrice.random(), spacing: 5)
        
        // Action
        var action = composer.actionViewModel()
        action.leftImage(url: image, size: .size(.init(width: 60, height: 60)))
        action.width = .fractional(0.7)
        action.rightButton(sfSymbolName: "plus.circle.fill",
                           style: .custom(size: 18, weight: .regular)) { [unowned self] in
            self.dismiss()
        }
        
        action.height = .absolute(80)
        
        // Label
        if let badge = badge {
            action.supplementaryItems = [label(title: badge)]
        }
        
        // Handle did tap
        action.didTap { [unowned self] (_ :DSCardVM) in
            self.dismiss()
        }
        
        return action
    }
    
}

// MARK: - Products

extension ItemsCart5ViewController {
    
    /// Products gallery
    /// - Returns: DSSection
    func productsSection() -> DSSection {
        
        // 1
        let product1 = product(title: "Armani Blouse",
                               description: "Color: Gray, size: M",
                               image: p1Image, badge: "50%")
        
        // 2
        let product2 = product(title: "Dolce & Gabbana Dress",
                               description: "Color: Black, size: L",
                               image: p2Image)
        
        // 3
        let product3 = product(title: "Zara Blouse",
                               description: "Color: Red, size: L",
                               image: p3Image)
        
        // 4
        let product4 = product(title: "Dolce & Gabbana Dress",
                               description: "Apple Inc",
                               image: p4Image,
                               badge: "SALES")
        
        let section = [product1, product4, product3, product2].list()
        
        return section
    }
    
    /// Product
    /// - Parameters:
    ///   - title: String
    ///   - description: String
    ///   - image: URL?
    ///   - badge: String?
    /// - Returns: DSViewModel
    func product(title: String, description: String, image: URL? = nil, badge: String? = nil) -> DSViewModel {
        
        // Text
        let composer = DSTextComposer(alignment: .natural)
        composer.add(type: .headlineWithSize(16), text: title)
        composer.add(type: .subheadline, text: description)
        composer.add(price: DSPrice.random(), spacing: 5)
        composer.add(sfSymbol: "star.fill", style: .medium, tint: .custom(UIColor.systemYellow))        
        composer.add(type: .subheadline, text: " \(Int.random(in: 1...6))k reviews", newLine: false)

        // Action
        var action = composer.actionViewModel()
        action.leftImage(url: image, size: .size(.init(width: 70, height: 90)))
        action.rightButton(sfSymbolName: "minus.circle.fill",
                           style: .custom(size: 18, weight: .regular)) { [unowned self] in
            self.dismiss()
        }
        
        // Label
        if let badge = badge {
            action.supplementaryItems = [label(title: badge)]
        }
        
        // Handle did tap
        action.didTap { [unowned self] (_ :DSCardVM) in
            self.dismiss()
        }
        
        return action
    }
    
    /// Label supplementary view
    /// - Parameter title: String
    /// - Returns: DSSupplementaryView
    func label(title: String) -> DSSupplementaryView {
        
        let label = DSLabelVM(.headlineWithSize(10), text: title)
        let offset = appearance.groupMargins + 3
        let supView = DSSupplementaryView(view: label,
                                          position: .leftBottom,
                                          background: .primary,
                                          insets: .small,
                                          offset: .custom(.init(x: offset, y: offset)),
                                          cornerRadius: .custom(5))
        return supView
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct ItemsCart5ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            let nav = DSNavigationViewController(rootViewController: ItemsCart5ViewController())
            PreviewContainer(VC: nav, BlackToneAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}

fileprivate let p1Image = URL(string: "https://images.pexels.com/photos/3885502/pexels-photo-3885502.jpeg?cs=srgb&dl=pexels-gustavo-fring-3885502.jpg&fm=jpg")

fileprivate let p2Image = URL(string: "https://images.pexels.com/photos/374808/pexels-photo-374808.jpeg?cs=srgb&dl=pexels-burst-374808.jpg&fm=jpg")

fileprivate let p3Image = URL(string: "https://images.pexels.com/photos/6140100/pexels-photo-6140100.jpeg?cs=srgb&dl=pexels-furkanfdemir-6140100.jpg&fm=jpg")

fileprivate let p4Image = URL(string: "https://images.pexels.com/photos/1895913/pexels-photo-1895913.png?cs=srgb&dl=pexels-keli-santos-1895913.jpg&fm=jpg")

