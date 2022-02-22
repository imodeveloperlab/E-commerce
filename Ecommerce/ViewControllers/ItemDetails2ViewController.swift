//
//  ItemDetails2ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class ItemDetails2ViewController: DSViewController {
    
    var selectedSize = "US 5.5"
    var selectedColor = "nike_1"
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Details"
        
        // Like
        let like = UIBarButtonItem(image: UIImage(systemName: "heart"),
                                   style: .plain,
                                   target: self,
                                   action: #selector(likeAction))
        
        // Filter
        let share = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"),
                                    style: .plain,
                                    target: self,
                                    action: #selector(shareAction))
        
        // Sort
        let wishlist = UIBarButtonItem(image: UIImage(systemName: "text.badge.plus"),
                                       style: .plain,
                                       target: self,
                                       action: #selector(wishList))
        
        navigationItem.rightBarButtonItems = [like, share, wishlist]
        
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
                       priceSection(),
                       colorsSection(),
                       sizeSection(),
                       descriptionSection()])
        
        // Add to cart button
        let addToCart = DSButtonVM(title: "Add to cart", icon: UIImage(systemName: "cart.fill")) { [unowned self] tap in
            self.dismiss()
        }
        
        // Show bottom content
        showBottom(content: addToCart)
    }
}

// MARK: - Sections
extension ItemDetails2ViewController {
    
    /// Product info section
    /// - Returns: DSSection
    func productInfoSection() -> DSSection {
        
        let composer = DSTextComposer()
        composer.add(type: .title2, text: "Women's Running Shoe")
        composer.add(type: .subheadline, text: "Nike Revolution 5")
        
        return [composer.textViewModel()].list().zeroTopInset()
    }
    
    /// Price section
    /// - Returns: DSSection
    func priceSection() -> DSSection {
        
        // Text
        let text = DSTextComposer()
        text.add(price: DSPrice(amount: "100",
                                regularAmount: "120",
                                currency: "$",
                                discountBadge: "-20$"),
                 size: .large, newLine: false)
        
        // Action
        var action = DSActionVM(composer: text)
        action.style.displayStyle = .default
        action.height = .absolute(30)
        
        // Picker
        let picker = DSQuantityPickerVM(quantity: 1)
        picker.width = .absolute(120)
        picker.height = .absolute(35)
        
        // Supplementary view
        let supView = picker.asSupplementary(position: .rightCenter,
                                             insets: .small,
                                             offset: .custom(.init(x: -5, y: 0)))
        action.supplementaryItems = [supView]
        return action.list()
    }
    
    /// Description
    /// - Returns: DSSection
    func descriptionSection() -> DSSection {
        
        let text = "The Nike Revolution 5 cushions your stride with soft foam to keep you running in comfort. Lightweight knit material wraps your foot in breathable support, while a minimalist design fits in anywhere your day takes you."
        
        let label = DSLabelVM(.callout, text: text, alignment: .left)
        
        return [label].list()
    }
    
    /// Gallery section
    /// - Returns: DSSection
    func picturesGallerySection() -> DSSection {
        
        let urls = [p1Image,
                    p2Image,
                    p3Image].compactMap({ $0 })
        
        let pictureModels = urls.map { url -> DSViewModel in
            return DSImageVM(imageUrl: url, height: .absolute(220), displayStyle: .default)
        }
        
        let pageControl = DSPageControlVM(type: .viewModels(pictureModels), galleryType: .fullWidth)
        return pageControl.list().zeroLeftRightInset().zeroTopInset()
    }
}

// MARK: - Size & Colors
extension ItemDetails2ViewController {
    
    /// Gallery section
    /// - Returns: DSSection
    func sizeSection() -> DSSection {
        
        let sizes = ["US 5", "US 5.5", "US 6", "US 6.5", "US 7", "US 7.5", "US 8", "US 8.5", "US 9"]
        
        let sizeModels = sizes.map { (size) -> DSViewModel in
            
            // Is selected
            let isSelected = selectedSize == size
            
            // Label
            var label = DSLabelVM(.headlineWithSize(12), text: size, alignment: .center)
            label.style.displayStyle = .grouped(inSection: false)
            label.style.borderStyle = isSelected ? .brandColor : .none
            
            // Handle tap
            label.didTap { [unowned self] (_: DSLabelVM) in
                self.selectedSize = size
                self.update()
            }
            
            return label
        }
        
        return sizeModels.grid(columns: 4).subheadlineHeader("Select Size")
    }
    
    /// Colors section
    /// - Returns: DSSection
    func colorsSection() -> DSSection {
        
        let colors = ["nike_1", "nike_2", "nike_3", "nike_4", "nike_5", "nike_6"]
        
        let colorModels = colors.map { (imageName) -> DSViewModel in
            
            let isSelected = selectedColor == imageName
            
            let image = UIImage(named: imageName,
                                in: Bundle(for: self.classForCoder),
                                compatibleWith: nil)
            
            var imageModel = DSImageVM(image: image)
            imageModel.width = .absolute(90)
            imageModel.height = .absolute(60)
            imageModel.style.borderStyle = isSelected ? .brandColor : .none
            imageModel.style.colorStyle = .custom(DSAppearance.shared.main.secondaryView)
            
            // Handle tap
            imageModel.didTap { [unowned self] (_: DSImageVM) in
                self.selectedColor = imageName
                self.update()
            }
            
            return imageModel
        }
        
        return colorModels.gallery().subheadlineHeader("Select Color")
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct ItemDetails2ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            let nav = DSNavigationViewController(rootViewController: ItemDetails2ViewController())
            PreviewContainer(VC: nav, DSKitAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}

fileprivate let p1Image = URL(string: "https://images.pexels.com/photos/1598505/pexels-photo-1598505.jpeg?cs=srgb&dl=pexels-mnz-1598505.jpg&fm=jpg")
fileprivate let p2Image = URL(string: "https://images.pexels.com/photos/3261069/pexels-photo-3261069.jpeg?cs=srgb&dl=pexels-wallace-chuck-3261069.jpg&fm=jpg")
fileprivate let p3Image = URL(string: "https://images.pexels.com/photos/5710082/pexels-photo-5710082.jpeg?cs=srgb&dl=pexels-ox-street-5710082.jpg&fm=jpg")
