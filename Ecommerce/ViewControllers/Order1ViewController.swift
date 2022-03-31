//
//  Order1ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 17.12.2020.
//

import UIKit
import DSKit
import DSKitFakery

class Order1ViewController: DSViewController {
    
    var selectedMethod: String = "Standard Shipping"
    let faker = DSFaker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Order details"
        update()
    }
    
    func update() {
        show(content: productsSection(), deliverySection(), paymentSection(), totalsSection())
        showBottom(content: bottomContentSection())
    }
}

// MARK: - Delivery section

extension Order1ViewController {
    
    func deliverySection() -> DSSection {
        return [address(), shipping()].list(separator: true, grouped: true).subheadlineHeader("Delivery")
    }
}

// MARK: - Shipping

extension Order1ViewController {
  
    /// Shipping
    /// - Returns: DSSection
    func shipping() -> DSViewModel {
        
        return shipping(title: "Standard Shipping",
                         description: "2 weeks - Tuesday, 10 July 2020",
                         price: "4.70")
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
        composer.add(type: .headlineWithSize(15), text: title, spacing: 5)
        composer.add(type: .subheadlineWithSize(12), text: description, icon: UIImage(systemName: "calendar"))
        
        if let price = price {
            composer.add(price: DSPrice(amount: price, currency: "$"), size: .medium)
        } else {
            composer.add(type: .headline, text: "Free")
        }
        
        // Action
        var action = composer.actionViewModel()
        
        // Edit action
        let edit = DSButtonVM(sfSymbol: "pencil.circle",
                              style: .custom(size: 20, weight: .medium),
                              type: .link) { [unowned self] _ in
            self.dismiss()
        }
        
        action.rightSideView = DSSideView(view: edit)
        
        // Handle did tap
        action.didTap { [unowned self] (_: DSActionVM) in
            self.selectedMethod = title
            self.update()
        }
        
        return action
    }
}

// MARK: - Bottom Content

extension Order1ViewController {
    
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

// MARK: - Totals

extension Order1ViewController {
    
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
        composer.add(type: bold ? .headline : .subheadline, text: title)
        
        var action = composer.actionViewModel()
        action.rightPrice(price: price)
        
        return action
    }
}

// MARK: - Products

extension Order1ViewController {
    
    /// Products
    /// - Returns: DSSection
    func productsSection() -> DSSection {
        
        // 1
        let product1 = product(title: "The Iconic Mesh Polo Shirt - All Fits",
                               description: "Polo Ralph Lauren",
                               image: p1Image)
        
        // 2
        let product2 = product(title: "Polo Team Mesh Polo Shirt",
                               description: "House & Versace",
                               image: p6Image)
        
        // 3
        let product3 = product(title: "Polo Team Mesh Polo Shirt",
                               description: "House & Versace",
                               image: p7Image)
        
        let section = [product1, product2, product3].list(separator: true ,grouped: true)
        section.subheadlineHeader("Cart 3 Items")
        
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
        composer.add(type: .headlineWithSize(15), text: title)
        composer.add(type: .subheadlineWithSize(12), text: description)
        composer.add(price: DSPrice.random())
        
        // Action
        var action = composer.actionViewModel()
        
        action.leftImage(url: image,
                         style: .themeCornerRadius,
                         size: .size(CGSize(width: 50, height: 60)))
        
        action.didTap { [unowned self] (_ :DSCardVM) in
            self.dismiss()
        }
        
        return action
    }
}

// MARK: - Address

extension Order1ViewController {
    
    /// Adresses
    /// - Returns: DSSection
    func address() -> DSViewModel {
        
        let a1 = address(holder: "John Doe",
                         address: "201 Torphy Ports, New York",
                         phone: "+1(513)516-5999")
        
        return a1
    }
    
    /// Payment method
    /// - Parameters:
    ///   - holder: String
    ///   - type: String
    ///   - expire: String
    ///   - end: String
    /// - Returns: DSViewModel
    func address(holder: String,
                 address: String,
                 phone: String) -> DSViewModel {
        
        // Text
        let composer = DSTextComposer()
        composer.add(type: .headlineWithSize(15), text: holder, spacing: 5)
        composer.add(type: .subheadlineWithSize(12), text: address, icon: UIImage(systemName: "house.fill"))
        composer.add(type: .subheadlineWithSize(12), text: phone, icon: UIImage(systemName: "phone.fill"))
        
        // Action
        var action = composer.actionViewModel()
     
        // Edit action
        let edit = DSButtonVM(sfSymbol: "pencil.circle",
                              style: .custom(size: 20, weight: .medium),
                              type: .link) { [unowned self] _ in
            self.dismiss()
        }
        
        action.rightSideView = DSSideView(view: edit)
        
        // Handle did tap
        action.didTap { [unowned self] (_: DSActionVM) in
            self.update()
        }
        
        return action
    }
}

// MARK: - Payment

extension Order1ViewController {
    
    /// Payment section
    /// - Returns: DSSection
    func paymentSection() -> DSSection {
        
        let pm1 = paymentMethod(holder: "John Doe",
                                type: "Visa",
                                expire: "04/23",
                                end: "5110")
        
        return [pm1].list(grouped: true).subheadlineHeader("Payment method")
    }
    
    /// Payment method
    /// - Parameters:
    ///   - holder: String
    ///   - type: String
    ///   - expire: String
    ///   - end: String
    /// - Returns: DSViewModel
    func paymentMethod(holder: String,
                       type: String,
                       expire: String,
                       end: String) -> DSViewModel {
        
        // Text
        let composer = DSTextComposer()
        composer.add(type: .headlineWithSize(15), text: "\(type) **** \(end)")
        composer.add(type: .subheadlineWithSize(12), text: holder + " " + expire)
        
        // Action
        var action = composer.actionViewModel()
        
        // Edit action
        let edit = DSButtonVM(sfSymbol: "pencil.circle",
                              style: .custom(size: 20, weight: .medium),
                              type: .link) { [unowned self] _ in
            self.dismiss()
        }
        
        action.rightSideView = DSSideView(view: edit)
        
        // Icon
        let icon = UIImage.named(type.replacingOccurrences(of: " ", with: ""))
        action.leftImage(image: icon, size: .size(.init(width: 50, height: 30)), contentMode: .scaleAspectFit)
        
        // Handle did tap
        action.didTap { [unowned self] (_: DSActionVM) in
            self.update()
        }
        
        return action
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct Order1ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: Order1ViewController(), ShopAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}

fileprivate let p1Image = URL(string: "https://images.pexels.com/photos/4969888/pexels-photo-4969888.jpeg?cs=srgb&dl=pexels-maria-orlova-4969888.jpg&fm=jpg")
fileprivate let p6Image = URL(string: "https://images.pexels.com/photos/5372767/pexels-photo-5372767.jpeg?cs=srgb&dl=pexels-johanser-martinez-5372767.jpg&fm=jpg")
fileprivate let p7Image = URL(string: "https://images.pexels.com/photos/5303044/pexels-photo-5303044.jpeg?cs=srgb&dl=pexels-elijah-o%27donnell-5303044.jpg&fm=jpg")
