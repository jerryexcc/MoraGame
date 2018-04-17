//
//  ViewController.swift
//  MoraGame
//
//  Created by 世明 on 2018/4/16.
//  Copyright © 2018年 世明. All rights reserved.
//

import UIKit
import GameKit
import AVFoundation

class ViewController: UIViewController {
    let fists = ["剪刀", "石頭", "布"]//隨機用的拳
    @IBOutlet weak var labelShowResult: UILabel!//顯示結果用的
    @IBOutlet weak var labelPlayerScore: UILabel!//顯示玩家分數用的
    @IBOutlet weak var labelNPCScore: UILabel!//顯示電腦分數用的
    var playerScore = 0, npcScore = 0//一開始得分都是0分
    var player = ""//玩家出的拳
    var npcPlayer = ""//電腦出的拳
    var playerPic = ""//玩家出拳的動畫用圖片字串
    var npcPic = ""//電腦出拳的動畫用圖片字串
    @IBOutlet weak var playerFistPic: UILabel!//連結StoryBoard的Label的控制項
    @IBOutlet weak var npcFistPic: UILabel!//連結StoryBoard的Label的控制項
    @IBOutlet weak var btnResetGame: UIButton!//連結StoryBoard的重新開始的控制項
    @IBOutlet weak var langSwitch: UISegmentedControl!
    
    @IBAction func btnGameReset(_ sender: Any) {//reset game
        labelPlayerScore.text = "0"
        labelNPCScore.text = "0"
        playerScore = 0
        npcScore = 0
        playerFistPic.text = ""
        npcFistPic.text = ""
        btnResetGame.isHidden = true
        labelShowResult.text = "重新開始比賽"
    }
    @IBAction func btnPlayerScissor(_ sender: Any) {
        btnResetGame.isHidden = false
        player = fists[0]
        npcPlayer = fists[GKRandomDistribution(lowestValue: 0, highestValue: 2).nextInt()]
        gameShowDown(playerFists: player, npcPlayerFists: npcPlayer)
    }
    @IBAction func btnPlayerStone(_ sender: Any) {
        btnResetGame.isHidden = false
        player = fists[1]
        npcPlayer = fists[GKRandomDistribution(lowestValue: 0, highestValue: 2).nextInt()]
        gameShowDown(playerFists: player, npcPlayerFists: npcPlayer)
    }
    @IBAction func btnPlayerPaper(_ sender: Any) {
        btnResetGame.isHidden = false
        player = fists[2]
        npcPlayer = fists[GKRandomDistribution(lowestValue: 0, highestValue: 2).nextInt()]
        gameShowDown(playerFists: player, npcPlayerFists: npcPlayer)
    }
    
    func moveUp(view: UIView){
        view.center.y -= 300
    }
    func moveDown(view: UIView){
        view.center.y += 380
    }
    
    func gameShowDown(playerFists: String, npcPlayerFists:String){
        var gameResult = ""
        if playerFists == "剪刀"{
            playerPic = "✌🏻"
        }else if playerFists == "石頭"{
            playerPic = "✊🏻"
        }else{
            playerPic = "🖐🏻"
        }
        
        if npcPlayerFists == "剪刀"{
            npcPic = "✌🏻"
        }else if npcPlayerFists == "石頭"{
            npcPic = "✊🏻"
        }else{
            npcPic = "🖐🏻"
        }
        
        if playerFists == npcPlayerFists{
            gameResult = "平手"
        }else if playerFists == "剪刀" && npcPlayerFists == "石頭"{
            npcScore += 1
            gameResult = "我輸了"
        }else if playerFists == "剪刀" && npcPlayerFists == "布"{
            playerScore += 1
            gameResult = "我贏了"
        }else if playerFists == "石頭" && npcPlayerFists == "剪刀"{
            playerScore += 1
            gameResult = "我贏了"
        }else if playerFists == "石頭" && npcPlayerFists == "布"{
            npcScore += 1
            gameResult = "我輸了"
        }else if playerFists == "布" && npcPlayerFists == "石頭"{
            playerScore += 1
            gameResult = "我贏了"
        }else if playerFists == "布" && npcPlayerFists == "剪刀"{
            npcScore += 1
            gameResult = "我輸了"
        }
        if self.npcFistPic.center.y != 20 {//reset animat picture
            self.npcFistPic.center.y = 20
            self.playerFistPic.center.y = 790
        }
        UIView.animate(withDuration: 1.0) {//player's animat
            self.playerFistPic.text = self.playerPic
            self.playerFistPic.isHidden = false
            self.moveUp(view: self.playerFistPic)
        }
        UIView.animate(withDuration: 1.0) {//NPC's animat
            self.npcFistPic.text = self.npcPic
            self.npcFistPic.isHidden = false
            self.moveDown(view: self.npcFistPic)
        }
        switch langSwitch.selectedSegmentIndex {
        case 0://中文
            let speechUtterance = AVSpeechUtterance(string: "剪刀, 石頭, 布")
            speechUtterance.voice = AVSpeechSynthesisVoice(language: "zh-TW")
            speechUtterance.rate = 0.59
            let synth = AVSpeechSynthesizer()
            synth.speak(speechUtterance)
            break
        case 1://英文
            let speechUtterance = AVSpeechUtterance(string: "paper, Scissor, Stone")
            speechUtterance.rate = 0.59
            let synth = AVSpeechSynthesizer()
            synth.speak(speechUtterance)
            break
        default:
            let speechUtterance = AVSpeechUtterance(string: "最初はグー, ジャンケンポン")
            speechUtterance.rate = 0.59
            speechUtterance.volume = 9.0
            speechUtterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
            let synth = AVSpeechSynthesizer()
            synth.speak(speechUtterance)
            break
            //日文
        }
        
        labelPlayerScore.text = "\(playerScore)"
        labelNPCScore.text = "\(npcScore)"
        labelShowResult.text = "玩家出:\(playerFists), 電腦出:\(npcPlayerFists) \n 所以是\(gameResult)"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

