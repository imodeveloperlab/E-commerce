//
//  EcommerceRootViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import UIKit

open class EcommerceRootViewController: DSViewController {
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "E-Commerce"
        
        let login1 = DSActionVM(title: "Login 1") { [unowned self] action in
            self.present(vc: LogIn1ViewController(), presentationStyle: .fullScreen)
        }
        
        let login2 = DSActionVM(title: "Login 2") { [unowned self] action in
            self.present(vc: LogIn2ViewController(), presentationStyle: .fullScreen)
        }
        
        let login3 = DSActionVM(title: "Login 3") { [unowned self] action in
            self.present(vc: LogIn3ViewController(), presentationStyle: .fullScreen)
        }
        
        let login4 = DSActionVM(title: "Login 4") { [unowned self] action in
            self.present(vc: LogIn4ViewController(), presentationStyle: .fullScreen)
        }
        
        let logInSection = [login1, login2, login3, login4].list()
        logInSection.subheadlineHeader("Login")
        
        let signUp1 = DSActionVM(title: "Sign Up 1") { [unowned self] action in
            self.present(vc: SignUp1ViewController(), presentationStyle: .fullScreen)
        }
        
        let signUp2 = DSActionVM(title: "Sign Up 2") { [unowned self] action in
            self.present(vc: SignUp2ViewController(), presentationStyle: .fullScreen)
        }
        
        let signUp3 = DSActionVM(title: "Sign Up 3") { [unowned self] action in
            self.present(vc: SignUp3ViewController(), presentationStyle: .fullScreen)
        }
        
        let signUp4 = DSActionVM(title: "Sign Up 4") { [unowned self] action in
            self.present(vc: SignUp4ViewController(), presentationStyle: .fullScreen)
        }
        
        let signUpSection = [signUp1, signUp2, signUp3, signUp4].list()
        signUpSection.subheadlineHeader("Sign Up")
        
        let subscriptionPlan = DSActionVM(title: "Subscription Plan") { [unowned self] action in
            self.present(vc: SubscriptionPlan1ViewController(), presentationStyle: .fullScreen)
        }
        
        let plansSection = [subscriptionPlan].list()
        plansSection.subheadlineHeader("Plans")
        
        let home1 = DSActionVM(title: "Home 1") { [unowned self] action in
            self.present(vc: Home1ViewController(), presentationStyle: .fullScreen)
        }
        
        let home2 = DSActionVM(title: "Home 2") { [unowned self] action in
            self.present(vc: Home2ViewController(), presentationStyle: .fullScreen)
        }
        
        let home3 = DSActionVM(title: "Home 3") { [unowned self] action in
            self.present(vc: Home3ViewController(), presentationStyle: .fullScreen)
        }
        
        let home4 = DSActionVM(title: "Home 4") { [unowned self] action in
            self.present(vc: Home4ViewController(), presentationStyle: .fullScreen)
        }
        
        let homeSection = [home1, home2, home3, home4].list()
        homeSection.subheadlineHeader("Home")
        
        let categories1 = DSActionVM(title: "Categories 1") { [unowned self] action in
            self.present(vc: Categories1ViewController(), presentationStyle: .fullScreen)
        }
        
        let categories2 = DSActionVM(title: "Categories 2") { [unowned self] action in
            self.present(vc: Categories2ViewController(), presentationStyle: .fullScreen)
        }
        
        let categories3 = DSActionVM(title: "Categories 3") { [unowned self] action in
            self.present(vc: Categories3ViewController(), presentationStyle: .fullScreen)
        }
        
        let categories4 = DSActionVM(title: "Categories 4") { [unowned self] action in
            self.present(vc: Categories4ViewController(), presentationStyle: .fullScreen)
        }
        
        let categories5 = DSActionVM(title: "Categories 5") { [unowned self] action in
            self.push(Categories5ViewController())
        }
        
        let categories6 = DSActionVM(title: "Categories 6") { [unowned self] action in
            self.present(vc: Categories6ViewController(), presentationStyle: .fullScreen)
        }
        
        let categoriesSection = [categories1, categories2, categories3, categories4, categories5, categories6].list()
        categoriesSection.subheadlineHeader("Categories")
        
        let items1 = DSActionVM(title: "Items 1") { [unowned self] action in
            self.push(Items1ViewController())
        }
        
        let items2 = DSActionVM(title: "Items 2") { [unowned self] action in
            self.push(Items2ViewController())
        }
        
        let items3 = DSActionVM(title: "Items 3") { [unowned self] action in
            self.push(Items3ViewController())
        }
        
        let items4 = DSActionVM(title: "Items 4") { [unowned self] action in
            self.push(Items4ViewController())
        }
        
        let items5 = DSActionVM(title: "Items 5") { [unowned self] action in
            self.push(Items5ViewController())
        }
        
        let items6 = DSActionVM(title: "Items 6") { [unowned self] action in
            self.push(Items6ViewController())
        }
        
        let items7 = DSActionVM(title: "Items 7") { [unowned self] action in
            self.push(Items7ViewController())
        }
        
        let items8 = DSActionVM(title: "Items 8") { [unowned self] action in
            self.push(Items8ViewController())
        }
        
        let itemsSection = [items1, items2, items3, items4, items5, items6, items7, items8].list()
        itemsSection.subheadlineHeader("Items")
        
        let search1 = DSActionVM(title: "Search 1") { [unowned self] action in
            self.presentInNavigationController(vc: Search1ViewController(), presentationStyle: .fullScreen)
        }
        
        let search2 = DSActionVM(title: "Search 2") { [unowned self] action in
            self.presentInNavigationController(vc: Search2ViewController(), presentationStyle: .fullScreen)
        }
        
        let searchSection = [search1, search2].list()
        searchSection.subheadlineHeader("Search")
        
        let imageGallery1 = DSActionVM(title: "Image Gallery 1") { [unowned self] action in
            self.present(vc: ImageGallery1ViewController(), presentationStyle: .fullScreen)
        }
        
        let imageGallery2 = DSActionVM(title: "Image Gallery 2") { [unowned self] action in
            self.present(vc: ImageGallery2ViewController(), presentationStyle: .fullScreen)
        }
        
        let imageGallerySection = [imageGallery1, imageGallery2].list()
        imageGallerySection.subheadlineHeader("Image Gallery")
        
        let itemDetails1 = DSActionVM(title: "Items Details 1") { [unowned self] action in
            self.push(ItemDetails1ViewController())
        }
        
        let itemDetails2 = DSActionVM(title: "Items Details 2") { [unowned self] action in
            self.push(ItemDetails2ViewController())
        }
        
        let itemDetails3 = DSActionVM(title: "Items Details 3") { [unowned self] action in
            self.push(ItemDetails3ViewController())
        }
        
        let itemDetails4 = DSActionVM(title: "Items Details 4") { [unowned self] action in
            self.push(ItemDetails4ViewController())
        }
        
        let itemDetails5 = DSActionVM(title: "Items Details 5") { [unowned self] action in
            self.push(ItemDetails5ViewController())
        }
        
        let itemDetailsSection = [itemDetails1, itemDetails2, itemDetails3, itemDetails4, itemDetails5].list()
        itemDetailsSection.subheadlineHeader("Items Details")
        
        let filters1 = DSActionVM(title: "Filters 1") { [unowned self] action in
            self.push(Filters1ViewController())
        }
        
        let filters2 = DSActionVM(title: "Filters 2") { [unowned self] action in
            self.push(Filters2ViewController())
        }
        
        let filters3 = DSActionVM(title: "Filters 3") { [unowned self] action in
            self.push(Filters3ViewController())
        }
        
        let filtersSection = [filters1, filters2, filters3].list()
        filtersSection.subheadlineHeader("Filters")
        
        let cart1 = DSActionVM(title: "Cart 1") { [unowned self] action in
            self.push(ItemsCart1ViewController())
        }
        
        let cart2 = DSActionVM(title: "Cart 2") { [unowned self] action in
            self.push(ItemsCart2ViewController())
        }
        
        let cart3 = DSActionVM(title: "Cart 3") { [unowned self] action in
            self.push(ItemsCart3ViewController())
        }
        
        let cart4 = DSActionVM(title: "Cart 4") { [unowned self] action in
            self.push(ItemsCart4ViewController())
        }
        
        let cart5 = DSActionVM(title: "Cart 5") { [unowned self] action in
            self.push(ItemsCart5ViewController())
        }
        
        let cartSection = [cart1, cart2, cart3, cart4, cart5].list()
        cartSection.subheadlineHeader("Cart")
        
        let aboutUs1 = DSActionVM(title: "About Us 1") { [unowned self] action in
            self.push(AboutUs1ViewController())
        }
        
        let aboutUs2 = DSActionVM(title: "About Us 2") { [unowned self] action in
            self.push(AboutUs2ViewController())
        }
        
        let aboutUs1Section = [aboutUs1, aboutUs2].list()
        aboutUs1Section.subheadlineHeader("About Us")
        
        let feedback = DSActionVM(title: "Feedback 1") { [unowned self] action in
            self.present(vc: Feedback1ViewController(), presentationStyle: .formSheet)
        }
        
        let feedback1Section = [feedback].list()
        feedback1Section.subheadlineHeader("Feedback")
        
        let profile1 = DSActionVM(title: "Profile 1") { [unowned self] action in
            self.push(Profile1ViewController())
        }
        
        let profile2 = DSActionVM(title: "Profile 2") { [unowned self] action in
            self.push(Profile2ViewController())
        }
        
        let profile3 = DSActionVM(title: "Profile 3") { [unowned self] action in
            self.push(Profile3ViewController())
        }
        
        let profileSection = [profile1, profile2, profile3].list()
        profileSection.subheadlineHeader("Profile")
        
        let notifications1 = DSActionVM(title: "Notifications 1") { [unowned self] action in
            self.present(vc: Notifications1ViewController(), presentationStyle: .overFullScreen)
        }
        
        let notificationsSection = [notifications1].list()
        notificationsSection.subheadlineHeader("Notifications")
        
        let walktrought1 = DSActionVM(title: "Walktrought 1") { [unowned self] action in
            self.present(vc: Walktrought1ViewController(), presentationStyle: .overFullScreen)
        }
        
        let walktroughtSection = [walktrought1].list()
        walktroughtSection.subheadlineHeader("Walktrought")
        
        let payment1 = DSActionVM(title: "Payment 1") { [unowned self] action in
            self.push(Payment1ViewController())
        }
        
        let payment2 = DSActionVM(title: "Payment 2") { [unowned self] action in
            self.push(Payment2ViewController())
        }
        
        let paymentSection = [payment1, payment2].list()
        paymentSection.subheadlineHeader("Payment")
        
        let shipping1 = DSActionVM(title: "Shipping 1") { [unowned self] action in
            self.push(Shipping1ViewController())
        }
        
        let shipping2 = DSActionVM(title: "Shipping 2") { [unowned self] action in
            self.push(Shipping2ViewController())
        }
        
        let shippingSection = [shipping1, shipping2].list()
        shippingSection.subheadlineHeader("Shipping")
        
        let order1 = DSActionVM(title: "Order 1") { [unowned self] action in
            self.push(Order1ViewController())
        }
        
        let order2 = DSActionVM(title: "Order 2") { [unowned self] action in
            self.push(Order2ViewController())
        }
        
        let order3 = DSActionVM(title: "Order 3") { [unowned self] action in
            self.present(vc: Order3ViewController(), presentationStyle: .overFullScreen)
        }
        
        let order4 = DSActionVM(title: "Order 4") { [unowned self] action in
            self.present(vc: Order4ViewController(), presentationStyle: .overFullScreen)
        }
        
        let orderSection = [order1, order2, order3, order4].list()
        orderSection.subheadlineHeader("Order")
        
        show(content: walktroughtSection, logInSection, signUpSection, homeSection, profileSection, notificationsSection, feedback1Section, aboutUs1Section, cartSection, filtersSection, itemDetailsSection, imageGallerySection, searchSection, itemsSection, categoriesSection, plansSection, paymentSection, shippingSection, orderSection)
        
        // Close
        let close = UIBarButtonItem(barButtonSystemItem: .close, target: self, action:  #selector(closeDemo))
        navigationItem.rightBarButtonItems = [close]
    }
    
    @objc func closeDemo() {
        self.dismiss()
    }
}
