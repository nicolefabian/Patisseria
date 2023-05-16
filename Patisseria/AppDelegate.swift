//
//  AppDelegate.swift
//  Patisseria
//
//  Created by Alesson Abao on 4/05/23.
//

import UIKit
import SQLite3

var dbQueue: OpaquePointer!

// db will be within the iOS device
var dbURL = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        //UINavigationBar.appearance().shadowImage = UIImage()
        //changing the color of back button text 
        UINavigationBar.appearance().tintColor = .brown
       
        
        // create and open db + set the pointer
        dbQueue = createAndOpenDb()
        
        // check if tables are created
        if(createUsersTables() == false && dropCreateUsersTables() == false){
            print("Creating users table failed.")
        }
        else if(newUserTable() == false){
            print("Creating new user table failed.")
        }
        else if(createProductsTable() == false && dropProductsTable() == false){
            print("Creating products table failed.")
        }
        else if(newProductTable() == false){
            print("Creating new product table failed.")
        }
        else if(createWishTable() == false){
            print("Creating wishlist table failed.")
        }
        else if(createCartTable() == false){
            print("Creating cart table failed.")
        }
        else if(createOrderTable() == false){
            print("Creating order table failed.")
        }
        else{
            print("Table created.")
        }
        
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // MARK: SQLite AREA
    // create a db
    func createAndOpenDb() -> OpaquePointer?{ // swift type for c pointers
        var db : OpaquePointer?
        
        let url = NSURL(fileURLWithPath: dbURL) // set up the url to db
        
        // name of db
        if let pathComponent = url.appendingPathComponent("Bakery.sqlite"){
            
            let filePath = pathComponent.path
            // open sqlite db
            if sqlite3_open(filePath, &db) == SQLITE_OK{
                print("Opened the DB. File Path of db: \(filePath)")
                return db
            }
            else{
                print("Couldn't open db ;(")
            }
        }
        else{
            print("File path unavailable.")
        }
        
        return db
    }
    // MARK: Users table
    func newUserTable() -> Bool{
        var bRetVal : Bool = false
        
        let newUsersTable = sqlite3_exec(dbQueue, "CREATE TABLE IF NOT EXISTS User (userID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, firstName TEXT NOT NULL, lastName TEXT NOT NULL, visuallyImpaired TEXT NOT NULL, useremail TEXT NOT NULL, userpass TEXT NOT NULL)", nil, nil, nil)
        
        if(newUsersTable != SQLITE_OK){
            print("Cannot create new user table :(")
            bRetVal = false
        }
        else{
            bRetVal = true
        }
        
        return bRetVal
    }
    
    func dropCreateUsersTables() -> Bool{
        var bRetVal : Bool = false
        
        let newUsersTable = sqlite3_exec(dbQueue, "DROP TABLE Users", nil, nil, nil)
        
        if(newUsersTable != SQLITE_OK){
            print("Cannot drop old users table :(")
            bRetVal = false
        }
        else{
            bRetVal = true
        }
        
        return bRetVal
    }
    
    func createUsersTables() -> Bool{
        var bRetVal : Bool = false
        
        let createUsersTable = sqlite3_exec(dbQueue, "CREATE TABLE IF NOT EXISTS Users (usersID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, firstName TEXT NOT NULL, lastName TEXT NOT NULL, visuallyImpaired TEXT NOT NULL, useremail TEXT NOT NULL, userpass TEXT NOT NULL)", nil, nil, nil)
        
        if(createUsersTable != SQLITE_OK){
            print("Cannot create users table :(")
            bRetVal = false
        }
        else{
            bRetVal = true
        }
        
        return bRetVal
    }
    // MARK: Products table
    func newProductTable() -> Bool{
        var bRetVal : Bool = false
        
        let newProductTable = sqlite3_exec(dbQueue, "CREATE TABLE IF NOT EXISTS Product (productID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, productName TEXT NOT NULL, productDescription TEXT NOT NULL, productStock INTEGER NOT NULL, productPrice INTEGER NOT NULL, productImage TEXT NOT NULL)", nil, nil, nil)
        
        if(newProductTable != SQLITE_OK){
            print("Cannot create new product table :(")
            bRetVal = false
        }
        else{
            bRetVal = true
        }
        
        return bRetVal
    }
    
    func dropProductsTable() -> Bool{
        var bRetVal : Bool = false
        
        let newProductsTable = sqlite3_exec(dbQueue, "DROP TABLE Products", nil, nil, nil)
        
        if(newProductsTable != SQLITE_OK){
            print("Cannot drop old users table :(")
            bRetVal = false
        }
        else{
            bRetVal = true
        }
        
        return bRetVal
    }
    
    func createProductsTable() -> Bool{
        var bRetVal : Bool = false
        
        let createProductsTable = sqlite3_exec(dbQueue, "CREATE TABLE IF NOT EXISTS Products (productID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, productName TEXT NOT NULL, productStock INTEGER NOT NULL, productPrice INTEGER NOT NULL, productImage TEXT NOT NULL)", nil, nil, nil)
        
        if(createProductsTable != SQLITE_OK){
            print("Cannot create products table :(")
            bRetVal = false
        }
        else{
            bRetVal = true
        }
        
        return bRetVal
    }
    
    // MARK: Cart table
    func createCartTable() -> Bool{
        var bRetVal : Bool = false
        
        let createCartTable = sqlite3_exec(dbQueue, "CREATE TABLE IF NOT EXISTS Cart (cartID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, usersID INTEGER NOT NULL, productID INTEGER NOT NULL, cartQuantity INTEGER NOT NULL, cartTotal INTEGER NOT NULL)", nil, nil, nil)
        
        if(createCartTable != SQLITE_OK){
            print("Cannot create cart table :(")
            bRetVal = false
        }
        else{
            bRetVal = true
        }
        return bRetVal
    }
    
    // MARK: Wishlist table
    func createWishTable() -> Bool{
        var bRetVal : Bool = false
        
        let createWishTable = sqlite3_exec(dbQueue, "CREATE TABLE IF NOT EXISTS Wish (wishID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, usersID INTEGER NOT NULL, productID INTEGER NOT NULL)", nil, nil, nil)
        
        if(createWishTable != SQLITE_OK){
            print("Cannot create wish table :(")
            bRetVal = false
        }
        else{
            bRetVal = true
        }
        return bRetVal
    }
    
    
    // MARK: Orders table
    func createOrderTable() -> Bool{
        var bRetVal : Bool = false
        
        let createOrderTable = sqlite3_exec(dbQueue, "CREATE TABLE IF NOT EXISTS OrderRecord (orderID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, cartID INTEGER NOT NULL, checkoutDate TEXT NOT NULL)", nil, nil, nil)
        
        if(createOrderTable != SQLITE_OK){
            print("Cannot create order table :(")
            bRetVal = false
        }
        else{
            bRetVal = true
        }
        return bRetVal
    }
    
//
//    // MARK: - Core Data stack
//
//    lazy var persistentContainer: NSPersistentContainer = {
//        /*
//         The persistent container for the application. This implementation
//         creates and returns a container, having loaded the store for the
//         application to it. This property is optional since there are legitimate
//         error conditions that could cause the creation of the store to fail.
//        */
//        let container = NSPersistentContainer(name: "Patisseria")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//
//                /*
//                 Typical reasons for an error here include:
//                 * The parent directory does not exist, cannot be created, or disallows writing.
//                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
//                 * The device is out of space.
//                 * The store could not be migrated to the current model version.
//                 Check the error message to determine what the actual problem was.
//                 */
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
//
//    // MARK: - Core Data Saving support
//
//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }

}

