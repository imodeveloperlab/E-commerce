//
//  ItemDetails4ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class ItemDetails4ViewController: DSViewController {
    
    var selectedSize = "9"
    var selectedColor = UIColor(0xFFC6A3)
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Details"
        
        // Like
        let like = UIBarButtonItem(image: UIImage(systemName: "heart"),
                                   style: .plain,
                                   target: self,
                                   action: #selector(likeAction))
        
        navigationItem.rightBarButtonItems = [like]
        
        update()
    }
    
    @objc func shareAction() {
        self.dismiss()
    }
    
    @objc func likeAction() {
        self.dismiss()
    }
    
    @objc func wishList() {
        self.dismiss()
    }
    
    func update() {
        
        // Show content
        show(content: [picturesGallerySection(),
                       productInfoSection(),
                       colorsSection(),
                       sizeSection(),
                       descriptionSection()])
        
        // Add to cart button
        let addToCart = DSButtonVM(title: "Add to cart", icon: UIImage(systemName: "cart.fill")) { [unowned self] tap in
            self.dismiss()
        }
        
        // Show bottom content
        showBottom(content: [priceView(), addToCart].list())
    }
}

// MARK: - Sections
extension ItemDetails4ViewController {
    
    /// Product info section
    /// - Returns: DSSection
    func productInfoSection() -> DSSection {
        
        let composer = DSTextComposer()
        composer.add(type: .title2, text: "Ditsy Floral Sweetheart Neck Dress")
        composer.add(type: .subheadline, text: "Dolce & Gabbana", spacing: 5)
        
        composer.add(badge: "New",
                     type: .text(font: .headlineWithSize(14), color: .white),
                     backgroundColor: .systemGreen,
                     cornerRadius: 5)
        
        composer.add(type: .headline, text: " ", newLine: false)
        
        composer.add(rating: 4,
                     maximumValue: 5,
                     positiveSymbol: "star.fill",
                     negativeSymbol: "star",
                     style: .medium,
                     tint: .custom(.systemYellow),
                     spacing: 10, newLine: false)
        
        composer.add(type: .subheadline, text: " 4K ratings", newLine: false)
        
        return [composer.textViewModel()].list().zeroTopInset()
    }
    
    /// Price section
    /// - Returns: DSSection
    func priceView() -> DSViewModel {
        
        // Text
        let text = DSTextComposer()
        text.add(price: DSPrice(amount: "99",
                                regularAmount: "120",
                                currency: "$",
                                discountBadge: "-21$"),
                 size: .large,
                 newLine: false)
        
        return text.textViewModel()
    }
    
    /// Description
    /// - Returns: DSSection
    func descriptionSection() -> DSSection {
        
        let text = "In the 11th century, women in Europe wore dresses that were similar to men's tunics and were loose, with a hemline reaching to below the knees or lower."
        
        let label = DSLabelVM(.caption1, text: text, alignment: .left)
        
        return [label].list()
    }
    
    /// Gallery section
    /// - Returns: DSSection
    func picturesGallerySection() -> DSSection {
        
        let urls = [p1Image,
                    p2Image,
                    p3Image].compactMap({ $0 })
        
        let pictureModels = urls.map { url -> DSViewModel in
            return DSImageVM(imageUrl: url, height: .absolute(220))
        }
        
        let pageControl = DSPageControlVM(type: .viewModels(pictureModels))
        return pageControl.list().zeroLeftRightInset()
    }
}

// MARK: - Size & Colors
extension ItemDetails4ViewController {
    
    /// Gallery section
    /// - Returns: DSSection
    func sizeSection() -> DSSection {
        
        let sizes = ["8", "9", "10", "11", "12", "13", "14", "15", "16"]
        
        let sizeModels = sizes.map { (size) -> DSViewModel in
            
            // Is selected
            let isSelected = selectedSize == size
            
            // Label
            var label = DSLabelVM(.headline, text: size, alignment: .center)
            label.style.displayStyle = .grouped(inSection: false)
            label.style.borderStyle = isSelected ? .brandColor : .none
            
            // Handle tap
            label.didTap { [unowned self] (_: DSLabelVM) in
                self.selectedSize = size
                self.update()
            }
            
            label.width = .absolute(50)
            label.height = .absolute(40)
            
            return label
        }
        
        return sizeModels.gallery().subheadlineHeader("Size")
    }
    
    /// Colors section
    /// - Returns: DSSection
    func colorsSection() -> DSSection {
        
        let colors = [UIColor(0xFFC6A3),
                      UIColor(0xF88F6F),
                      UIColor(0x5CB946),
                      UIColor(0x006A7A),
                      UIColor(0xC3FCF1),
                      UIColor(0x28527a),
                      UIColor(0x8ac4d0),
                      UIColor(0xfbeeac)]
        
        let colorModels = colors.map { (color) -> DSViewModel in
            
            let isSelected = selectedColor == color
            
            var colorView = DSColorVM(color: color)
            colorView.width = .absolute(40)
            colorView.height = .absolute(40)
            colorView.style.borderStyle = isSelected ? .brandColor : .none
            colorView.style.colorStyle = .custom(DSAppearance.shared.main.secondaryView)
            
            // Handle tap
            colorView.didTap { [unowned self] (_: DSColorVM) in
                self.selectedColor = color
                self.update()
            }
            
            return colorView
        }
        
        return colorModels.gallery().subheadlineHeader("Color")
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct ItemDetails4ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            let nav = DSNavigationViewController(rootViewController: ItemDetails4ViewController())
            PreviewContainer(VC: nav, DSKitAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}

fileprivate let p1Image = URL(string: "https://images.pexels.com/photos/5085329/pexels-photo-5085329.jpeg?cs=srgb&dl=pexels-jonathan-borba-5085329.jpg&fm=jpg")
fileprivate let p2Image = URL(string: "https://images.pexels.com/photos/2122361/pexels-photo-2122361.jpeg?cs=srgb&dl=pexels-kyle-roxas-2122361.jpg&fm=jpg")
fileprivate let p3Image = URL(string: "https://images.pexels.com/photos/2946811/pexels-photo-2946811.jpeg?cs=srgb&dl=pexels-engin-akyurt-2946811.jpg&fm=jpg")
