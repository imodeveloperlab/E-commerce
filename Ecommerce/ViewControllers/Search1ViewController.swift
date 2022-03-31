//
//  Search1ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class Search1ViewController: DSViewController {
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Search"
        update()
    }
    
    // Call every time some data have changed
    func update() {
        showTop(content: searchTextFieldSection())
        show(content: trendingSection())
    }
    
    @objc func openFilters() {
        self.dismiss()
    }
    
    @objc func openSort() {
        self.dismiss()
    }
}

// MARK: - Search

extension Search1ViewController {
    
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

// MARK: - SwiftUI Preview

import SwiftUI

struct Search1ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            let nav = DSNavigationViewController(rootViewController: Search1ViewController())
            PreviewContainer(VC: nav, BlackToneAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
