//
//  ImageGallery2ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class ImageGallery2ViewController: DSViewController {
        
    open override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        self.update()
    }
    
    // Call every time some data have changed
    func update() {
        show(content: header(), gallerySection())
    }
    
    @objc func openFilters() {
        self.dismiss()
    }
    
    @objc func openSort() {
        self.dismiss()
    }
}

// MARK: - Section

extension ImageGallery2ViewController {
    
    // Header section
    func header() -> DSSection {
        
        // Title
        var label = DSLabelVM(.headline, text: "Images", alignment: .center)
        
        // Close button
        var button = DSButtonVM(sfSymbol: "xmark.circle.fill", type: .link) { [unowned self] btn in
            self.dismiss()
        }
        
        button.width = .absolute(50)
        button.height = .absolute(50)
        
        var colors = DSAppearance.shared.main.primaryView
        colors.button.background = UIColor.label
        button.style.colorStyle = .custom(colors)
        
        label.supplementaryItems = [button.asSupplementary(position: .rightCenter, offset: .custom(.init(x: -15, y: 0)))]
        return label.list()
    }
    
    /// Products gallery
    /// - Returns: DSSection
    func gallerySection() -> DSSection {
        
        // 1
        let product1 = product(title: "Jack & Johns Shirt",
                               description: "New Brand",
                               price: DSPrice(amount: "50", regularAmount: "100", currency: "$", discountBadge: "50%OFF"),
                               image: p1Image)
        
        // 2
        let product2 = product(title: "Big Pony Mesh Shoes",
                               description: "Rebook",
                               price: DSPrice(amount: "35", regularAmount: "75", currency: "$", discountBadge: "50%OFF"),
                               image: p2Image)
        
        // 3
        let product3 = product(title: "Mesh Long-Sleeve yellow jacket",
                               description: "Dolce & Gabbana",
                               price: DSPrice(amount: "200", regularAmount: "100", currency: "$", discountBadge: "50% OFF"),
                               image: p3Image)
        
        let pageControl = DSPageControlVM(type: .viewModels([product1, product2, product3]), galleryType: .fullWidth)
        return pageControl.list().zeroLeftRightInset().zeroBottomInset()
    }
    
    /// Product image
    /// - Parameters:
    ///   - title: Title
    ///   - description: String
    ///   - price: DSPrice
    ///   - url: URL?
    /// - Returns: DSImageVM
    func product(title: String, description: String, price: DSPrice, image url: URL?) -> DSImageVM {
        
        // Image
        var imageViewModel = DSImageVM(imageUrl: url,
                                       height: .absolute(UIDevice.current.contentAreaHeight - 100),
                                       displayStyle: .default,
                                       contentMode: .scaleAspectFill)

        // Text
        let composer = DSTextComposer()
        
        let priceColors = DSDesignablePriceColor(currency: .black,
                                                 amount: .black,
                                                 regularAmount: UIColor.black.withAlphaComponent(0.5),
                                                 badgeBackground: .black,
                                                 badgeText: .white,
                                                 badgeCornerRadius: 5)
        
        composer.add(price: price, color: .custom(priceColors))
        composer.add(type: .text(font: .subheadline, color: .custom(UIColor.black.withAlphaComponent(0.5))), text: description)
        composer.add(type: .text(font: .headline, color: .custom(.black)), text: title)
        
        // Supplementary item
        let supItem = composer.textViewModel().asSupplementary(position: .leftBottom,
                                                               background: .lightBlur,
                                                               insets: .insets(.init(top: 15, left: 15, bottom: 15, right: 15)),
                                                               cornerRadius: .custom(5))
        imageViewModel.supplementaryItems = [supItem]
        
        return imageViewModel
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct ImageGallery2ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: ImageGallery2ViewController(), DSKitAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}

fileprivate let p1Image = URL(string: "https://images.pexels.com/photos/2899710/pexels-photo-2899710.jpeg?cs=srgb&dl=pexels-jonathan-borba-2899710.jpg&fm=jpg")
fileprivate let p2Image = URL(string: "https://images.pexels.com/photos/3651597/pexels-photo-3651597.jpeg?cs=srgb&dl=pexels-luca-nardone-3651597.jpg&fm=jpg")
fileprivate let p3Image = URL(string: "https://images.pexels.com/photos/4380970/pexels-photo-4380970.jpeg?cs=srgb&dl=pexels-maksim-goncharenok-4380970.jpg&fm=jpg")
