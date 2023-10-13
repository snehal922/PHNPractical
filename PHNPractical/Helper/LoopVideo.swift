//
//  LoopVideo.swift
//  PHNPractical
//
//  Created by Snehal on 13/10/23.
//

import Foundation
import UIKit
import AVFoundation

class VideoPlay: UIView {

     private var player : AVPlayer!

      private var playerLayer : AVPlayerLayer!

    init() {

             super.init(frame: CGRectZero)
              self.initializePlayerLayer()

          }

          override init(frame: CGRect) {
              super.init(frame: frame)
              self.initializePlayerLayer()
              self.autoresizesSubviews = false
          }

          required init?(coder aDecoder: NSCoder) {
              super.init(coder: aDecoder)
              self.initializePlayerLayer()

          }


          private func initializePlayerLayer() {

              playerLayer = AVPlayerLayer()
              playerLayer.backgroundColor = UIColor.white.cgColor
              playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill

              self.layer.addSublayer(playerLayer)
              playerLayer.frame = self.bounds
          }

          func playVideoWithURL(url: NSURL) {

              player = AVPlayer(url: url as URL)
              player.isMuted = false

              playerLayer.player = player

              player.play()

              loopVideo(videoPlayer: player)
          }

          func toggleMute() {
              player.isMuted = !player.isMuted
          }

          func isMuted() -> Bool
          {
              return player.isMuted
          }

          func loopVideo(videoPlayer: AVPlayer) {

              NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { notification in

                  videoPlayer.seek(to: CMTime.zero)
                  videoPlayer.play()
              }
          }

      }
