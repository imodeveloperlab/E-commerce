//
//  ItemsCart2ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class ItemsCart2ViewController: DSViewController {
    
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
        composer.add(price: DSPrice.random(min: 2000, max: 3000), size: .large, newLine: false)
        
        // Price
        let priceVM = composer.textViewModel()
        totalText.supplementaryItems = [priceVM.asSupplementary(position: .rightCenter, offset: .custom(.zero))]
        
        // Continue button
        var button = DSButtonVM(title: "Checkout", icon: UIImage(systemName: "cart.fill"))
        button.didTap { [unowned self] (button: DSButtonVM) in
            self.pop()
        }
        
        showBottom(content: [totalText, button].list())
    }
}

// MARK: - Products

extension ItemsCart2ViewController {
    
    /// Products gallery
    /// - Returns: DSSection
    func productsSection() -> DSSection {
        
        // 1
        let product1 = product(title: "Sony XDE F30 Camera",
                               description: "Sony",
                               image: p1Image)
        
        // 2
        let product2 = product(title: "Cannon Camera",
                               description: "Cannon",
                               image: p2Image,
                               badge: "SALES")
        
        let section = [product1, product2].list()
        
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
        composer.add(price: DSPrice.random(min: 300, max: 400), spacing: 5)
        
        // Action
        var action = composer.actionViewModel()
        action.topImage(url: image, height: .equalTo(200))
        
        action.rightButton(title: "Remove",
                           sfSymbolName: "minus.circle.fill",
                           style: .medium) { [unowned self] in
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

struct ItemsCart2ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            let nav = DSNavigationViewController(rootViewController: ItemsCart2ViewController())
            PreviewContainer(VC: nav, BlackToneAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}

fileprivate let p1Image = URL(string: "https://images.unsplash.com/photo-1568605560195-9f979ffc11ce?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80")

fileprivate let p2Image = URL(string: "https://images.unsplash.com/photo-1536627217140-899b0bc9d881?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=2110&q=80")
