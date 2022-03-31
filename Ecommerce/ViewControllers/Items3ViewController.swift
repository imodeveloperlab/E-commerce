//
//  Items3ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class Items3ViewController: DSViewController {
    
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

extension Items3ViewController {
    
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
        
        let section = [product1, product2, product4, product5, product6, product7, product3].list()
        
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
        composer.add(type: .headline, text: title)
        composer.add(type: .subheadline, text: description)
        composer.add(price: DSPrice.random())
        
        // Action
        var action = composer.actionViewModel()
        
        action.leftImage(url: image,
                         style: .themeCornerRadius,
                         size: .size(CGSize(width: 80, height: 100)))
        
        // Like button
        action.supplementaryItems = [likeButton()]
        
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
                                          position: .rightBottom,
                                          background: .lightBlur,
                                          insets: .small,
                                          offset: .interItemSpacing,
                                          cornerRadius: .custom(10))
        return supView
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct Items3ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            let nav = DSNavigationViewController(rootViewController: Items3ViewController())
            PreviewContainer(VC: nav, BlackToneAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}

fileprivate let p1Image = URL(string: "https://images.pexels.com/photos/4969888/pexels-photo-4969888.jpeg?cs=srgb&dl=pexels-maria-orlova-4969888.jpg&fm=jpg")
fileprivate let p2Image = URL(string: "https://images.pexels.com/photos/4969986/pexels-photo-4969986.jpeg?cs=srgb&dl=pexels-maria-orlova-4969986.jpg&fm=jpg")
fileprivate let p3Image = URL(string: "https://images.pexels.com/photos/3149638/pexels-photo-3149638.jpeg?cs=srgb&dl=pexels-gbadamosi-ayokunle-hardeckx-3149638.jpg&fm=jpg")
fileprivate let p4Image = URL(string: "https://images.pexels.com/photos/3341604/pexels-photo-3341604.jpeg?cs=srgb&dl=pexels-thegiansepillo-3341604.jpg&fm=jpg")
fileprivate let p5Image = URL(string: "https://images.pexels.com/photos/6401657/pexels-photo-6401657.jpeg?cs=srgb&dl=pexels-dziana-hasanbekava-6401657.jpg&fm=jpg")
fileprivate let p6Image = URL(string: "https://images.pexels.com/photos/5372767/pexels-photo-5372767.jpeg?cs=srgb&dl=pexels-johanser-martinez-5372767.jpg&fm=jpg")
fileprivate let p7Image = URL(string: "https://images.pexels.com/photos/5303044/pexels-photo-5303044.jpeg?cs=srgb&dl=pexels-elijah-o%27donnell-5303044.jpg&fm=jpg")
