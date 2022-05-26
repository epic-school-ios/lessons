//
//  UIHostingControllerExample.swift
//  SwiftUI_Lesson2
//
//  Created by Denis on 26.05.2022.
//

import UIKit
import SwiftUI
import Combine

class ViewController: UIViewController {
    
    private let contactPickerDelegate: ContactPickerDelegate = Delegate()
    private var contactPickerSubscription: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSwiftUIChildView()
        subscribeToPickerDelegate()
    }
    
    private func addSwiftUIChildView() {
        let childView = UIHostingController(rootView: ContactPickerView(delegate: contactPickerDelegate))
        addChild(childView)
        childView.view.frame = view.frame
        view.addSubview(childView.view)
        childView.didMove(toParent: self)
    }
    
    private func subscribeToPickerDelegate() {
        contactPickerSubscription = contactPickerDelegate.didChange.sink { print($0 ?? "") }
    }
}

protocol ContactPickerDelegate {
    var willChange: AnyPublisher<String?, Never> { get }
    var didChange: AnyPublisher<String?, Never> { get }
    
    func setContact(contact: String?)
}

class Delegate: ContactPickerDelegate {
    
    var willChange: AnyPublisher<String?, Never> {
        willChangePublisher.eraseToAnyPublisher()
    }
    
    var didChange: AnyPublisher<String?, Never> {
        didChangePublisher.eraseToAnyPublisher()
    }
    
    private let willChangePublisher = PassthroughSubject<String?, Never>()
    private let didChangePublisher = PassthroughSubject<String?, Never>()
    
    private var contact: String? {
        willSet {
            willChangePublisher.send(contact)
        }
        
        didSet {
            didChangePublisher.send(contact)
        }
    }
    
    func setContact(contact: String?) {
        self.contact = contact
    }
}

struct ContactPickerView : View {
    var delegate: ContactPickerDelegate
    
    var body: some View {
        List {
            Button("Alice") {
                delegate.setContact(contact: "Alice")
            }
            Button("Bob") {
                delegate.setContact(contact: "Bob")
            }
            Button("Trudy") {
                delegate.setContact(contact: "Trudy")
            }
        }
    }
}

