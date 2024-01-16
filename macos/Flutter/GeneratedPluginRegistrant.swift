//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

<<<<<<< HEAD
import audioplayers
=======
import device_info_plus
>>>>>>> refs/remotes/origin/master
import location
import path_provider_foundation
import shared_preferences_foundation
import sqflite

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
<<<<<<< HEAD
  AudioplayersPlugin.register(with: registry.registrar(forPlugin: "AudioplayersPlugin"))
=======
  DeviceInfoPlusMacosPlugin.register(with: registry.registrar(forPlugin: "DeviceInfoPlusMacosPlugin"))
>>>>>>> refs/remotes/origin/master
  LocationPlugin.register(with: registry.registrar(forPlugin: "LocationPlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
  SharedPreferencesPlugin.register(with: registry.registrar(forPlugin: "SharedPreferencesPlugin"))
  SqflitePlugin.register(with: registry.registrar(forPlugin: "SqflitePlugin"))
}
