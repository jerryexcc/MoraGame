//
//  ViewController.swift
//  MoraGame
//
//  Created by 世明 on 2018/4/16.
//  Copyright © 2018年 世明. All rights reserved.
//

import UIKit
import GameKit

class ViewController: UIViewController {
    let fists = ["剪刀", "石頭", "布"]
    @IBOutlet weak var labelShowResult: UILabel!
    @IBOutlet weak var labelPlayerScore: UILabel!
    @IBOutlet weak var labelNPCScore: UILabel!
    var playerScore = 0, npcScore = 0
    var player = ""
    var npcPlayer = ""
    var playerPic = ""
    var npcPic = ""
    @IBOutlet weak var playerFistPic: UILabel!
    @IBOutlet weak var npcFistPic: UILabel!
    @IBOutlet weak var btnResetGame: UIButton!
    
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

