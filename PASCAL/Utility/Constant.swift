//
//  Constant.swift
//  TemplateProjSwift
//
//  Created by Mac22 on 13/09/18.
//  Copyright © 2018 Mac22. All rights reserved.
//

import Foundation
import UIKit
import CoreData
struct Constant {
    
    static let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    static let appDisplayName: String = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String ?? ""
    static let appVersionNumber: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    static let appBuildNumber: String = Bundle.main.infoDictionary?[kCFBundleVersionKey as String] as? String ?? ""
    static let navigationTitleAppName: String = Constant.appDisplayName
    static let dataBaseName = "device.db"
    
    struct Device {
        #if targetEnvironment(simulator)
        static let isSimulator = true
        #else
        static let isSimulator = false
        #endif
        static let isIpad = (UIDevice.current.userInterfaceIdiom == .pad) ? true : false
        static let isIphone = (UIDevice.current.userInterfaceIdiom == .phone) ? true : false
    }
    
    
}
func getContext() -> NSManagedObjectContext {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate.persistentContainer.viewContext
}
func DeleteAllData(){
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.persistentContainer.viewContext
    let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "Weight"))
    do {
        try managedContext.execute(DelAllReqVar)
    }
    catch {
        print(error)
    }
}
extension Constant {
    struct UserDefaultsKey {
        static let unitType = "UnitType"
        static let language = "Language"
        static let alarmSound = "AlarmSound"
        static let weightsType = "WeightsType"
        static let KGLimitA = "KGLimitA"
        static let KGLimitB = "KGLimitB"
        static let KNLimitA = "KNLimitA"
        static let KNLimitB = "KNLimitB"
        static let LGLimitA = "LGLimitA"
        static let LGLimitB = "LGLimitB"
        static let LNLimitA = "LNLimitA"
        static let LNLimitB = "LNLimitB"
    }
}
