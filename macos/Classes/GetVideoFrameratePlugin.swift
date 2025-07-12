
//import Cocoa
import FlutterMacOS
//import AVKit
import AVFoundation
//import UniformTypeIdentifiers

public class GetVideoFrameratePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
	let channel = FlutterMethodChannel(name: "get_video_framerate", binaryMessenger: registrar.messenger)
	let instance = GetVideoFrameratePlugin()
	registrar.addMethodCallDelegate(instance, channel: channel)
  }

	public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
		if call.method == "getFPS" {
			Task {
				if let args = call.arguments as? [String: Any],
				   let urlString = args["url"] as? String,
				   let url = URL(string: urlString) {
					
					let resultado = await getVideoFPS(with: url)
					print(resultado)
					//let reply = "macOS recibió: \(resultado)"
					result(resultado)  // Devuelve el resultado al lado Dart
					
				} else {
					result(FlutterError(code: "INVALID_ARGUMENT", message: "Faltan o son inválidos los argumentos", details: nil))
				}
			}
		} else {
			result(FlutterMethodNotImplemented)
		}
	}
	
}

func getVideoFPS(with url: URL) async -> Double {
	print(url)
	
	let asset = AVURLAsset(url: url)
	
	if #available(macOS 12, *) {
		do {
			let isPlayable = try await asset.load(.isPlayable)
			if !isPlayable {
				print("Formato no compatible.")
				return -1.0
			}
			
			let tracks = try await asset.loadTracks(withMediaType: .video)
			if tracks.isEmpty {
				print("No hay pistas de video.")
				return -1.0
			}
			
			if let fps = try await tracks.first?.load(.nominalFrameRate) {
				print("FPS:", fps)
				return Double(fps)
			}
			
			// Aquí configuras tu AVPlayer si quieres
			// let player = AVPlayer(playerItem: AVPlayerItem(asset: asset))
			
			return -1.0
		} catch {
			print("Error al verificar el archivo:", error)
			return -1.0
		}
	} else {
		// macOS < 12 - versión síncrona
		var fps = -1.0
		if !asset.isPlayable {
			print("Formato no compatible.")
			return -1.0
		}
		
		let tracks = asset.tracks(withMediaType: .video)
		if tracks.isEmpty {
			print("No hay pistas de video.")
			return -1.0
		}
		
		let firstTrack = tracks.first!
		fps = Double(firstTrack.nominalFrameRate)
		print("FPS:", fps)
		return fps
		
		// Aquí configuras tu AVPlayer si quieres
		// let player = AVPlayer(playerItem: AVPlayerItem(asset: asset))
		
	}
}


