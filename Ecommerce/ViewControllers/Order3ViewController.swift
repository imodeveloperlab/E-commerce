//
//  Order3ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 17.12.2020.
//

import UIKit
import DSKit
import DSKitFakery

class Order3ViewController: DSViewController {
    
    var selectedMethod: String = "Standard Shipping"
    let faker = DSFaker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Order details"
        update()
    }
    
    func update() {
        show(content: messageSection())
        showBottom(content: [bottomContentSection()])
    }
}

// MARK: - Bottom Content

extension Order3ViewController {
    
    /// Bottom content section
    /// - Returns: DSSection
    func messageSection() -> DSSection {
        return [DSSpaceVM(type: .custom(50))
                ,successIcon(),
                DSSpaceVM(type: .custom(30)),
                successMessage()].list()
    }
    
    /// Icon
    /// - Returns: DSViewModel
    func successIcon() -> DSViewModel {
        
        let icon: DSImageContent = .sfSymbol(name: "checkmark.circle.fill",
                                             style: .custom(size: 50, weight: .bold))
        
        var image = DSImageVM(imageValue: icon, contentMode: .scaleAspectFit)
        image.tintColor = .text(.custom(appearance.semanticGreenColor))
        image.height = .absolute(90)
        return image
    }
    
    /// Message
    /// - Returns: DSViewModel
    func successMessage() -> DSViewModel {
        
        let composer = DSTextComposer(alignment: .center)
        composer.add(type: .headlineWithSize(30), text: "It's Ordered")
        composer.add(type: .subheadline, text: "Hi John - thanks for your order,\nwe hope you enjoyed shopping\nwith us.")
        return composer.textViewModel()
    }
}

// MARK: - Bottom Content

extension Order3ViewController {
    
    /// Bottom content section
    /// - Returns: DSSection
    func bottomContentSection() -> DSSection {
        
        let icon = DSSFSymbolConfig.buttonIcon( "bag.fill")
        
        let button = DSButtonVM(title: "Continue Shopping", icon: icon, type: .secondaryView) { [unowned self] _ in
            self.dismiss()
        }
        
        return button.list()
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct Order3ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: Order3ViewController(), ShopAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
