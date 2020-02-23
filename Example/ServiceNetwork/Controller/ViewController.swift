//
//  ViewController.swift
//  ServiceExample
//
//  Created by Alireza Moradi on 2/21/20.
//  Copyright © 2020 Alireza Moradi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtPhoneNumber: UITextField!
    
    private lazy var viewModel:SignUpVM = {
        SignUpVM(phoneNumber: txtPhoneNumber.text ?? "")
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bool = { [weak self] (bool) in
            guard let self = self else { return }
            bool ? self.showMessage("success") : self.showMessage("not success")
        }
    }
    func showMessage(_ mesaage:String) {
        print(mesaage)
    }
    @IBAction func sendPhoneNumber(_ sender:UIBarButtonItem) {
        viewModel.phoneNumber = txtPhoneNumber.text ?? ""
        viewModel.request()
    }

}

