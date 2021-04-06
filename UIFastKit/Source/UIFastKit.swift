//
//  UIFastView.swift
//  UIFastKit
//
//  Created by 林季正 on 2020/10/22.
//

import UIKit

@_exported import FlexLayout
@_exported import PinLayout

public class UIFastKitDSL {
    internal let view: UIView
    internal let flex: Flex
    internal var position: Flex.Position = .relative

    internal init(view: UIView) {
        self.view = view
        flex = view.flex
    }
    
    //
    // MARK: Flex item addition and definition
    //
    
    @discardableResult
    public func define(_ block: (_ box: UIFastKitDSL) -> Void) -> Self {
        block(self)
        return self
    }
    
    @discardableResult
    public func add() -> Self {
        let view = UIView()
        return add(view)
    }
    
    @discardableResult
    public func add(_ dsl: UIFastKitDSL) -> Self {
        add(dsl.view)
        return self
    }
    
    @discardableResult
    public func add(_ view: UIView) -> Self {
        flex.addItem(view)
        return self
    }
    
    //
    // MARK: Layout / intrinsicSize / sizeThatFits
    //
    
    public func layout(mode: Flex.LayoutMode = .fitContainer) {
        flex.layout(mode: mode)
    }
    
    public var isIncludedInLayout: Bool {
        get {
            return flex.isIncludedInLayout
        }
        set {
            flex.isIncludedInLayout = newValue
        }
    }
    
    @discardableResult
    public func isIncludedInLayout(_ included: Bool) -> Self {
        flex.isIncludedInLayout = included
        return self
    }
    
    @discardableResult
    public func markDirty() -> Self {
        flex.markDirty()
        return self
    }
    
    public func sizeThatFits(size: CGSize) -> CGSize {
        return flex.sizeThatFits(size: size)
    }
    
    //
    // MARK: Direction, wrap, flow
    //
    
    public func direction(_ direction: Flex.Direction) -> UIFastKitDSL {
        flex.direction(direction)
        return self
    }
    
    public var row: UIFastKitDSL {
        flex.direction(.row)
        return self
    }
    
    public var column: UIFastKitDSL {
        flex.direction(.column)
        return self
    }
    
    public var rowReverse: UIFastKitDSL {
        flex.direction(.rowReverse)
        return self
    }
    
    public var columnReverse: UIFastKitDSL {
        flex.direction(.columnReverse)
        return self
    }
    
    @discardableResult
    public func wrap(_ value: Flex.Wrap) -> Self {
        flex.wrap(value)
        return self
    }
    
    @discardableResult
    public func layoutDirection(_ value: Flex.LayoutDirection) -> Self {
        flex.layoutDirection(value)
        return self
    }
    
    //
    // MARK: justity, alignment, position
    //
    
    @discardableResult
    public func justifyContent(_ value: Flex.JustifyContent) -> Self {
        flex.justifyContent(value)
        return self
    }
    
    @discardableResult
    public func alignItems(_ value: Flex.AlignItems) -> Self {
        flex.alignItems(value)
        return self
    }
    
    @discardableResult
    public func alignSelf(_ value: Flex.AlignSelf) -> Self {
        flex.alignSelf(value)
        return self
    }
    
    @discardableResult
    public func alignContent(_ value: Flex.AlignContent) -> Self {
        flex.alignContent(value)
        return self
    }
    
    @discardableResult
    public func grow(_ value: CGFloat) -> Self {
        flex.grow(value)
        return self
    }
    
    @discardableResult
    public func shrink(_ value: CGFloat) -> Self {
        flex.shrink(value)
        return self
    }
    
    @discardableResult
    public func basic(_ value: CGFloat) -> Self {
        flex.basis(value)
        return self
    }
    
    @discardableResult
    public func basic(_ value: FPercent) -> Self {
        flex.basis(value)
        return self
    }
    
    //
    // MARK: Width / height / height
    //
    
    @discardableResult
    public func width(_ value: CGFloat?) -> Self {
        flex.width(value)
        return self
    }
    
    @discardableResult
    public func width(_ value: FPercent) -> Self {
        flex.width(value)
        return self
    }
    
    @discardableResult
    public func height(_ value: CGFloat?) -> Self {
        flex.height(value)
        return self
    }
    
    @discardableResult
    public func height(_ value: FPercent) -> Self {
        flex.height(value)
        return self
    }
    
    @discardableResult
    public func size(_ size: CGSize?) -> Self {
        flex.size(size)
        return self
    }
    
    @discardableResult
    public func size(_ sideLength: CGFloat) -> Self {
        flex.size(sideLength)
        return self
    }
    
    @discardableResult
    public func minWidth(_ value: CGFloat?) -> Self {
        flex.minWidth(value)
        return self
    }
    
    @discardableResult
    public func minWidth(_ value: FPercent) -> Self {
        flex.minWidth(value)
        return self
    }
    
    @discardableResult
    public func maxWidth(_ value: CGFloat?) -> Self {
        flex.maxWidth(value)
        return self
    }
    
    @discardableResult
    public func maxWidth(_ value: FPercent) -> Self {
        flex.maxWidth(value)
        return self
    }
    
    @discardableResult
    public func minHeight(_ value: CGFloat?) -> Self {
        flex.minHeight(value)
        return self
    }
    
    @discardableResult
    public func minHeight(_ value: FPercent) -> Self {
        flex.minHeight(value)
        return self
    }
    
    @discardableResult
    public func maxHeight(_ value: CGFloat?) -> Self {
        flex.maxHeight(value)
        return self
    }
    
    @discardableResult
    public func maxHeight(_ value: FPercent) -> Self {
        flex.maxHeight(value)
        return self
    }
    
    @discardableResult
    public func aspectRatio(_ value: CGFloat?) ->  Self {
        flex.aspectRatio(value)
        return self
    }
    
    @discardableResult
    public func aspectRatio(of imageView: UIImageView) -> Self {
        flex.aspectRatio(of: imageView)
        return self
    }
    
    //
    // MARK: Positionning
    //
    
    @discardableResult
    public func position(_ value: Flex.Position) -> Self {
        flex.position(value)
        position = value
        return self
    }
    
    //
    // MARK: Absolute positionning or margin
    //
    
    @discardableResult
    public func left(_ value: CGFloat) -> Self {
        if position == .absolute {
            flex.left(value)
        } else {
            flex.marginLeft(value)
        }
        return self
    }

    @discardableResult
    public func left(_ percent: FPercent) -> Self {
        if position == .absolute {
            flex.left(percent)
        } else {
            flex.marginLeft(percent)
        }
        return self
    }
    
    @discardableResult
    public func top(_ value: CGFloat) -> Self {
        if position == .absolute {
            flex.top(value)
        } else {
            flex.marginTop(value)
        }
        return self
    }

    @discardableResult
    public func top(_ percent: FPercent) -> Self {
        if position == .absolute {
            flex.top(percent)
        } else {
            flex.marginTop(percent)
        }
        return self
    }
    
    @discardableResult
    public func right(_ value: CGFloat) -> Self {
        if position == .absolute {
            flex.right(value)
        } else {
            flex.marginRight(value)
        }
        return self
    }

    @discardableResult
    public func right(_ percent: FPercent) -> Self {
        if position == .absolute {
            flex.right(percent)
        } else {
            flex.marginRight(percent)
        }
        return self
    }

    @discardableResult
    public func bottom(_ value: CGFloat) -> Self {
        if position == .absolute {
            flex.bottom(value)
        } else {
            flex.marginBottom(value)
        }
        return self
    }

    @discardableResult
    public func bottom(_ percent: FPercent) -> Self {
        if position == .absolute {
            flex.bottom(percent)
        } else {
            flex.marginBottom(percent)
        }
        return self
    }
    
    @discardableResult
    public func start(_ value: CGFloat) -> Self {
        if position == .absolute {
            flex.start(value)
        } else {
            flex.marginStart(value)
        }
        return self
    }

    @discardableResult
    public func start(_ percent: FPercent) -> Self {
        if position == .absolute {
            flex.start(percent)
        } else {
            flex.marginStart(percent)
        }
        return self
    }
    
    @discardableResult
    public func end(_ value: CGFloat) -> Self {
        if position == .absolute {
            flex.end(value)
        } else {
            flex.marginEnd(value)
        }
        return self
    }

    @discardableResult
    public func end(_ percent: FPercent) -> Self {
        if position == .absolute {
            flex.end(percent)
        } else {
            flex.marginEnd(percent)
        }
        return self
    }
    
    @discardableResult
    public func horizontally(_ value: CGFloat) -> Self {
        if position == .absolute {
            flex.horizontally(value)
        } else {
            flex.marginHorizontal(value)
        }
        return self
     }

    @discardableResult
    public func horizontally(_ percent: FPercent) -> Self {
        if position == .absolute {
            flex.horizontally(percent)
        } else {
            flex.marginHorizontal(percent)
        }
        return self
    }
    
    @discardableResult
    public func vertically(_ value: CGFloat) -> Self {
        if position == .absolute {
            flex.vertically(value)
        } else {
            flex.marginVertical(value)
        }
        return self
    }
    
    @discardableResult
    public func vertically(_ percent: FPercent) -> Self {
        if position == .absolute {
            flex.vertically(percent)
        } else {
            flex.marginVertical(percent)
        }
        return self
    }
    
    @discardableResult
    public func all(_ value: CGFloat) -> Self {
        if position == .absolute {
            flex.all(value)
        } else {
            flex.margin(value)
        }
        return self
    }
    
    @discardableResult
    public func all(_ percent: FPercent) -> Self {
        if position == .absolute {
            flex.all(percent)
        } else {
            flex.margin(percent)
        }
        return self
    }
    
    //
    // MARK: Padding
    //
    
    @discardableResult
    public func paddingTop(_ value: CGFloat) -> Self {
        flex.paddingTop(value)
        return self
    }

    @discardableResult
    public func paddingLeft(_ value: CGFloat) -> Self {
        flex.paddingLeft(value)
        return self
    }

    @discardableResult
    public func paddingBottom(_ value: CGFloat) -> Self {
        flex.paddingBottom(value)
        return self
    }

    @discardableResult
    public func paddingRight(_ value: CGFloat) -> Self {
        flex.paddingRight(value)
        return self
    }

    @discardableResult
    public func paddingStart(_ value: CGFloat) -> Self {
        flex.paddingStart(value)
        return self
    }

    @discardableResult
    public func paddingEnd(_ value: CGFloat) -> Self {
        flex.paddingEnd(value)
        return self
    }

    @discardableResult
    public func paddingHorizontal(_ value: CGFloat) -> Self {
        flex.paddingHorizontal(value)
        return self
    }

    @discardableResult
    public func paddingVertical(_ value: CGFloat) -> Self {
        flex.paddingVertical(value)
        return self
    }
    
    @discardableResult
    public func padding(_ value: CGFloat) -> Self {
        flex.padding(value)
        return self
    }
    
    @discardableResult
    public func padding(_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> Self {
        flex.padding(top, left, bottom, right)
        return self
    }
    
    //
    // MARK: Display
    //
   
    @discardableResult
    public func display(_ value: Flex.Display) -> Self {
        flex.display(value)
        return self
    }
    
}

public extension UIView {
    convenience init(_ tag: Int) {
        self.init(frame: .zero)
        self.tag = tag
    }
    
    var box: UIFastKitDSL {
        return UIFastKitDSL(view: self)
    }
}
