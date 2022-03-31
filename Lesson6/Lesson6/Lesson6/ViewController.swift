//
//  ViewController.swift
//  Lesson6
//
//  Created by Denis on 31.03.2022.
//

import UIKit

enum AnimationStyle: CaseIterable {
    case rotate
    case changeAlpha
    case changeSize
    case changeColor
}

class ViewController: UIViewController {
    @IBOutlet private var loginTextFieldCenterXConstraint: NSLayoutConstraint!
    @IBOutlet private var passwordTextFieldCenterXConstraint: NSLayoutConstraint!
    @IBOutlet private var loginButtonCenterXConstraint: NSLayoutConstraint!
    
    @IBOutlet private var loginTextfield: UITextField!
    @IBOutlet private var paswordTextfield: UITextField!
    @IBOutlet private var logInButton: UIButton!
    
    private var stars = [UIImageView]()
    private let starWidthAndLength: CGFloat = 15

    
    private var starAnimationTimer: Timer?
    
    override func viewWillAppear(_ animated: Bool) {
        let rootViewWidth = view.frame.width
        loginTextFieldCenterXConstraint.constant = -rootViewWidth
        passwordTextFieldCenterXConstraint.constant = -rootViewWidth
        loginButtonCenterXConstraint.constant = -rootViewWidth
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addStars()
        setupStarAnimationTimer()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.logInButton.startLoading()
        }
    }
//        .curveLinear: This option applies no acceleration or deceleration to the animation.
//        .curveEaseIn: Applies acceleration to the start of your animation.
//        .curveEaseOut: This option applies deceleration to the end of your animation.
//        .curveEaseInOut: Applies acceleration to the start of your animation and deceleration to the end of your animation.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // анимируем появление вьюх
        let constraints = [loginTextFieldCenterXConstraint,
                           passwordTextFieldCenterXConstraint,
                           loginButtonCenterXConstraint]

        for (index, constraint) in constraints.enumerated() {

            constraint?.constant = 0

            UIView.animate(withDuration: 0.5,
                           delay: Double(index) * 0.2,
                           options: [.curveEaseOut],
                           animations: { [weak self] in
                self?.view.layoutIfNeeded()
            })
        }
        
        // анимируем изменение бекграунда у кнопки
        
        UIView.animate(withDuration: 1.5,
                       delay: 0.7,
                       options: [.repeat, .autoreverse],
                       animations: { [weak self] in
            self?.logInButton.backgroundColor = .random
        })
    }
    
    private func addStars() {
        let frameXRange = (0 + starWidthAndLength)...(view.frame.width - starWidthAndLength)
        let frameYRange = (0 + starWidthAndLength)...(view.frame.height - starWidthAndLength)
        
        for _ in 1...50 {
            let x = CGFloat.random(in: frameXRange)
            let y = CGFloat.random(in: frameYRange)
            let starImageView = UIImageView()
            starImageView.image = .init(systemName: "star.fill")
            starImageView.tintColor = .yellow
            starImageView.frame.size = .init(width: starWidthAndLength, height: starWidthAndLength)
            starImageView.center = .init(x: x, y: y)
            
            view.addSubview(starImageView)
            
            stars.append(starImageView)
        }
        
        [loginTextfield, paswordTextfield, logInButton].forEach { view.bringSubviewToFront($0) }
    }
    
    private func setupStarAnimationTimer() {
        starAnimationTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(animateStars), userInfo: nil, repeats: true)
    }
    
    @objc func animateStars() {
        for star in stars.getRandom(8) {
            animateStar(star: star)
        }
    }
    
    private func animateStar(star: UIImageView) {
        guard let animation = AnimationStyle.allCases.randomElement() else {
            return
        }
        
        let starWidthAndLength = starWidthAndLength
        let animations: (() -> Void)
        
        switch animation {
        case .changeAlpha:
            animations = {
                
                self.starWidthAndLength
                star.frame.size = .init(width: starWidthAndLength, height: starWidthAndLength)
                
                star.alpha = star.alpha == 1 ? 0.3 : 1
            }
        case .changeSize:
            animations = {
                star.alpha = 1
                
                let multiplier: CGFloat = star.frame.width == starWidthAndLength ? 2 : 1
                star.frame.size = CGSize(width: starWidthAndLength * multiplier,
                                         height: starWidthAndLength * multiplier)
            }
        case .rotate:
            animations = {
                star.alpha = 1
                star.frame.size = .init(width: starWidthAndLength, height: starWidthAndLength)
                
                star.transform = star.transform.rotated(by: CGFloat.pi)
                star.transform = star.transform.rotated(by: CGFloat.pi)
            }
        case .changeColor:
            animations = {
                star.alpha = 1
                star.frame.size = .init(width: starWidthAndLength, height: starWidthAndLength)
                
                star.tintColor = .random
            }
        }
        
        UIView.animate(withDuration: 1.0,
                       delay: TimeInterval.random(in: 0...1),
                       options: [],
                       animations: animations)
    }
    
}

extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}

extension Collection {
    func getRandom(_ n: Int) -> ArraySlice<Element> { shuffled().prefix(n) }
}

private extension UIButton {
    func startLoading() {
        let layer = CAReplicatorLayer()
        layer.frame = bounds
        let circle = CALayer()
        let circleDiameter = min(bounds.height / 4, bounds.width / 8)
        circle.frame = CGRect(x: 0, y: 0, width: circleDiameter, height: circleDiameter)
        circle.cornerRadius = circle.frame.width / 2
        circle.backgroundColor = UIColor.random.cgColor
        layer.backgroundColor = UIColor.random.cgColor
        layer.addSublayer(circle)
        let xOffset = circleDiameter * 1.5
        circle.position = CGPoint(x: bounds.midX - xOffset, y: bounds.midY)
        layer.instanceCount = 3
        layer.instanceTransform = CATransform3DMakeTranslation(xOffset, 0, 0)
        layer.instanceDelay = 0.33
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = 1.6
        scaleAnimation.repeatCount = .infinity
        scaleAnimation.values = [1, 0, 1]
        scaleAnimation.keyTimes = [0, 0.5, 1]
        circle.add(scaleAnimation, forKey: nil)
        
        self.layer.addSublayer(layer)
    }
}
