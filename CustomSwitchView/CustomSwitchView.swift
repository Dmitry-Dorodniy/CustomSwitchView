//
//  CustomSwitchView.swift
//  CustomSwitchView
//
//  Created by Dmitry Dorodniy on 19.08.2023.
//

import UIKit

class CustomSwitchView: UIControl {
    
    public var onTintColor: UIColor = UIColor(red: 144/255, green: 202/255, blue: 119/255, alpha: 1) {
        didSet {
            setupView()
        }
    }
    
    public var offTintColor: UIColor = .lightGray {
        didSet {
            setupView()
        }
    }
    
    public var cornerRadius: CGFloat = 0.5 {
        didSet {
            layoutSubviews()
        }
    }
    
    public var thumbBackgroundColor: UIColor = .white {
        didSet {
            thumbView.backgroundColor = thumbBackgroundColor
        }
    }
    
    public var thumbOffTintColor: UIColor = .lightGray {
        didSet {
            thumbViewSubView.backgroundColor = thumbOffTintColor
        }
    }
    
    public var thumbOnTintColor: UIColor = .systemGray6
    
    public var thumbCornerRadius: CGFloat = 0.5 {
        didSet {
            layoutSubviews()
        }
    }
    
    public var thumbSize: CGSize = .zero {
        didSet {
            layoutSubviews()
        }
    }
    
    public var padding: CGFloat = 1 {
        didSet {
            layoutSubviews()
        }
    }
    
    public var thumbInPadding: CGFloat = 5
    //    {
    //        didSet {
    //            setupLayout()
    //        }
    //    }
    
    public var isOn = false
    public var animationDuration: Double = 0.5
    
    fileprivate var thumbView = UIView(frame: .zero)
    fileprivate var thumbViewSubView = UIView(frame: .zero)
    
    fileprivate var onPoint: CGPoint = .zero
    fileprivate var offPoint: CGPoint = .zero
    fileprivate var isAnimating = false
    
    // MARK: - Setups
    
    private func clear() {
        self.subviews.forEach( { $0.removeFromSuperview() })
    }
    
    func setupView() {
        clear()
        clipsToBounds = false
        thumbViewSubView.backgroundColor = isOn ? thumbOnTintColor : thumbOffTintColor
        thumbView.backgroundColor = thumbBackgroundColor
        thumbViewSubView.translatesAutoresizingMaskIntoConstraints = false
        
        thumbView.isUserInteractionEnabled = false
        
        thumbView.layer.shadowColor = UIColor.gray.cgColor
        thumbView.layer.shadowRadius = 3
        thumbView.layer.shadowOpacity = 0.4
        thumbView.layer.shadowOffset = CGSize(width: 0.75, height: 2)
        
        addSubview(thumbView)
        thumbView.addSubview(thumbViewSubView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            thumbViewSubView.leftAnchor.constraint(equalTo: thumbView.leftAnchor, constant: thumbInPadding),
            thumbViewSubView.rightAnchor.constraint(equalTo: thumbView.rightAnchor, constant: -thumbInPadding),
            thumbViewSubView.topAnchor.constraint(equalTo: thumbView.topAnchor, constant: thumbInPadding),
            thumbViewSubView.bottomAnchor.constraint(equalTo: thumbView.bottomAnchor, constant: -thumbInPadding)
        ])
    }
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if !isAnimating {
            layer.cornerRadius = bounds.size.height * cornerRadius
            backgroundColor = isOn ? onTintColor : offTintColor
            thumbViewSubView.backgroundColor = isOn ? thumbOnTintColor : thumbOffTintColor
            
            //thumb managment
            let thumbSize = thumbSize != .zero ? thumbSize : CGSize(width: bounds.size.height - 2,
                                                                    height: bounds.size.height - 2)
            let yPosition = (bounds.size.height - thumbSize.height) * 0.5
            
            onPoint = CGPoint(x: bounds.size.width - thumbSize.width - padding, y: yPosition)
            offPoint = CGPoint(x: padding, y: yPosition)
            
            thumbView.frame = CGRect(origin: isOn ? onPoint : offPoint, size: thumbSize)
            thumbViewSubView.layer.cornerRadius = thumbViewSubView.frame.height * 0.5
            
            thumbView.layer.cornerRadius = thumbSize.height * thumbCornerRadius
        }
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        
        animate()
        return true
    }
    
    // MARK: - Private func
    private func animate() {
        isOn.toggle()
        
        isAnimating = true
        
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.5,
                       options: [.curveEaseOut,
                                 .beginFromCurrentState],
                       animations: {
            self.thumbView.frame.origin.x = self.isOn ? self.onPoint.x : self.offPoint.x
            self.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor
            self.thumbViewSubView.backgroundColor = self.isOn ? self.thumbOnTintColor : self.thumbOffTintColor
        },
                       completion: { _ in
            self.isAnimating = false
            self.sendActions(for: .valueChanged)
        })
    }
}


