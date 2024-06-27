//
//  PushNotificationService.swift
//  ChattingApp
//
//  Created by 김민 on 6/27/24.
//

import Foundation
import FirebaseMessaging
import Combine

protocol PushNotificationServiceType {
    var fcmToken: AnyPublisher<String?, Never> { get }
    func requestAuthorization(completion: @escaping (Bool) -> Void)
}

class PushNotificationService: NSObject, PushNotificationServiceType {
    // 사용자 푸시 권한
    // fcm 토큰 가져오기

    var fcmToken: AnyPublisher<String?, Never> {
        _fcmToken.eraseToAnyPublisher()
    }

    private let _fcmToken = CurrentValueSubject<String?, Never>(nil)

    override init() {
        super.init()

        Messaging.messaging().delegate = self
    }

    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        let authOption: UNAuthorizationOptions = [.alert, .badge, .sound]

        UNUserNotificationCenter.current().requestAuthorization(options: authOption) { granted, error in
            if error != nil {
                completion(false)
            } else {
                completion(granted)
            }
        }
    }
}

extension PushNotificationService: MessagingDelegate {

    // MARK: 정상적으로 등록이 되면 fcm token을 return
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print(fcmToken ?? "")

        guard let fcmToken = fcmToken else { return }
        _fcmToken.send(fcmToken)
    }
}

class StubPushNotificationService: PushNotificationServiceType {
    
    var fcmToken: AnyPublisher<String?, Never> {
        Empty().eraseToAnyPublisher()
    }

    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        completion(true)
    }
}
