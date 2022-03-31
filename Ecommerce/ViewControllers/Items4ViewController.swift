//
//  Items4ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class Items4ViewController: DSViewController {
    
    var selectedFilter = "Jackets"
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Polo Shirts"
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
        show(content: filtersSection(), productsSection())
    }
    
    @objc func openFilters() {
        self.dismiss()
    }
    
    @objc func openSort() {
        self.dismiss()
    }
}

// MARK: - Products

extension Items4ViewController {
    
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
        action.height = .absolute(280)
        
        // Like button
        action.supplementaryItems = [likeButton()]
        
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
                     tint: .custom(Int.random(in: 0...1) == 0 ? .red : .lightGray))
        
        // Action
        var action = DSActionVM(composer: composer)
        
        // Handle did tap
        action.didTap { [unowned self] (_: DSActionVM) in
            self.dismiss()
        }
        
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

extension Items4ViewController {
    
    /// Products gallery
    /// - Returns: DSSection
    func filtersSection() -> DSSection {
        
        let filters = ["Polo", "Denim", "Jackets", "Shirts", "Shorts", "Sweaters"]
        
        let viewModels = filters.map { (filter) -> DSViewModel in
            filterModel(title: filter)
        }
        
        let section = viewModels.gallery()
        return section
    }
    
    /// Product
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

struct Items4ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            let nav = DSNavigationViewController(rootViewController: Items4ViewController())
            PreviewContainer(VC: nav, BlackToneAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}

fileprivate let p1Image = URL(string: "https://images.pexels.com/photos/1816643/pexels-photo-1816643.jpeg?cs=srgb&dl=pexels-atef-khaled-1816643.jpg&fm=jpg")
fileprivate let p2Image = URL(string: "https://images.pexels.com/photos/5325554/pexels-photo-5325554.jpeg?cs=srgb&dl=pexels-anna-shvets-5325554.jpg&fm=jpg")
fileprivate let p3Image = URL(string: "https://images.pexels.com/photos/2909735/pexels-photo-2909735.jpeg?cs=srgb&dl=pexels-lad-fury-2909735.jpg&fm=jpg")
fileprivate let p4Image = URL(string: "https://images.pexels.com/photos/2755165/pexels-photo-2755165.jpeg?cs=srgb&dl=pexels-matt-hardy-2755165.jpg&fm=jpg")
fileprivate let p5Image = URL(string: "https://images.pexels.com/photos/3289663/pexels-photo-3289663.jpeg?cs=srgb&dl=pexels-tnarg-3289663.jpg&fm=jpg")
fileprivate let p6Image = URL(string: "https://images.pexels.com/photos/3608205/pexels-photo-3608205.jpeg?cs=srgb&dl=pexels-the-happiest-face-%29-3608205.jpg&fm=jpg")
fileprivate let p7Image = URL(string: "https://images.pexels.com/photos/5999891/pexels-photo-5999891.jpeg?cs=srgb&dl=pexels-ono-kosuki-5999891.jpg&fm=jpg")
