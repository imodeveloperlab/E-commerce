//
//  Payment2ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 17.12.2020.
//

import UIKit
import DSKit
import DSKitFakery

class Payment2ViewController: DSViewController {
    
    var selectedPaymentMethod: String = "5110"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Payment"
        update()
    }
    
    func update() {
        show(content: paymentMethodsSection())
        showBottom(content: [termsAndConditionsSection(), addNewPaymentMethodSection()])
    }
}

extension Payment2ViewController {
    
    /// Payment methods section
    /// - Returns: DSSection
    func paymentMethodsSection() -> DSSection {
        
        let pm1 = paymentMethod(holder: "John Doe",
                                type: "Visa",
                                expire: "04/23",
                                end: "5110",
                                bg: "4")
        
        let pm2 = paymentMethod(holder: "John Doe",
                                type: "Master Card",
                                expire: "04/23",
                                end: "1246",
                                bg: "1")
        
        return [pm1, pm2].list().headlineHeader("Select credit card to continue", size: 15)
    }
    
    /// Add new payment method section
    /// - Returns: DSSection
    func addNewPaymentMethodSection() -> DSSection {
        
        let icon = DSSFSymbolConfig.buttonIcon("plus.circle")
        let button = DSButtonVM(title: "Add new credit card", icon: icon) { [unowned self] _ in
            self.pop()
        }
        
        return button.list()
    }
    
    /// Payment method
    /// - Parameters:
    ///   - holder: String
    ///   - type: String
    ///   - expire: String
    ///   - end: String
    ///   - bg: String
    /// - Returns: DSViewModel
    func paymentMethod(holder: String,
                       type: String,
                       expire: String,
                       end: String,
                       bg: String = "1") -> DSViewModel {
        
        // Text
        let composer = DSTextComposer()
        composer.add(type: .text(font: .headlineWithSize(20), color: .white), text: "\(type) **** \(end)")
        composer.add(type: .text(font: .subheadline, color: .white), text: expire)
        composer.add(type: .text(font: .subheadline, color: .white), text: holder)
        
        // Card
        let backgroundImage = UIImage.named("CardBackground_\(bg)")
        var card = DSCardVM(composer: composer, textPosition: .center, backgroundImage: .image(image: backgroundImage))
        
        // Card icon
        let icon = UIImage.named(type.replacingOccurrences(of: " ", with: ""))
        var cardIcon = DSImageVM(image: icon)
        cardIcon.width = .absolute(55)
        cardIcon.height = .absolute(35)
        card.supplementaryItems = [cardIcon.asSupplementary(position: .rightTop,
                                                            background: .clear,
                                                            insets: .insets(.zero))]
        // Is selected
        let isSelected = end == selectedPaymentMethod
        
        // Action
        var action = composer.checkboxActionViewModel(selected: isSelected)
        
        // Icon
        action.leftImage(image: icon, size: .size(.init(width: 60, height: 50)), contentMode: .scaleAspectFit)
        
        // Handle did tap
        action.didTap { [unowned self] (_: DSActionVM) in
            self.selectedPaymentMethod = end
            self.update()
        }
        
        return card
    }
}

// MARK: - Bottom Content

extension Payment2ViewController {
    
    /// Bottom content section
    /// - Returns: DSSection
    func termsAndConditionsSection() -> DSSection {
        
        var text = DSActiveTextVM(.subheadlineWithSize(14), text: "By pressing add new credit card, you agree to our\nTerms and Privacy", alignment: .center)
        
        text.links = ["Terms": "http://dskit.app", "Privacy": "http://dskit.app"]
        
        return text.list()
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct Payment2ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: Payment2ViewController(), ShopAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
