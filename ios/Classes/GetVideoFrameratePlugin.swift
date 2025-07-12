import Flutter
import UIKit
import AVFoundation

public class GetVideoFrameratePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
	let channel = FlutterMethodChannel(name: "get_video_framerate", binaryMessenger: registrar.messenger())
	let instance = GetVideoFrameratePlugin()
	registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
	if call.method == "getFPS" {
	  guard let args = call.arguments as? [String: Any],
			let urlString = args["url"] as? String,
			let url = URL(string: urlString) else {
		result(FlutterError(code: "INVALID_ARGUMENT", message: "Faltan o son inválidos los argumentos", details: nil))
		return
	  }

	  getVideoFPS(url: url) { fps in
		result(fps)
	  }

	} else {
	  result(FlutterMethodNotImplemented)
	}
  }

  private func getVideoFPS(url: URL, completion: @escaping (Double) -> Void) {
	let asset = AVURLAsset(url: url)

	if #available(iOS 15.0, *) {
	  Task {
		do {
		  let isPlayable = try await asset.load(.isPlayable)
		  if !isPlayable {
			completion(-1.0)
			return
		  }

		  let tracks = try await asset.loadTracks(withMediaType: .video)
		  guard let track = tracks.first else {
			completion(-1.0)
			return
		  }

		  let fps = try await track.load(.nominalFrameRate)
		  completion(Double(fps))
		} catch {
		  completion(-1.0)
		}
	  }
	} else {
	  guard asset.isPlayable else {
		completion(-1.0)
		return
	  }

	  let tracks = asset.tracks(withMediaType: .video)
	  guard let track = tracks.first else {
		completion(-1.0)
		return
	  }

	  let fps = track.nominalFrameRate
	  completion(Double(fps))
	}
  }
}
