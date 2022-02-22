//
//  Shipping2ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 17.12.2020.
//

import UIKit
import DSKit
import DSKitFakery

class Shipping2ViewController: DSViewController {
    
    var selectedMethod: String = "Standard Shipping"
    let faker = DSFaker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shipping"
        update()
    }
    
    func update() {
        show(content: shippingSection(), totalsSection())
        showBottom(content: bottomContentSection())
    }
}

extension Shipping2ViewController {
  
    /// Shipping
    /// - Returns: DSSection
    func shippingSection() -> DSSection {
        
        let a1 = shipping(title: "Free Shipping",
                         description: "1 month - Friday, 27 July 2020")
        
        let a2 = shipping(title: "Standard Shipping",
                         description: "2 weeks - Tuesday, 10 July 2020",
                         price: "4.70")
        
        let a3 = shipping(title: "Express Shipping",
                         description: "3-4 days - Sunday, 1 July 2020 ",
                         price: "30.00")
        
        return [a1, a2, a3].list().subheadlineHeader("Select shipping method")
    }
    
    /// Shipping method
    /// - Parameters:
    ///   - holder: String
    ///   - type: String
    ///   - expire: String
    ///   - end: String
    /// - Returns: DSViewModel
    func shipping(title: String,
                  description: String,
                  price: String? = nil) -> DSViewModel {
        
        // Text
        let composer = DSTextComposer()
        composer.add(type: .headline, text: title, spacing: 5)
        composer.add(type: .subheadline, text: description, icon: UIImage(systemName: "calendar"))
        
        if let price = price {
            composer.add(price: DSPrice(amount: price, currency: "$"), size: .medium)
        } else {
            composer.add(type: .headline, text: "Free")
        }
        
        // Is selected
        let isSelected = title == selectedMethod
        
        // Action
        var action = composer.checkboxActionViewModel(selected: isSelected)
        
        // Handle did tap
        action.didTap { [unowned self] (_: DSActionVM) in
            self.selectedMethod = title
            self.update()
        }
        
        return action
    }
    
    /// Bottom content section
    /// - Returns: DSSection
    func bottomContentSection() -> DSSection {
        
        let icon = DSSFSymbolConfig.buttonIcon( "arrow.right")
        
        var button = DSButtonVM(title: "Continue", icon: icon) { [unowned self] _ in
            self.pop()
        }
        
        button.textAlignment = .left
        button.imagePosition = .rightMargin
        let section = button.list().subheadlineHeader("Next Step: Order info")
        return section
    }
}

// MARK: - Delivery section

extension Shipping2ViewController {
    
    // Totals
    func totalsSection() -> DSSection {
        
        var viewModels = [DSViewModel]()
        viewModels.append(serviceRow(title: "Subtotal", price: DSPrice(amount: "160.00", currency: "$")))
        viewModels.append(serviceRow(title: "Shipping", price: DSPrice(amount: "4.70", currency: "$")))
        viewModels.append(serviceRow(bold: true, title: "Total", price: DSPrice(amount: "164.70", currency: "$")))
        return viewModels.list(separator: true, grouped: true).subheadlineHeader("Order info")
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

// MARK: - SwiftUI Preview

import SwiftUI

struct Shipping2ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: Shipping2ViewController(), ShopAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
