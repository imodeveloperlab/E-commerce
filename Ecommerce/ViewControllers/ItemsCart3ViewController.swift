//
//  ItemsCart3ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class ItemsCart3ViewController: DSViewController {
    
    var itemsCount = 4
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Cart"
        update()
        
        // Filter
        let trash = UIBarButtonItem(image: UIImage(systemName: "trash.fill"),
                                    style: .plain,
                                    target: self,
                                    action: #selector(openFilters))
        
        let like = UIBarButtonItem(image: UIImage(systemName: "suit.heart.fill"),
                                   style: .plain,
                                   target: self,
                                   action: #selector(openFilters))
        
        navigationItem.rightBarButtonItems = [trash, like]
        
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
        composer.add(price: DSPrice.random(min: 2000, max: 3000), size: .medium, newLine: false)
    
        // Price
        let priceVM = composer.textViewModel()
        totalText.supplementaryItems = [priceVM.asSupplementary(position: .rightCenter, offset: .custom(.zero))]
        
        // Continue button
        var button = DSButtonVM(title: "Continue")
        button.didTap { [unowned self] (button: DSButtonVM) in
            self.pop()
        }
        
        showBottom(content: [totalText, button].list())
    }
    
    @objc func openFilters() {
        self.dismiss()
    }
    
    @objc func openSort() {
        self.dismiss()
    }
}

// MARK: - Products

extension ItemsCart3ViewController {
    
    /// Products gallery
    /// - Returns: DSSection
    func productsSection() -> DSSection {
        
        // 1
        let product1 = product(title: "iMac 2020",
                               description: "Apple Inc",
                               image: p1Image)
        
        // 2
        let product2 = product(title: "iPad",
                               description: "Apple Inc",
                               image: p2Image,
                               badge: "SALES")
        
        // 3
        let product3 = product(title: "Magic keyboard",
                               description: "Not by Apple",
                               image: p3Image)
        
        // 4
        let product4 = product(title: "Apple watch",
                               description: "Apple Inc",
                               image: p4Image)
        
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
        composer.add(rating: 4,
                     maximumValue: 5,
                     positiveSymbol: "star.fill",
                     negativeSymbol: "star",
                     style: .medium,
                     tint: .custom(.systemYellow),
                     spacing: 3)
        
        // Action
        var action = composer.actionViewModel()
        action.leftImage(url: image, size: .size(.init(width: 90, height: 100)))
        action.rightButton(sfSymbolName: "minus.circle.fill",
                           style: .custom(size: 18, weight: .regular)) { [unowned self] in
            self.dismiss()
        }
        
        // Handle did tap
        action.didTap { [unowned self] (_ :DSCardVM) in
            self.dismiss()
        }
        
        return action
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct ItemsCart3ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            let nav = DSNavigationViewController(rootViewController: ItemsCart3ViewController())
            PreviewContainer(VC: nav, BlackToneAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}

fileprivate let p1Image = URL(string: "https://images.unsplash.com/photo-1494173853739-c21f58b16055?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1301&q=80")
fileprivate let p2Image = URL(string: "https://images.unsplash.com/photo-1584695369221-3d8a8ebfeef0?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=2378&q=80")

fileprivate let p3Image = URL(string: "https://images.unsplash.com/photo-1562075950-23ba332df71c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80")
fileprivate let p4Image = URL(string: "https://images.unsplash.com/photo-1434493789847-2f02dc6ca35d?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1951&q=80")
