//
//  Payment1ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 17.12.2020.
//

import UIKit
import DSKit
import DSKitFakery

class Payment1ViewController: DSViewController {
    
    var selectedPaymentMethod: String = "5110"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Payment"
        update()
    }
    
    func update() {
        show(content: paymentMethodsSection(), addNewPaymentMethodSection())
        showBottom(content: bottomContentSection())
    }
}

extension Payment1ViewController {
    
    func paymentMethodsSection() -> DSSection {
        
        let pm1 = paymentMethod(holder: "John Doe",
                                type: "Visa",
                                expire: "04/23",
                                end: "5110")
        
        let pm2 = paymentMethod(holder: "Jane Doe",
                                type: "American Express",
                                expire: "04/23",
                                end: "324")
        
        let pm3 = paymentMethod(holder: "John Doe",
                                type: "Master Card",
                                expire: "04/23",
                                end: "1246")
        
        let pm4 = paymentMethod(holder: "Jane Doe",
                                type: "Visa",
                                expire: "04/23",
                                end: "3481")
        
        return [pm1, pm2, pm3, pm4].list().headlineHeader("Select credit card to continue", size: 15)
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
        composer.add(type: .subheadline, text: holder + " " + expire)
        
        // Is selected
        let isSelected = end == selectedPaymentMethod
        
        // Action
        var action = composer.checkboxActionViewModel(selected: isSelected)
        
        // Icon
        let icon = UIImage.named(type.replacingOccurrences(of: " ", with: ""))
        action.leftImage(image: icon, size: .size(.init(width: 60, height: 35)), contentMode: .scaleAspectFit)
        
        // Handle did tap
        action.didTap { [unowned self] (_: DSActionVM) in
            self.selectedPaymentMethod = end
            self.update()
        }
        
        return action
    }
    
    /// Bottom content section
    /// - Returns: DSSection
    func bottomContentSection() -> DSSection {
        
        let icon = DSSFSymbolConfig.buttonIcon("arrow.right")
        var button = DSButtonVM(title: "Continue", icon: icon) { [unowned self] _ in
            self.pop()
        }
        button.textAlignment = .left
        button.imagePosition = .rightMargin
        
        let section = button.list().subheadlineHeader("Next Step: Shipping address")
        return section
    }
    
    /// Add new payment method section
    /// - Returns: DSSection
    func addNewPaymentMethodSection() -> DSSection {
        
        let icon = DSSFSymbolConfig.buttonIcon("plus.circle")
        let button = DSButtonVM(title: "Add new credit card", icon: icon, type: .secondaryView) { [unowned self] _ in
            self.pop()
        }
        
        return button.list()
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct Payment1ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: Payment1ViewController(), ShopAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
