//
//  Order2ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 17.12.2020.
//

import UIKit
import DSKit
import DSKitFakery

class Order2ViewController: DSViewController {
    
    var selectedMethod: String = "Standard Shipping"
    let faker = DSFaker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Order details"
        update()
    }
    
    func update() {
        show(content: orderInfo(), promoCodeSection(), totalsSection())
        showBottom(content: [bottomContentSection()])
    }
}

// MARK: - Order details

extension Order2ViewController {
    
    /// Oder info
    /// - Returns: DSSection
    func orderInfo() -> DSSection {
        
        let cart = card(title: "Cart",
                        description: "3 items\n$167.00",
                        icon: "cart.fill")
        
        let address = card(title: "Address",
                           description: "4863 West Virginia\nNew York, US",
                           icon: "mappin.circle.fill")
        
        let shipping = card(title: "Shipping",
                            description: "Standard Shipping\n2 weeks for $0",
                            icon: "shippingbox.fill")
        
        let payment = card(title: "Payment",
                           description: "MasterCard\n**** 8314",
                           icon: "creditcard.fill")
        
        return [cart, address, shipping, payment].grid().headlineHeader("Checkout Info", size: 14)
    }
    
    /// Card
    /// - Parameters:
    ///   - title: String
    ///   - description: String
    ///   - icon: String
    /// - Returns: DSViewModel
    func card(title: String, description: String, icon: String) -> DSViewModel {
        
        let composer = DSTextComposer(alignment: .center)
        composer.add(sfSymbol: icon, style: .custom(size: 28, weight: .semibold), tint: .headline, spacing: 10)
        composer.add(type: .headline, text: title, spacing: 5)
        composer.add(type: .subheadlineWithSize(14), text: description)
        var card = DSCardVM(composer: composer, textPosition: .center)
        card.height = .absolute(160)
        
        return card
    }
}

// MARK: - Totals

extension Order2ViewController {
    
    // Totals
    func promoCodeSection() -> DSSection {
        
        let icon = DSSFSymbolConfig.buttonIcon("tag.fill")
        let button = DSButtonVM(title: "Add promo code", icon: icon, type: .secondaryView) { [unowned self] _ in
            self.pop()
        }
        
        return button.list().headlineHeader("Promo Codes", size: 14)
    }
    
}

// MARK: - Totals

extension Order2ViewController {
    
    // Totals
    func totalsSection() -> DSSection {
        
        var viewModels = [DSViewModel]()
        
        viewModels.append(serviceRow(title: "Subtotal", price: DSPrice(amount: "160.00", currency: "$")))
        viewModels.append(serviceRow(title: "Shipping", price: DSPrice(amount: "4.70", currency: "$")))
        viewModels.append(serviceRow(title: "Fee", price: DSPrice(amount: "2.70", currency: "$")))
        viewModels.append(serviceRow(bold: true, title: "Total", price: DSPrice(amount: "164.70", currency: "$")))
        return viewModels.list(separator: true, grouped: true)
    }
    
    /// Row
    /// - Parameters:
    ///   - bold: Bool
    ///   - title: String
    ///   - price: DSPrice
    /// - Returns: DSViewModel
    func serviceRow(bold: Bool = false, title: String, price: DSPrice) -> DSViewModel {
        
        let composer = DSTextComposer()
        composer.add(type:  bold ? .headline : .subheadline, text: title)
        
        var action = composer.actionViewModel()
        action.rightPrice(price: price)
        
        return action
    }
}

// MARK: - Bottom Content

extension Order2ViewController {
    
    /// Bottom content section
    /// - Returns: DSSection
    func bottomContentSection() -> DSSection {
        
        let icon = DSSFSymbolConfig.buttonIcon( "checkmark.circle.fill")
        let button = DSButtonVM(title: "Confirm Order", icon: icon) { [unowned self] _ in
            self.pop()
        }
        
        var text = DSActiveTextVM(.subheadlineWithSize(14), text: "By pressing confirm order, you agree to our\nTerms and Privacy", alignment: .center)
        
        text.links = ["Terms": "http://dskit.app", "Privacy": "http://dskit.app"]
        
        let section = [text, button].list()
        return section
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct Order2ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: Order2ViewController(), ShopAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
