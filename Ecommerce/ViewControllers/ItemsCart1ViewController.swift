//
//  ItemsCart1ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class ItemsCart1ViewController: DSViewController {
    
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
        composer.add(price: DSPrice.random(min: 2000, max: 3000), size: .large, newLine: false)
        
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

extension ItemsCart1ViewController {
    
    /// Products gallery
    /// - Returns: DSSection
    func productsSection() -> DSSection {
        
        // 1
        let product1 = product(title: "Beats Solo Pro",
                               description: "Active Noise Cancelling (ANC)",
                               image: p1Image)
        
        // 2
        let product2 = product(title: "iPhone 8",
                               description: "Apple Inc",
                               image: p2Image,
                               badge: "SALES")
        
        // 3
        let product3 = product(title: "DJI Mavic pro Drone",
                               description: "Mavic",
                               image: p3Image)
        
        // 4
        let product4 = product(title: "Macbook Air",
                               description: "256GB Space Gray Apple Inc",
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
        action.bottomSideView = quantityPickerSideView()
        
        // Handle did tap
        action.didTap { [unowned self] (_ :DSCardVM) in
            self.dismiss()
        }
        
        return action
    }
    
    /// Quantity picker
    /// - Returns: DSSideView
    func quantityPickerSideView() -> DSSideView {
        
        // Copy secondaryView colors and set as custom colors to picker
        var style = DSAppearance.shared.main.secondaryView
        style.button.background = appearance.secondaryView.text.headline.withAlphaComponent(0.8)
        
        let picker = DSQuantityPickerVM()
        picker.style.colorStyle = .custom(style)
        picker.quantityTextType = .subheadline
        picker.width = .absolute(140)
        picker.height = .absolute(20)
        picker.quantityPluralText = "Items"
        picker.quantitySingularText = "Item"
        
        picker.quantityDidIncrease = { [unowned self] q in
            self.itemsCount += 1
            self.updateTotalView()
        }
        
        picker.quantityDidDecrease = { [unowned self] q in
            if self.itemsCount != 0 {
                self.itemsCount -= 1
                self.updateTotalView()
            }
        }
        
        // Picker right button
        picker.rightButton(sfSymbolName: "trash.fill", style: .custom(size: 18, weight: .medium)) { [unowned self] in
            self.dismiss()
        }
        
        return DSSideView(view: picker)
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct ItemsCart1ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            let nav = DSNavigationViewController(rootViewController: ItemsCart1ViewController())
            PreviewContainer(VC: nav, ShopAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}

fileprivate let p1Image = URL(string: "https://images.pexels.com/photos/5081386/pexels-photo-5081386.jpeg?cs=srgb&dl=pexels-cottonbro-5081386.jpg&fm=jpg")

fileprivate let p2Image = URL(string: "https://images.pexels.com/photos/2207799/pexels-photo-2207799.jpeg?cs=srgb&dl=pexels-gije-cho-2207799.jpg&fm=jpg")
fileprivate let p3Image = URL(string: "https://images.pexels.com/photos/3945671/pexels-photo-3945671.jpeg?cs=srgb&dl=pexels-cottonbro-3945671.jpg&fm=jpg")
fileprivate let p4Image = URL(string: "https://images.pexels.com/photos/4498450/pexels-photo-4498450.jpeg?cs=srgb&dl=pexels-karolina-grabowska-4498450.jpg&fm=jpg")

