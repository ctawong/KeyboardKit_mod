//
//  KeyboardViewController.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit
import KeyboardKit
import KeyboardKitPro
import SwiftUI
import Combine

/**
 This SwiftUI-based demo keyboard demonstrates how to create
 a keyboard extension using `KeyboardKit` and `SwiftUI`.
 
 This keyboard manually registers demo-specific services. It
 has also copied a Swedish keyboard input set provider and a
 secondary callout action provider from KeyboardKit Pro just
 to show you how to do it without using KeyboardKit Pro.
 
 `IMPORTANT` To use this keyboard, you must enable it in the
 system keyboard settings ("Settings/General/Keyboards"). It
 needs full access for haptic and audio feedback.
 */
class KeyboardViewController: KeyboardInputViewController {
    
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        
        // Perform the bae initialization
        super.viewDidLoad()
        
        // Setup a demo-specific autocomplete provider
        // 💡 This is overwritten if Pro is registered below
        autocompleteSuggestionProvider = DemoAutocompleteSuggestionProvider()
        
        // Setup the demo to explicitly use English locale
        // 💡 The demo has additional Swedish support
        // 💡 If you register Pro below, you get all locales
        keyboardContext.locale = KeyboardLocale.english.locale
        
        // Setup the locales that the keyboard supports
        // 💡 This is the order in which locales are listed
        // 💡 This is overwritten if Pro is registered below
        keyboardContext.locales = [
            KeyboardLocale.english.locale,
            KeyboardLocale.swedish.locale
        ]
        
        // Setup a custom, demo-specific action handler
        // 💡 Use custom handlers to handle custom logic
        keyboardActionHandler = DemoKeyboardActionHandler(
            inputViewController: self,
            toastContext: toastContext)
        
        // Setup an input set provider with multiple locales
        // 💡 An input set specifies the keyboard input keys
        // 💡 This is overwritten if Pro is registered below
        keyboardInputSetProvider = StandardKeyboardInputSetProvider(
            context: keyboardContext,
            providers: [
                EnglishKeyboardInputSetProvider(),
                SwedishKeyboardInputSetProvider()])
        
        // Setup a layout with .emojis instead of .dictation
        // 💡 A keyboard layout specifies the all keys/sizes
        keyboardLayoutProvider = DemoKeyboardLayoutProvider(
            inputSetProvider: keyboardInputSetProvider,
            dictationReplacement: .keyboardType(.emojis))
        
        // Setup a secondary callout action provider with multiple locales
        // 💡 This is overwritten if Pro is registered below
        keyboardSecondaryCalloutActionProvider = StandardSecondaryCalloutActionProvider(
            context: keyboardContext,
            providers: [
                EnglishSecondaryCalloutActionProvider(),
                SwedishSecondaryCalloutActionProvider()])
        
        // keyboardAppearance can be used to style keyboards
        // keyboardAppearance = ColorTheme(context: keyboardContext)
        // view.backgroundColor = UIColor(keyboardAppearance.keyboardBackgroundColor)
        
        // Setup the extension to use the keyboardView below
        // 💡 Enable this line to run demo without Pro mode.
        // setup(with: keyboardView)

        // Setup KeyboardKit Pro. This unlocks more features.
        // 💡 Disable this line to run demo without Pro mode.
        setupPro(withLicenseKey: "299B33C6-061C-4285-8189-90525BCAF098", view: keyboardView)
    }
    
    
    // MARK: - Properties
    
    private lazy var toastContext = KeyboardToastContext()
    
    private var keyboardView: some View {
        KeyboardView(
            actionHandler: keyboardActionHandler,
            appearance: keyboardAppearance,
            layoutProvider: keyboardLayoutProvider)
            .environmentObject(toastContext)
    }
    
    
    // MARK: - Autocomplete
    
    /**
     Override this function to add custom autocomplete logic
     to your keyboard extension.
     */
    override func performAutocomplete() {
        super.performAutocomplete()
    }
    
    /**
     Override this function to add custom autocomplete reset
     logic to your keyboard extension.
     */
    override func resetAutocomplete() {
        super.resetAutocomplete()
    }
}
