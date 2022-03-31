//
//  Items8ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class Items8ViewController: DSViewController {
    
    var selectedFilter = "Jackets"
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Fashion"
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

extension Items8ViewController {
    
    /// Products gallery
    /// - Returns: DSSection
    func productsSection() -> DSSection {
        
        // 1
        let product1 = product(title: "The Iconic Mesh Polo Shirt - All Fits",
                             description: "Polo Ralph Lauren",
                             image: p1Image)
        
        // 2
        let product2 = product(title: "Big Pony Mesh Polo Shirt",
                              description: "Stella McCarthney",
                              image: p2Image,
                              badge: "SALES")
        
        // 3
        let product3 = product(title: "Mesh Long-Sleeve Polo Shirt – All Fits",
                             description: "Dolce & Gabbana",
                             image: p3Image)
        
        // 4
        let product4 = product(title: "Soft Cotton Polo Shirt - All Fits",
                               description: "Hermes",
                               image: p4Image)
        
        // 5
        let product5 = product(title: "Big Pony Mesh Polo Shirt",
                              description: "Arrmani",
                              image: p5Image,
                              badge: "50% OFF")
        
        // 6
        let product6 = product(title: "Polo Team Mesh Polo Shirt",
                                  description: "House & Versace",
                                  image: p6Image)
        
        // 7
        let product7 = product(title: "Polo Team Mesh Polo Shirt",
                                  description: "House & Versace",
                                  image: p7Image)
        
        let section = [product7, product1, product3, product2, product5, product6, product4].list()
        
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
        composer.add(type: .subheadlineWithSize(11), text: description)
        composer.add(price: DSPrice.random(), spacing: 4)
        composer.add(rating: 4,
                     maximumValue: 5,
                     positiveSymbol: "star.fill",
                     negativeSymbol: "star",
                     style: .medium,
                     tint: .custom(.systemYellow),
                     spacing: 3)
        
        composer.add(type: .subheadlineWithSize(10), text: "\(Int.random(in: 10...100)) reviews")
       
        // Action
        var action = composer.actionViewModel()
        action.leftImage(url: image, size: .size(.init(width: 100, height: 120)))
        
        // Right button with handler
        action.rightButton(sfSymbolName: "ellipsis") { [unowned self] in
            self.popToRoot()
        }
        
        // Handle did tap
        action.didTap { [unowned self] (_ :DSCardVM) in
            self.dismiss()
        }
        
        return action
    }
    
    /// Like button
    /// - Returns: DSSupplementaryView
    func likeButton() -> DSSupplementaryView {
        
        // Text
        let composer = DSTextComposer()
        composer.add(sfSymbol: "heart.fill",
                     style: .medium,
                     tint: .custom(Int.random(in: 0...1) == 0 ? .red : .white))
        
        // Action
        var action = DSActionVM(composer: composer)
        
        // Handle did tap
        action.didTap { [unowned self] (_: DSActionVM) in
            self.dismiss()
        }
        
        // Supplementary view
        let supView = DSSupplementaryView(view: action,
                                          position: .rightTop,
                                          background: .lightBlur,
                                          insets: .small,
                                          offset: .interItemSpacing,
                                          cornerRadius: .custom(10))
        return supView
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct Items8ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            let nav = DSNavigationViewController(rootViewController: Items8ViewController())
            PreviewContainer(VC: nav, BlackToneAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}

fileprivate let p1Image = URL(string: "https://images.pexels.com/photos/6417926/pexels-photo-6417926.jpeg?cs=srgb&dl=pexels-pavel-danilyuk-6417926.jpg&fm=jpg")
fileprivate let p2Image = URL(string: "https://images.pexels.com/photos/3760610/pexels-photo-3760610.jpeg?cs=srgb&dl=pexels-andrea-piacquadio-3760610.jpg&fm=jpg")
fileprivate let p3Image = URL(string: "https://images.pexels.com/photos/2096694/pexels-photo-2096694.jpeg?cs=srgb&dl=pexels-luis-quintero-2096694.jpg&fm=jpg")
fileprivate let p4Image = URL(string: "https://images.pexels.com/photos/4928997/pexels-photo-4928997.jpeg?cs=srgb&dl=pexels-cottonbro-4928997.jpg&fm=jpg")
fileprivate let p5Image = URL(string: "https://images.pexels.com/photos/3746314/pexels-photo-3746314.jpeg?cs=srgb&dl=pexels-anna-shvets-3746314.jpg&fm=jpg")
fileprivate let p6Image = URL(string: "https://images.pexels.com/photos/4349750/pexels-photo-4349750.jpeg?cs=srgb&dl=pexels-ketut-subiyanto-4349750.jpg&fm=jpg")
fileprivate let p7Image = URL(string: "https://images.pexels.com/photos/5082985/pexels-photo-5082985.jpeg?cs=srgb&dl=pexels-cottonbro-5082985.jpg&fm=jpg")
