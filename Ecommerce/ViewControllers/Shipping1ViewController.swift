//
//  Shipping1ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 17.12.2020.
//

import UIKit
import DSKit
import DSKitFakery

class Shipping1ViewController: DSViewController {
    
    var selectedAddress: String = "201 Avenue 32, New York"
    let faker = DSFaker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shipping"
        update()
    }
    
    func update() {
        show(content: addressesSection(), addNewPaymentMethodSection())
        showBottom(content: bottomContentSection())
    }
}

extension Shipping1ViewController {
  
    /// Adresses
    /// - Returns: DSSection
    func addressesSection() -> DSSection {
        
        let a1 = address(holder: "John Doe",
                         address: "201 Torphy Ports, New York",
                         phone: "+1(513)516-5999")
        
        let a2 = address(holder: "Albert Deep",
                         address: "201 Avenue 32, New York",
                         phone: "+1(513)636-5999")
        
        let a3 = address(holder: "John Doe",
                         address: "Madison, Park and Lexington",
                         phone: "+1(513)616-5699")
        
        let a4 = address(holder: "Borinschi Ivan",
                         address: "201 Torphy Park, New York",
                         phone: "+1(513)616-5699")
        
        return [a1, a2, a3, a4].list().subheadlineHeader("Select delivery address")
    }
    
    /// Add new payment method section
    /// - Returns: DSSection
    func addNewPaymentMethodSection() -> DSSection {
        
        let icon = DSSFSymbolConfig.buttonIcon( "plus.circle")
        let button = DSButtonVM(title: "Add new address", icon: icon, type: .secondaryView) { [unowned self] _ in
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
    /// - Returns: DSViewModel
    func address(holder: String,
                 address: String,
                 phone: String) -> DSViewModel {
        
        // Text
        let composer = DSTextComposer()
        composer.add(type: .headline, text: holder, spacing: 5)
        composer.add(type: .subheadline, text: address, icon: UIImage(systemName: "house.fill"))
        composer.add(type: .subheadline, text: phone, icon: UIImage(systemName: "phone.fill"))
        
        // Is selected
        let isSelected = address == selectedAddress
        
        // Action
        var action = composer.checkboxActionViewModel(selected: isSelected)

        let edit = DSButtonVM(sfSymbol: "pencil.circle",
                              style: .custom(size: 20, weight: .medium),
                              type: .link) { [unowned self] _ in
            self.dismiss()
        }
        
        action.rightSideView = DSSideView(view: edit)
        
        // Handle did tap
        action.didTap { [unowned self] (_: DSActionVM) in
            self.selectedAddress = address
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
        let section = button.list().subheadlineHeader("Next Step: Checkout")
        return section
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct Shipping1ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: Shipping1ViewController(), ShopAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
