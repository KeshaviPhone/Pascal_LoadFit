//
//  SideMenuRouter.swift
//  PASCAL
//
//  Created by My Mac on 15/12/21.
//

import Foundation
protocol SideMenuRouter: UIViewControllerPresentation {
    
}

extension SideMenuVC: SideMenuRouter {
    
    func pushHistoryVC() {
        let nextVC = HistoryModule().viewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }

    func pushSettingVC() {
        let nextVC = SettingModule().viewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func pushDeviceListVC() {
        let nextVC = DeviceListModule().viewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }

    func pushHelpVC() {
        let nextVC = HelpModule().viewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func pushDeviceVC() {
        let nextVC = DeviceModule().viewController()
         navigationController?.pushViewController(nextVC, animated: true)
    }
    
//    func pushFollowingtVC() {
//        let pushFollowingtVC = FollowandFollowesModule().viewController()
//        navigationController?.pushViewController(pushFollowingtVC, animated: true)
//    }
//    func pushAccountVC() {
//        let pushAccountVC = EditProfileModule().viewController()
//        navigationController?.pushViewController(pushAccountVC, animated: true)
//    }
//    func pushBusinessProfileVC() {
//        let pushBusinessProfileVC = BusinessProfileModule().viewController()
//        navigationController?.pushViewController(pushBusinessProfileVC, animated: true)
//    }
//    func pushNewsVC() {
//        let pushNewsVC = NewsModule().viewController()
//        navigationController?.pushViewController(pushNewsVC, animated: true)
//    }
//
//    func pushBlogVC() {
//        let pushBlogVC = BlogModule().viewController()
//        navigationController?.pushViewController(pushBlogVC, animated: true)
//    }
//    func pushContactusVC() {
//        let pushContactusVC = ContactUsModule().viewController()
//        navigationController?.pushViewController(pushContactusVC, animated: true)
//    }
//    func pushNotificationVC() {
//        let pushNotificationVC = NotificationModule().viewController()
//        navigationController?.pushViewController(pushNotificationVC, animated: true)
//    }
//
//    func pushAboutUsVC() {
//        let pushAboutUsVC = AboutUsModule().viewController()
//        navigationController?.pushViewController(pushAboutUsVC, animated: true)
//    }
//
//    func Login() {
//        let loginvc = LoginModule().viewController()
//        navigationController?.pushViewController(loginvc, animated: true)
//    }
//
//    func TearmsandConditionsVC() {
//        let TearmsandConditionsVC = TearmsandConditionsModule().viewController()
//        navigationController?.pushViewController(TearmsandConditionsVC, animated: true)
//    }
}
