extends Node2D


# get_node("/root/Global")



### CAMPAIGN STUFF
var firstChoice = true
var secondChoice = false
var boss = false
var escape = false


var bestZombiesTime = "N/A"
var bestTimeTrial2Time = "N/A"
var bestTargetSpeedrunTime = "N/A"


export (int) var cash = 0



# CHEATS
var infAmmo = false


### PLAYER
var currentHead
var headColor
var currentBody
var bodyColor

var meleeUnlocked = false
var meleeUnlockedPrice = 20
var meleeDamage = 80
var meleeDamageUpgradeCosts = [25,50,75,100]
var meleeDamageUpgradeAmount = 15
var meleeKnockback = 6
var meleeKnockbackUpgradeCosts = [50,100,150]
var meleeKnockbackUpgradeAmount = 2


### PISTOL
var pistolSize = 8
var pistolUpgradeCosts = [10,20,30,40,50,60,70,80,90,100,110,120,130,140,150]

var pistolAuto = false
var pistolAutoCost = [100]

var pistolDamage = 20
var pistolDamageUpgradeCosts = [50,100,200]
var pistolDamageUpgradeAmount = 5

var pistolAmmoMultiplier = 3


### AR

var arUnlocked = false
var arUnlockedPrice = 100

var arDamage = 35
var arDamageUpgradeCosts = [25,50,75,100]
var arDamageUpgradeAmount = 15

var arSize = 20
var arUpgradeCosts = [20,40,60,80,100,140,160,220,260,300]
var arUpgradeAmount = 5

var arAmmoMultiplier = 1


func resetCampaign():
	firstChoice = true
	secondChoice = false
	boss = false
	escape = false
