//
//  RegisterViewController.swift
//  Patisseria
//
//  Created by Alesson Abao on 5/05/23.
//

import UIKit
import UIKit
import SQLite3

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: DB variables
    let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
    
    // MARK: Outlets
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var visuallyTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var personalView: UIView!
    @IBOutlet weak var accountView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // keyboard disable
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        visuallyTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        // Do any additional setup after loading the view.
        personalView.viewRoundCorners([.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 20)
        accountView.viewRoundCorners([.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 20)
        
        firstNameTextField.viewRoundCorners([.topLeft, .topRight], radius: 20)
        visuallyTextField.viewRoundCorners([.bottomLeft, .bottomRight], radius: 20)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let customColor = hexStringToUIColor(hex: "#60390f")
        
        super.viewWillAppear(animated)
        self.firstNameTextField.addBottomBorderWithColor1(color: customColor, textWidth: 1.0)
        self.lastNameTextField.addBottomBorderWithColor1(color: customColor, textWidth: 1.0)
        self.visuallyTextField.addBottomBorderWithColor1(color: customColor, textWidth: 1.0)
        self.emailTextField.addBottomBorderWithColor1(color: customColor, textWidth: 1.0)
        self.passwordTextField.addBottomBorderWithColor1(color: customColor, textWidth: 1.0)
        self.confirmPasswordTextField.addBottomBorderWithColor1(color: customColor, textWidth: 1.0)
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        // before you insert user data, form must be validated
        if validateForm(){            
            // insert data
            let insertStatementString = "INSERT INTO User (firstName, lastName, visuallyImpaired, useremail, userpass) VALUES (?, ?, ?, ?, ?)"
            
            var insertStatementQuery : OpaquePointer?
            
            // compile sql query and check if status is okay
            if(sqlite3_prepare_v2(dbQueue, insertStatementString, -1, &insertStatementQuery, nil)) == SQLITE_OK {
                // bind the values of textfield inputs to sql query
                sqlite3_bind_text(insertStatementQuery, 1, firstNameTextField.text ?? "", -1, SQLITE_TRANSIENT)
                sqlite3_bind_text(insertStatementQuery, 2, lastNameTextField.text ?? "", -1, SQLITE_TRANSIENT)
                sqlite3_bind_text(insertStatementQuery, 3, visuallyTextField.text ?? "", -1, SQLITE_TRANSIENT)
                sqlite3_bind_text(insertStatementQuery, 4, emailTextField.text ?? "" , -1, SQLITE_TRANSIENT)
                sqlite3_bind_text(insertStatementQuery, 5, passwordTextField.text ?? "" , -1, SQLITE_TRANSIENT)
                
                showMessage(message: "Registered account 🥳", buttonCaption: "Go back to login", controller: self)
                
                if(sqlite3_step(insertStatementQuery)) == SQLITE_DONE{
                    firstNameTextField.text = ""
                    lastNameTextField.text = ""
                    visuallyTextField.text = ""
                    emailTextField.text = ""
                    passwordTextField.text = ""
                    confirmPasswordTextField.text = ""
                    
                    firstNameTextField.becomeFirstResponder()
                    print("Successfully added user in db.")
                    
                    print("================")
                    print("================")
                    print("================")
                    print("================")
                    print("================")
                    let showCol = "PRAGMA table_info(Users);"
                    print("this is users info")
                    print(showCol)
                }
                else{
                    print("Insert data failed.")
                }
                
                sqlite3_finalize(insertStatementQuery)
            }
            
            // clear out the form for another registration
            resetForm()
        }
        else{
            showMessage(message: "Form must be filled", buttonCaption: "Close", controller: self)
        }
    }
    
    // MARK: Frontend functions
    func resetForm(){
        firstNameTextField.text = ""
        lastNameTextField.text = ""
        visuallyTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
        confirmPasswordTextField.text = ""
    }
    
    // dismiss keyboard when user clicks outside textbox
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // dismiss keyboard when user clicks return in keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: HEX COLOR
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    

    // MARK: FORM VALIDATIONS
    func validateForm() -> Bool{
        // if text fields are empty
        guard let firstName = firstNameTextField.text, !firstName.isEmpty else {
            return false
        }
        guard let lastName = lastNameTextField.text, !lastName.isEmpty else {
            return false
        }
        guard let visuallyImpaired = visuallyTextField.text, !visuallyImpaired.isEmpty else {
            return false
        }
        guard let email = emailTextField.text, !email.isEmpty else {
                return false
            }
        guard let password = passwordTextField.text, !password.isEmpty else{
            return false
        }
        guard let confirmPass = confirmPasswordTextField.text, !confirmPass.isEmpty else{
            return false
        }
        
        let fnameRegEx = "^[a-zA-Z]+$"
        let characterPredicate = NSPredicate(format: "SELF MATCHES %@", fnameRegEx)
        
        let emailRegEx = #"^\S+@\S+\.\S+$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        let passRegEx = #"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"#
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passRegEx)
        
        if !characterPredicate.evaluate(with: firstName){
            showMessage(message: "First name shouldn't contain a number.", buttonCaption: "Close", controller: self)
            return false
        }
        else if !characterPredicate.evaluate(with: lastName){
            showMessage(message: "Last name shouldn't contain a number only.", buttonCaption: "Close", controller: self)
            return false
        }
        else if !characterPredicate.evaluate(with: visuallyImpaired){
            showMessage(message: "Input invalid. Yes or no only.", buttonCaption: "Try again.", controller: self)
            return false
        }
        else if visuallyImpaired.lowercased() != "yes" && visuallyImpaired.lowercased() != "no" {
            showMessage(message: "Are you visually impaired?", buttonCaption: "Answer yes or no in text box", controller: self)
            return false
        }
        else if !predicate.evaluate(with: email){
            showMessage(message: "Please put correct email address. Ex. sample@email.com", buttonCaption: "Close", controller: self)
            return false
        }
        else if !passwordPredicate.evaluate(with: password){
            showMessage(message: "Password must contain at least 8 characters, at least 1 letter and a number. ", buttonCaption: "Close", controller: self)
            return false
        }
        else if password != confirmPass{
            showMessage(message: "Password and confirm password doesn't match.", buttonCaption: "Check passwords", controller: self)
            return false
        }
        return true // form is valid
    }
}

extension UIView{
    
    func addBottomBorderWithColor1(color: UIColor, textWidth: CGFloat){
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - textWidth, width: self.frame.size.width, height: textWidth)
        self.layer.addSublayer(border)
    }
    
    
    func viewRoundCorners(_ corners: UIRectCorner, radius: CGFloat){
        if #available(iOS 11, *){
            var cornerMask = CACornerMask()
            if(corners.contains(.topLeft)){
                cornerMask.insert(.layerMinXMinYCorner)
            }
            if(corners.contains(.topRight)){
                cornerMask.insert(.layerMaxXMinYCorner)
            }
            if(corners.contains(.bottomLeft)){
                cornerMask.insert(.layerMinXMaxYCorner)
            }
            if(corners.contains(.bottomRight)){
                cornerMask.insert(.layerMaxXMaxYCorner)
            }
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = cornerMask
        }
        else{
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
}
