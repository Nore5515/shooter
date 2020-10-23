extends Node2D


# get_node("/root/Global")


var bestZombiesTime = "N/A"
var bestTimeTrial2Time = "N/A"
var bestTargetSpeedrunTime = "N/A"


export (int) var cash = 1000



### PLAYER
var currentHead
var headColor
var currentBody
var bodyColor

var meleeDamage = 80
var meleeKnockback = 6


### PISTOL
var pistolSize = 8
var pistolUpgradeCosts = [10,20,30,40,50,60,70,80,90,100,110,120,130,140,150]

var pistolAuto = false
var pistolAutoCost = [100]

var pistolDamage = 20
var pistolDamageUpgradeCosts = [50,100,200]
var pistolDamageUpgradeAmount = 5

# OLD STUFF
var pistolHeadshotMultiplier = 4
var pistolCrippleMultiplier = 1
var pistolCripplePenalty = 0.5

# Multiply this by the base mag for how much ammo is in a crate
var pistolAmmoMultiplier = 3

### AR
var arSize = 20
var arUpgradeCosts = [20,40,60,80,100,140,160,220,260,300]
var arUpgradeAmount = 3

var arDamage = 35
# OLD STUFF

var arHeadshotMultiplier = 3
var arCrippleMultiplier = 2
var arCripplePenalty = 0.8

var arAmmoMultiplier = 1
