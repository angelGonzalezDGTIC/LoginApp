//
//  AppDelegate.swift
//  LoginApp
//
//  Created by Ángel González on 18/03/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Detectamos si el dispositivo ha sido liberado
        // OJO: EN EL SIMULADOR SIEMPRE APARECE COMO "jailbreak" PORQUE SE PUEDE ACCEDER A TODAS LAS CARPETAS
        if !Utils.detectJailBroken() {
            // el app acaba de arrancar, entonces aun no hay escena activa, necesitamos hacer un delay
            DispatchQueue.main.asyncAfter(deadline:.now() + 0.5) {
                // PANIC: Cydia is present!! enviar mensaje al usuario
                let ac = UIAlertController(title:"Error", message:"Lo sentimos, pero al parecer este dispositivo no es legal", preferredStyle: .alert)
                let action = UIAlertAction(title: "Enterado", style: .default) {
                    ac in
                    // terminar la app
                    exit(666)
                }
                ac.addAction(action)
                // a partir de iOS 13, es necesario usar SceneDelegate
                if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                    if let ventana = sceneDelegate.window {
                        /* Para cambiar el view controller que se está mostrando
                        ventana.rootViewController = // un nuevo VC
                        ventana.makeKeyAndVisible()
                        */
                        ventana.rootViewController?.present(ac, animated: true)
                    }
                }
            }
            
        }
        
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


}

