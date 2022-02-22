//
//  Filters3ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class Filters3ViewController: DSViewController {
    
    var selectedSortBy = ["Boots"]
    var selectedSize = "9"
    var selectedColor = UIColor(0xFFC6A3)
    var selectedRange: Float = 40
    
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
        show(content: [ filtersSection(),
                        sizeSection(),
                        colorsSection()])
        
        // Add to cart button
        let viewAll = DSButtonVM(title: "View 245 Items") { [unowned self] tap in
            self.dismiss()
        }
        
        showBottom(content: viewAll)
    }
}

// MARK: - Size & Colors
extension Filters3ViewController {
    
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
extension Filters3ViewController {
    
    /// Filter section
    /// - Returns: DSSection
    func filtersSection() -> DSSection {
        
        let brand = filter(title: "Brand", subtitle: "Adidas, Puma, HRX")
        let shipping = filterWitSwitch(title: "Free Shipping", enabled: true)
        let shippingTo = filter(title: "Shipping to", subtitle: "London UK")
        let range = rangeModel()
        
        return [brand, shipping, shippingTo, range].list().headlineHeader("Sort by")
    }
    
    /// Filter
    /// - Parameters:
    ///   - title: String
    ///   - subtitle: String
    /// - Returns: DSViewModel
    func filter(title: String, subtitle: String) -> DSViewModel {
        
        // Title
        let composer = DSTextComposer()
        composer.add(type: .headlineWithSize(15), text: title)
        var model = composer.actionViewModel()
        
        // Right text
        let composer2 = DSTextComposer()
        composer2.add(type: .subheadline, text: subtitle)
        model.rightText(composer: composer2)
        
        // Chevron
        let chevron = DSImageVM(imageValue: .sfSymbol(name: "chevron.right", style: .medium),
                                height: .absolute(15),
                                displayStyle: .default,
                                contentMode: .scaleAspectFit)
        
        // Right side view
        model.rightSideView = DSSideView(view: chevron)
        model.height = .absolute(45)
        
        // Handle action
        model.didTap { [unowned self] (_: DSActionVM) in
            self.pop()
        }
        
        return model
    }
    
    /// Filter with switch
    /// - Parameters:
    ///   - title: String
    ///   - enabled: Bool
    /// - Returns: DSViewModel
    func filterWitSwitch(title: String, enabled: Bool) -> DSViewModel {
        
        // Title
        let composer = DSTextComposer()
        composer.add(type: .headlineWithSize(15), text: title)
        var model = composer.actionViewModel()
        model.height = .absolute(50)
        
        var switchModel = DSSwitchVM(isOn: true)
        switchModel.didUpdate = { isOn in
            print(isOn)
        }
        
        model.rightSideView = DSSideView(view: switchModel)
        return model
    }
    
    /// Select range model
    /// - Returns: DSViewModel
    func rangeModel() -> DSViewModel {
        
        // Text
        let composer = DSTextComposer()
        composer.add(type: .headlineWithSize(15), text: "Range")
        let text = composer.textViewModel()
        
        // Slider
        var slider = DSSliderVM(minimValue: 10, maximValue: 100, value: selectedRange)
        slider.style.displayStyle = .grouped(inSection: false)
        slider.labelSuffix = "km"
        slider.leftSideView = DSSideView(view: text)
        
        // Handle slider did update
        slider.didUpdate = { [weak self] value in
            self?.selectedRange = value
        }
        
        slider.height = .absolute(50)
        
        return slider
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct Filters3ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            let nav = DSNavigationViewController(rootViewController: Filters3ViewController())
            PreviewContainer(VC: nav, DSKitAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
