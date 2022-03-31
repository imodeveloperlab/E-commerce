//
//  Items2ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class Items2ViewController: DSViewController {
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Boots"
        update()
        
        // Filter
        let filter = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down.circle.fill"),
                                     style: .plain,
                                     target: self,
                                     action: #selector(openFilters))
        
        // Sort
        let sort = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3.decrease.circle.fill"),
                                   style: .plain,
                                   target: self,
                                   action: #selector(openSort))
        
        navigationItem.rightBarButtonItems = [filter, sort]
    }
    
    // Call every time some data have changed
    func update() {
        show(content: productsSection())
    }
    
    @objc func openFilters() {
        self.dismiss()
    }
    
    @objc func openSort() {
        self.dismiss()
    }
}

// MARK: - Products

extension Items2ViewController {
    
    /// Products section
    /// - Returns: DSSection
    func productsSection() -> DSSection {
        
        // 1
        let product1 = product(title: "Suede Chuck-a Boots",
                               description: "River Island",
                               image:  bootsImage)
        
        // 2
        let product2 = product(title: "Platform derby shoes",
                               description: "Stella McCarthney",
                               image: shoesImage,
                               badge: "SALES")
        
        // 3
        let product3 = product(title: "Hiking Boots",
                               description: "Dolce & Gabbana",
                               image: hikingBootsImage)
        
        // 4
        let product4 = product(title: "Motocross Boots",
                               description: "Hermes",
                               image: motocrossBootsImage)
        
        // 5
        let product5 = product(title: "Riding Boots",
                               description: "Arrmani",
                               image: ridingBootsImage,
                               badge: "50% OFF")
        
        // 6
        let product6 = product(title: "Jodhpur Boots",
                               description: "House & Versace",
                               image: jodhpurBootsImage)
        
        let section = [product2, product4, product3, product6, product1, product5].list()
        
        return section
    }
    
    /// Product
    /// - Parameters:
    ///   - title: String
    ///   - description: String
    ///   - image: URL?
    ///   - badge: String?
    /// - Returns: DSViewModel
    func product(title: String,
                 description: String,
                 image: URL? = nil,
                 badge: String? = nil) -> DSViewModel {
        
        // Text
        let composer = DSTextComposer(alignment: .center)
        composer.add(type: .text(font: .headlineWithSize(14), color: .white), text: title)
        composer.add(type: .text(font: .headlineWithSize(12), color: .custom(.lightGray)), text: description)
        
        let priceColors = DSDesignablePriceColor(currency: .white,
                                                 amount: .white,
                                                 regularAmount: .lightGray,
                                                 badgeBackground: .systemRed,
                                                 badgeText: .white,
                                                 badgeCornerRadius: 5)
        
        composer.add(price: DSPrice.random(), size: .large, color: .custom(priceColors))
        
        // Card
        var card = DSCardVM(composer: composer, textPosition: .bottom, backgroundImage: .imageURL(url: image))
        card.height = .absolute(280)

        // Card gradient
        card.gradientTopPosition = 0.6
        card.gradientBottomPosition = 1.0
        card.gradientTopColor = UIColor.black.withAlphaComponent(0.0)
        card.gradientBottomColor = UIColor.black.withAlphaComponent(0.8)
        
        // Like button
        card.supplementaryItems = [likeButton()]
        
        // Label
        if let badge = badge {
            card.supplementaryItems?.append(label(title: badge))
        }
        
        // Handle did tap
        card.didTap { [unowned self] (_ :DSCardVM) in
            self.dismiss()
        }
        
        return card
    }
    
    /// Label supplementary view
    /// - Parameter title: String
    /// - Returns: DSSupplementaryView
    func label(title: String) -> DSSupplementaryView {
        
        let label = DSLabelVM(.headlineWithSize(12), text: title)
        
        let supView = DSSupplementaryView(view: label,
                                          position: .leftTop,
                                          background: .primary,
                                          insets: .small,
                                          cornerRadius: .custom(5))
        return supView
    }
    
    /// Like button
    /// - Returns: DSSupplementaryView
    func likeButton() -> DSSupplementaryView {
        
        let composer = DSTextComposer()
        composer.add(sfSymbol: "heart.fill",
                     style: .medium,
                     tint: .custom(Int.random(in: 0...1) == 0 ? .red : .white))
        
        var action = DSActionVM(composer: composer)
        
        action.didTap { [unowned self] (_: DSActionVM) in
            self.dismiss()
        }
        
        let supView = DSSupplementaryView(view: action,
                                          position: .rightTop,
                                          background: .lightBlur,
                                          insets: .small,
                                          cornerRadius: .custom(10))
        return supView
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct Items2ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            let nav = DSNavigationViewController(rootViewController: Items2ViewController())
            PreviewContainer(VC: nav, BlackToneAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}

fileprivate let bootsImage = URL(string: "https://images.pexels.com/photos/267242/pexels-photo-267242.jpeg?cs=srgb&dl=pexels-pixabay-267242.jpg&fm=jpg")
fileprivate let shoesImage = URL(string: "https://images.pexels.com/photos/1904769/pexels-photo-1904769.jpeg?cs=srgb&dl=pexels-sebastian-palomino-1904769.jpg&fm=jpg")
fileprivate let hikingBootsImage = URL(string: "https://images.pexels.com/photos/755871/pexels-photo-755871.jpeg?cs=srgb&dl=pexels-simon-migaj-755871.jpg&fm=jpg")
fileprivate let motocrossBootsImage = URL(string: "https://images.pexels.com/photos/718981/pexels-photo-718981.jpeg?cs=srgb&dl=pexels-aidan-jarrett-718981.jpg&fm=jpg")
fileprivate let ridingBootsImage = URL(string: "https://images.pexels.com/photos/6410600/pexels-photo-6410600.jpeg?cs=srgb&dl=pexels-jessica-jochheim-6410600.jpg&fm=jpg")
fileprivate let jodhpurBootsImage = URL(string: "https://images.pexels.com/photos/2682289/pexels-photo-2682289.jpeg?cs=srgb&dl=pexels-andrew-neel-2682289.jpg&fm=jpg")
