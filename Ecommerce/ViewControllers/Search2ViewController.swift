//
//  Search1ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class Search2ViewController: DSViewController {
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Search"
        update()
    }
    
    // Call every time some data have changed
    func update() {
        showTop(content: searchTextFieldSection())
        show(content: trendingProductsSection(), recentSection())
    }
    
    @objc func openFilters() {
        self.dismiss()
    }
    
    @objc func openSort() {
        self.dismiss()
    }
}

// MARK: - Search

extension Search2ViewController {
    
    func searchTextFieldSection() -> DSSection {
        
        let textField = DSTextFieldVM.search(placeholder: "Search")
        return textField.list()
    }
    
    /// Products gallery
    /// - Returns: DSSection
    func trendingSection() -> DSSection {
        
        let label = DSLabelVM(.headline, text: "Trending", alignment: .center)
        
        let trending = ["Cell Phones & Accessories",
                         "Clothing, Shoes & Jewelry",
                         "Collectible Coins",
                         "Digital Music",
                         "Electronics",
                         "Gift Cards",
                         "Grocery & Gourmet Food",
                         "Kindle Store",
                         "Kitchen & Dinning"]
        
        var models = trending.map { (trend) -> DSViewModel in
            
            var button = DSButtonVM(title: trend, type: .link, textAlignment: .center) { _ in
                self.dismiss()
            }
            
            button.height = .absolute(30)
            return button
        }
                
        models.insert(label, at: 0)
        
        return models.list()
    }
}

// MARK: - Recent

extension Search2ViewController {
 
    /// Products gallery
    /// - Returns: DSSection
    func recentSection() -> DSSection {
        
        let searches = ["Shoes",
                         "Coats",
                         "Beachwear",
                         "Shoes",
                         "Sneakers",
                         "Apple",
                         "iPhonw",
                         "Kindle Store",
                         "Shoes",
                         "Coats",
                         "Beachwear",
                         "Shoes",
                         "Sneakers",
                         "Apple",
                         "iPhonw",
                         "Kindle Store"]
        
        let models = searches.map { (search) -> DSViewModel in
            
            let composer = DSTextComposer()
            composer.add(type: .subheadline, text: search)
            
            var action = DSActionVM(composer: composer)
            action.rightArrow()
            
            return action
        }
        
        let section = models.list()
        
        // Header
        var header = DSActionVM(title: "Recent")
        header.style.displayStyle = .default
        header.rightButton(title: "Clear") { [unowned self] in
            self.dismiss()
        }
        
        section.header = header
        
        return section
    }
}

// MARK: - Tranding

extension Search2ViewController {
    
    /// Products gallery
    /// - Returns: DSSection
    func trendingProductsSection() -> DSSection {
        
        // 1
        let product1 = product(title: "New Balance All Fits",
                             description: "Balance",
                             image: p1Image)
        
        // 2
        let product2 = product(title: "Big Pony Mesh Shoes",
                              description: "Rebook",
                              image: p2Image)
        
        // 3
        let product3 = product(title: "Mesh Long-Sleeve Sneakers All Fits",
                             description: "Nike",
                             image: p3Image)
        
        let section = [product2, product3, product1, ].gallery()
        section.headlineHeader("Trending")
        
        return section
    }
    
    /// Product
    /// - Parameters:
    ///   - title: String
    ///   - description: String
    ///   - image: URL?
    ///   - badge: String?
    /// - Returns: DSViewModel
    func product(title: String, description: String, image: URL? = nil) -> DSViewModel {

        // Text
        let composer = DSTextComposer(alignment: .natural)
        composer.add(type: .headlineWithSize(14), text: title)
        composer.add(type: .subheadlineWithSize(11), text: description)
        
        // Action
        var action = composer.actionViewModel()
        action.leftImage(url: image, size: .size(.init(width: 60, height: 60)))
        
        action.width = .fractional(0.6)
        
        // Handle did tap
        action.didTap { [unowned self] (_ :DSCardVM) in
            self.dismiss()
        }
        
        return action
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct Search2ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            let nav = DSNavigationViewController(rootViewController: Search2ViewController())
            PreviewContainer(VC: nav, BlackToneAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}

fileprivate let p1Image = URL(string: "https://images.pexels.com/photos/2529157/pexels-photo-2529157.jpeg?cs=srgb&dl=pexels-melvin-buezo-2529157.jpg&fm=jpg")
fileprivate let p2Image = URL(string: "https://images.pexels.com/photos/2529146/pexels-photo-2529146.jpeg?cs=srgb&dl=pexels-melvin-buezo-2529146.jpg&fm=jpg")
fileprivate let p3Image = URL(string: "https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg?cs=srgb&dl=pexels-melvin-buezo-2529148.jpg&fm=jpg")
