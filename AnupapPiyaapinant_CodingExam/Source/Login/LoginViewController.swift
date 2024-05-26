//
//  LoginViewController.swift
//  AnupapPiyaapinant_CodingExam
//
//  Created by Anupap on 25/5/2567 BE.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    private var showPasswordButton = UIButton(type: .system)
    
    var viewModel: LoginViewModel = LoginViewModel()
    
    var emailStatus: LoginEmailVerifyResult? {
        didSet {
            self.checkLoginButtonEnable()
        }
    }
    
    var passwordStatus: LoginPasswordVerifyResult? {
        didSet {
            self.checkLoginButtonEnable()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditTextField))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
    }
    
    func setupUI() {
        emailTextField.text = ""
        passwordTextField.text = ""
        
        passwordTextField.isSecureTextEntry = true
        showPasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        showPasswordButton.tintColor = .gray
        showPasswordButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        showPasswordButton.sizeToFit()
        
        passwordTextField.rightView = showPasswordButton
        passwordTextField.rightViewMode = .always
        
        loginButton.isEnabled = false
    }
    
    @objc func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        if passwordTextField.isSecureTextEntry {
            showPasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        } else {
            showPasswordButton.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }
    
    @IBAction func changePasswordVisibility(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        if passwordTextField.isSecureTextEntry {
            if let image = UIImage(systemName: "eye.fill") {
                sender.setImage(image, for: .normal)
            }
        } else {
            if let image = UIImage(systemName: "eye.slash.fill") {
                sender.setImage(image, for: .normal)
            }
        }
    }
    
    private func bindViewModel() {
        viewModel.output.loginSuccess = { [weak self] in
            self?.performSegue(withIdentifier: "loginSuccessSegue", sender: nil)
        }
        
        viewModel.output.loginFailed = { [weak self] errorMessage in
            self?.alertDialog(title: "Error", message: errorMessage)
        }
    }
    
    private func alertDialog(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func checkLoginButtonEnable() {
        loginButton.isEnabled = emailStatus == .success && passwordStatus == .success
    }
    
    @objc func endEditTextField() {
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
    }
    
    @IBAction func beginEditEmailTextField() {
        emailStatus = nil
        emailTextField.textColor = .black
        emailErrorLabel.isHidden = true
    }
    
    @IBAction func endEditEmailTextField() {
        emailStatus = viewModel.verifyEmail(emailTextField.text)
        
        switch emailStatus {
        case .emptyFailure:
            emailTextField.textColor = .red
            emailErrorLabel.text = emailStatus?.description
            emailErrorLabel.isHidden = false
            loginButton.isEnabled = false
        case .invalidFailure:
            emailTextField.textColor = .red
            emailErrorLabel.text = emailStatus?.description
            emailErrorLabel.isHidden = false
            loginButton.isEnabled = false
        default:
            break
        }
    }
    
    @IBAction func beginEditPasswordTextField() {
        passwordStatus = nil
        passwordTextField.textColor = .black
        passwordErrorLabel.isHidden = true
    }
    
    @IBAction func endEditPasswordTextField() {
        passwordStatus = viewModel.verifyPassword(passwordTextField.text)
        
        switch passwordStatus {
        case .emptyFailure:
            passwordTextField.textColor = .red
            passwordErrorLabel.text = passwordStatus?.description
            passwordErrorLabel.isHidden = false
            loginButton.isEnabled = false
        default:
            break
        }
    }
    
    @IBAction func onClickTextFieldDoneButton() {
        endEditTextField()
    }
    
    @IBAction func onClickLoginButton() {
        endEditTextField()
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            viewModel.login(email: email, password: password)
        }
    }
}
