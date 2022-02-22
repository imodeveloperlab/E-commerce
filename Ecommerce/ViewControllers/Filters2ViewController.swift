//
//  Filters2ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class Filters2ViewController: DSViewController {
    
    var selectedSortBy = ["Boots"]
    var selectedSize = "9"
    var selectedColor = UIColor(0xFFC6A3)
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Filters"
        
        // Reset
        let reset = UIBarButtonItem(title: "Reset",
                                    style: .plain,
                                    target: self,
                                    action: #selector(resetAction))
        
        navigationItem.rightBarButtonItems = [reset]
        
        update()
    }
    
    @objc func resetAction() {
        self.dismiss()
    }
    
    func update() {
        
        // Show content
        show(content: [sortSection(), sizeSection(), colorsSection() , filtersSection()])
        
        // Add to cart button
        let viewAll = DSButtonVM(title: "View 245 Items") { [unowned self] tap in
            self.dismiss()
        }
        
        showBottom(content: viewAll)
    }
}

// MARK: - Sort Section
extension Filters2ViewController {
    
    func sortSection() -> DSSection {
        
        let options = ["Boots", "Chelsea Boots", "Casual Sneakers", "Casual Shoes"]
        
        let models = options.map { (title) -> DSViewModel in
            
            // Is selected
            let isSelected = selectedSortBy.contains(title)
            
            // Text
            let composer = DSTextComposer()
            composer.add(type: isSelected ? .headlineWithSize(15) : .subheadline, text: title)
            var model = composer.checkboxActionViewModel(selected: isSelected)
            
            // Handle action
            model.didTap { [unowned self] (_: DSActionVM) in
                
                // Handle add and remove from selected
                if self.selectedSortBy.contains(title) {
                    self.selectedSortBy.removeAll { (option) -> Bool in
                        option == title
                    }
                } else {
                    self.selectedSortBy.append(title)
                }
                
                self.update()
            }
            
            return model
        }
        
        return models.list().headlineHeader("Style")
    }
}

// MARK: - Size & Colors
extension Filters2ViewController {
    
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
        
        return sizeModels.gallery().headlineHeader("Size, UK")
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
        
        return colorModels.gallery().headlineHeader("Color")
    }
}

// MARK: - Filtes Section
extension Filters2ViewController {
    
    func filtersSection() -> DSSection {
        
        let filters = ["Size": "All",
                       "Brand": "Adidas, Puma, HRX",
                       "Color": "Black",
                       "Price": "$0-$999",
                       "Range": "All"]
        
        let models = filters.enumerated().map { (key, value) -> DSViewModel in
            
            // Title
            let composer = DSTextComposer()
            composer.add(type: .headlineWithSize(15), text: value.key)
            var model = composer.actionViewModel()
            
            // Right text
            let composer2 = DSTextComposer()
            composer2.add(type: .subheadline, text: value.value)
            model.rightText(composer: composer2)
            
            // Chevron
            let chevron = DSImageVM(imageValue: .sfSymbol(name: "chevron.right", style: .medium),
                                    height: .absolute(15),
                                    displayStyle: .default,
                                    contentMode: .scaleAspectFit)
            
            // Right side view
            model.rightSideView = DSSideView(view: chevron)
            
            // Handle action
            model.didTap { [unowned self] (_: DSActionVM) in
                self.update()
            }
            
            return model
        }
        
        return models.list().headlineHeader("Sort by")
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct Filters2ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            let nav = DSNavigationViewController(rootViewController: Filters2ViewController())
            PreviewContainer(VC: nav, DSKitAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
