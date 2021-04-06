//
//  UIFastButtonGroup.swift
//  UIFastKit
//
//  Created by 林季正 on 2021/4/6.
//

import UIKit

public protocol UIFastButtonGroup {
    var buttons: [UIButton] { get set }
        
    func append(_ button: UIButton)
}

public class UIFastButtonSingleOptionalChoice: UIFastButtonGroup {
    public var buttons: [UIButton] = []
    
    private var _onSelectedIndexChanged: ((Int?, [UIButton], UIFastButtonSingleOptionalChoice) -> Void)?
    public func onSelectedIndexChanged(_ closure: ((Int?, [UIButton], UIFastButtonSingleOptionalChoice) -> Void)?) {
        _onSelectedIndexChanged = closure
    }
    
    public var selectedIndex: Int? {
        get {
            for (index, button) in buttons.enumerated() {
                if button.isSelected {
                    return index
                }
            }
            return nil
        }
        set {
            buttons.forEach { $0.isSelected = false }
            
            if let i = newValue {
                _toggle(buttons[i], shouldCallback: false)
            }
            
            _onSelectedIndexChanged?(selectedIndex, buttons, self)
        }
    }
    
    public init() { }
    
    private func _toggle(_ button: UIButton, shouldCallback: Bool = true) {
        if let selectedButton = getSelectedButton(), button == selectedButton {
            button.isSelected = false
        } else {
            buttons.forEach { $0.isSelected = false }
            button.isSelected = true
        }
        
        if shouldCallback {
            _onSelectedIndexChanged?(selectedIndex, buttons, self)
        }
    }
    
    @objc func toggle(_ button: UIButton) {
        _toggle(button)
    }
    
    public func append(_ button: UIButton) {
        buttons.append(button)
        button.addTarget(self, action: #selector(toggle(_:)), for: .touchUpInside)
    }
    
    func getSelectedButton() -> UIButton? {
        return buttons.filter { $0.isSelected }.first
    }
}

public class UIFastButtonSingleChoice: UIFastButtonGroup {
    public var buttons: [UIButton] = []
    
    private var _onSelectedIndexChanged: ((Int, [UIButton], UIFastButtonSingleChoice) -> Void)?
    public func onSelectedIndexChanged(_ closure: ((Int, [UIButton], UIFastButtonSingleChoice) -> Void)?) {
        _onSelectedIndexChanged = closure
    }
    public var selectedIndex: Int {
        get {
            for (index, button) in buttons.enumerated() {
                if button.isSelected {
                    return index
                }
            }
            fatalError("UIFastButtonSingleChoice can not be empty")
        }
        set {
            _toggle(buttons[newValue], shouldCallback: false)
            
            _onSelectedIndexChanged?(selectedIndex, buttons, self)
        }
    }
    
    public init() { }
    
    private func _toggle(_ button: UIButton, shouldCallback: Bool = true) {
        buttons.forEach { $0.isSelected = false }
        button.isSelected = true
        
        if shouldCallback {
            _onSelectedIndexChanged?(selectedIndex, buttons, self)
        }
    }
    
    @objc func toggle(_ button: UIButton) {
        _toggle(button)
    }
    
    public func append(_ button: UIButton) {
        buttons.append(button)
        if buttons.count == 1 {
            button.isSelected = true
        }
        button.addTarget(self, action: #selector(toggle(_:)), for: .touchUpInside)
    }
    
    func getSelectedButton() -> UIButton {
        return buttons.filter { $0.isSelected }.first!
    }
}

public class UIFastButtonMultipleChoice: UIFastButtonGroup {
    public var buttons: [UIButton] = []
    
    private var _onSelectedIndexesChanged: (([Int], [UIButton], UIFastButtonMultipleChoice) -> Void)?
    public func onSelectedIndexesChanged(_ closure: (([Int], [UIButton], UIFastButtonMultipleChoice) -> Void)?) {
        _onSelectedIndexesChanged = closure
    }

    public var selectedIndexes: [Int] {
        get {
            var result: [Int] = []
            for (index, button) in buttons.enumerated() {
                if button.isSelected {
                    result.append(index)
                }
            }
            return result
        }
        set {
            for (index, button) in buttons.enumerated() {
                button.isSelected = newValue.contains(index)
            }
            _onSelectedIndexesChanged?(selectedIndexes, buttons, self)
        }
    }
    
    public init() {
        
    }
    
    private func _toggle(_ button: UIButton, shouldCallback: Bool = true) {
        button.isSelected = !button.isSelected
        
        if shouldCallback {
            _onSelectedIndexesChanged?(selectedIndexes, buttons, self)
        }
    }
    
    @objc func toggle(_ button: UIButton) {
        _toggle(button)
    }
    
    public func append(_ button: UIButton) {
        buttons.append(button)
        button.addTarget(self, action: #selector(toggle(_:)), for: .touchUpInside)
    }
}

public extension UIButton {
    func group(_ group: UIFastButtonGroup) -> Self {
        group.append(self)
        
        return self
    }
}
