//
//  PinterestSegmentScrollView.swift
//  Edwin
//
//  Created by 林季正 on 2021/3/19.
//

open class UIFastPageScrollView: UIScrollView {
    fileprivate let rootFlexContainer = UIView()
    
    var childViews: [UIView] = [] {
        didSet {
            self.rootFlexContainer.subviews.forEach { $0.removeFromSuperview() }
            childViews.forEach { self.rootFlexContainer.box.row.add($0.box.width(100%)) }
            self.page = 0
        }
    }
    
    var pageChanged: ((Int) -> Void)?
    var page = 0 {
        didSet {
            let contentOffsetX = self.frame.width * CGFloat(page)
            self.setContentOffset(CGPoint(x: contentOffsetX, y: 0), animated: true)
            pageChanged?(page)
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        self.delegate = self
        
        addSubview(rootFlexContainer)
        
        isPagingEnabled = true
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        scrollsToTop = false
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        rootFlexContainer.pin.all(pin.safeArea)
        rootFlexContainer.box.layout(mode: .adjustWidth)
        
        contentSize = rootFlexContainer.frame.size
    }
}

extension UIFastPageScrollView: UIScrollViewDelegate {
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = floor(scrollView.contentOffset.x / scrollView.frame.width)
        page = Int(currentPage)
    }
}
