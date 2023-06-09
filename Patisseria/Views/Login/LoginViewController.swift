//
//  LoginViewController.swift
//  Patisseria
//
//  Created by Alesson Abao on 4/05/23.
//

import UIKit
import SQLite3

// alert function
func showMessage(message : String, buttonCaption : String, controller : UIViewController)
{
    let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: buttonCaption, style: .default)
    alert.addAction(action)
    controller.present(alert, animated: true)
}

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: DB variables
    let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
    
    // MARK: Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let customColor = hexStringToUIColor(hex: "#60390f")
        
        super.viewWillAppear(animated)
        self.emailTextField.addBottomBorderWithColor1(color: customColor, textWidth: 1.0)
        self.passwordTextField.addBottomBorderWithColor1(color: customColor, textWidth: 1.0)
    }
    
    
    @IBAction func loginButton(_ sender: UIButton) {
        let loginEmail = emailTextField.text!
        let loginPass = passwordTextField.text!
        
        var loginSuccessful = false
        
        if validateForm(){
            let selectStatementString = "SELECT userID, useremail, userpass, visuallyImpaired FROM User"
            var selectStatementQuery: OpaquePointer?
            
            // select query
            // get data
            var showData: String!
            showData = ""
            
            if sqlite3_prepare_v2(dbQueue, selectStatementString, -1, &selectStatementQuery, nil) == SQLITE_OK {
                // this will loop through all the rows in Users table until email and pass match in the users table
                while sqlite3_step(selectStatementQuery) == SQLITE_ROW{
                    
                    showData += "ID: " + String(cString: sqlite3_column_text(selectStatementQuery, 0)) + "\t\t" + "email: " + String(cString: sqlite3_column_text(selectStatementQuery, 1)) + "\t\t" +
                        "password: " + String(cString: sqlite3_column_text(selectStatementQuery, 2)) + "\t\t" +
                        "visually impaired: " + String(cString: sqlite3_column_text(selectStatementQuery, 3)) + "\n"
                    print(showData ?? "This is showData")
                    
                    if(loginEmail == String(cString: sqlite3_column_text(selectStatementQuery, 1)) && loginPass == String(cString: sqlite3_column_text(selectStatementQuery, 2))){
                        loginSuccessful = true
                        
                        if String(cString: sqlite3_column_text(selectStatementQuery, 1)) == "admin@test.com" && String(cString: sqlite3_column_text(selectStatementQuery, 2)) == "admin1234" {
                            // User is an admin, navigate to admin view controller
                            
                            
                            // User is an admin, navigate to admin view controller
                            let adminViewController = storyboard?.instantiateViewController(withIdentifier: "productViewController") as! ProductViewController
                            navigationController?.pushViewController(adminViewController, animated: true)
                            
                            // Hide the back button in the regular view controller
                                    navigationController?.setNavigationBarHidden(true, animated: false)
                            
                            
                            
                            
                            
                            // let adminTableViewController = storyboard?.instantiateViewController(withIdentifier: "AdminNC") as! AdminTableViewController; navigationController
                            
                            // let adminTableViewController = storyboard?.instantiateViewController(withIdentifier: "AdminNC") as! AdminTableViewController
                            
                            // navigationController?.pushViewController(adminTableViewController, animated: true)
                            
                            // Hide the back button in the regular view controller
                            // navigationController?.setNavigationBarHidden(true, animated: false)
                        }
                        else if String(cString: sqlite3_column_text(selectStatementQuery, 3)) == "Yes"{
                            // User is an admin, navigate to admin view controller
                            let visuallyImpairedViewController = storyboard?.instantiateViewController(withIdentifier: "VisualImpairedViewController") as! VisualImpairedViewController
                            navigationController?.pushViewController(visuallyImpairedViewController, animated: true)
                            
                            // Hide the back button in the regular view controller
                                    navigationController?.setNavigationBarHidden(true, animated: false)
                        }
                        else{
                            // User is not an admin, navigate to regular view controller
                            let regularViewController = storyboard?.instantiateViewController(withIdentifier: "RegularViewController") as! RegularViewController
                            navigationController?.pushViewController(regularViewController, animated: true)
                            // Hide the back button in the regular view controller
                                    navigationController?.setNavigationBarHidden(true, animated: false)
                        }
                        
                        break
                    }
                }
                
                if(loginSuccessful){
//                    showMessage(message: "Login success", buttonCaption: "Close", controller: self)
                }
                else{
                    showMessage(message: "Login failed 🙁", buttonCaption: "Try again", controller: self)
                }
                sqlite3_finalize(selectStatementQuery)
            }
            else{
                print("============================")
                print("============================")
                print("============================")
                print("============================")
                print("[LoginViewController=>loginButton]something failed. !SQLITE_OK")
            }
        }
        else{
            showMessage(message: "Email and password should not be empty.", buttonCaption: "Try again", controller: self)
        }
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
    
    // MARK: Form validation
    func validateForm() -> Bool{
        guard let email = emailTextField.text, !email.isEmpty else {
                return false
            }
        guard let password = passwordTextField.text, !password.isEmpty else{
            return false
        }
        return true // form is valid
    }
    
    // MARK: Frontend functions
    // dismiss keyboard when user clicks outside textbox
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // dismiss keyboard when user clicks return in keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
}
