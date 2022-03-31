//
//  Items4ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class Items5ViewController: DSViewController {
    
    var selectedFilter = "Jackets"
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        title = ""
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
        show(content: headerSection(), filtersSection(), productsSection())
    }
    
    @objc func openFilters() {
        self.dismiss()
    }
    
    @objc func openSort() {
        self.dismiss()
    }
}

// MARK: - Header

extension Items5ViewController {
    
    // Header section
    func headerSection() -> DSSection {
        
        // Text
        let composer = DSTextComposer(alignment: .center)
        composer.add(type: .headlineWithSize(30), text: "Clothing")
        composer.add(type: .headlineWithSize(12), text: "73.3K items")
        
        // Card with text
        var card = DSCardVM(composer: composer, textPosition: .center, backgroundImage: .imageURL(url: p0Image))
        card.height = .absolute(150)
        
        // Card gradient
        card.gradientTopColor = UIColor.white.withAlphaComponent(0.2)
        card.gradientBottomColor = UIColor.white.withAlphaComponent(0.3)
        
        return card.list()
    }
}

// MARK: - Products

extension Items5ViewController {
    
    /// Products
    /// - Returns: DSSection
    func productsSection() -> DSSection {
        
        // 1
        let product1 = product(title: "The Iconic Mesh Polo Shirt - All Fits",
                               description: "Polo Ralph Lauren",
                               image: p1Image)
        
        // 2
        let product2 = product(title: "Big Pony Mesh Polo Shirt",
                               description: "Stella McCarthney",
                               image: p2Image)
        
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
                               image: p5Image)
        
        // 6
        let product6 = product(title: "Polo Team Mesh Polo Shirt",
                               description: "House & Versace",
                               image: p6Image)
        
        // 7
        let product7 = product(title: "Polo Team Mesh Polo Shirt",
                               description: "House & Versace",
                               image: p7Image)
        
        let section = [product1, product2, product4, product5, product6, product7, product3].grid()
        
        return section
    }
    
    /// Product
    /// - Parameters:
    ///   - title: String
    ///   - description: String
    ///   - image: URL?
    /// - Returns: DSViewModel
    func product(title: String, description: String, image: URL? = nil) -> DSViewModel {
        
        // Text
        let composer = DSTextComposer(alignment: .natural)
        composer.add(type: .headlineWithSize(14), text: title)
        composer.add(type: .subheadline, text: description)
        composer.add(price: DSPrice.random())
        
        // Action
        var action = composer.actionViewModel()
        action.topImage(url: image)
        action.height = .absolute(290)
        
        // Like button
        action.supplementaryItems = [likeButton()]
        
        // Copy secondaryView colors and set as custom colors to picker
        let style = DSAppearance.shared.main.secondaryView
        let picker = DSQuantityPickerVM()
        picker.style.colorStyle = .custom(style)
        picker.quantityTextType = .subheadline
        picker.height = .absolute(20)
        
        // Picker right button
        picker.rightButton(sfSymbolName: "cart.fill.badge.plus", style: .custom(size: 18, weight: .medium)) { [unowned self] in
            self.dismiss()
        }
        
        // Set picker as bottom side view to action
        action.bottomSideView = DSSideView(view: picker)
        
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

// MARK: - Filters

extension Items5ViewController {
    
    /// Filter section
    /// - Returns: DSSection
    func filtersSection() -> DSSection {
        
        let filters = ["Coats", "Denim", "Jackets", "Shirts", "Shorts", "Sweaters"]
        
        let viewModels = filters.map { (filter) -> DSViewModel in
            filterModel(title: filter)
        }
        
        let section = viewModels.gallery()
        return section
    }
    
    /// Filter
    /// - Parameters:
    ///   - title: String
    ///   - count: Int
    /// - Returns: DSViewModel
    func filterModel(title: String) -> DSViewModel {
        
        // Is selected
        let selected = title == self.selectedFilter
        
        // Text
        let composer = DSTextComposer(alignment: .center)
        composer.add(type: .headlineWithSize(14), text: title)
        
        // Action
        var filter = composer.actionViewModel()
        
        filter.height = .absolute(35)
        
        // Selected style
        if selected {
            
            // Create a copy of colors from secondaryView colors
            var colors = DSAppearance.shared.main.secondaryView
            
            // Change the colors
            colors.background = colors.button.background
            colors.text.headline = colors.button.title
            colors.text.subheadline = colors.button.title
            
            // Set custom colors to filter
            filter.style.colorStyle = .custom(colors)
        }
        
        filter.width = .absolute(100)
        filter.style.displayStyle = .grouped(inSection: false)
        
        // Handle did tap
        filter.didTap { [unowned self] (_: DSActionVM) in
            self.selectedFilter = title
            self.update()
        }
        
        return filter
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct Items5ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            let nav = DSNavigationViewController(rootViewController: Items5ViewController())
            PreviewContainer(VC: nav, BlackToneAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}

fileprivate let p0Image = URL(string: "https://images.pexels.com/photos/6417941/pexels-photo-6417941.jpeg?cs=srgb&dl=pexels-pavel-danilyuk-6417941.jpg&fm=jpg")
fileprivate let p1Image = URL(string: "https://images.pexels.com/photos/3760610/pexels-photo-3760610.jpeg?cs=srgb&dl=pexels-andrea-piacquadio-3760610.jpg&fm=jpg")
fileprivate let p2Image = URL(string: "https://images.pexels.com/photos/3746314/pexels-photo-3746314.jpeg?cs=srgb&dl=pexels-anna-shvets-3746314.jpg&fm=jpg")
fileprivate let p3Image = URL(string: "https://images.pexels.com/photos/3372595/pexels-photo-3372595.jpeg?cs=srgb&dl=pexels-aidan-roof-3372595.jpg&fm=jpg")
fileprivate let p4Image = URL(string: "https://images.pexels.com/photos/2096694/pexels-photo-2096694.jpeg?cs=srgb&dl=pexels-luis-quintero-2096694.jpg&fm=jpg")
fileprivate let p5Image = URL(string: "https://images.pexels.com/photos/5325887/pexels-photo-5325887.jpeg?cs=srgb&dl=pexels-anna-shvets-5325887.jpg&fm=jpg")
fileprivate let p6Image = URL(string: "https://images.pexels.com/photos/4929024/pexels-photo-4929024.jpeg?cs=srgb&dl=pexels-cottonbro-4929024.jpg&fm=jpg")
fileprivate let p7Image = URL(string: "https://images.pexels.com/photos/5325741/pexels-photo-5325741.jpeg?cs=srgb&dl=pexels-anna-shvets-5325741.jpg&fm=jpg")
