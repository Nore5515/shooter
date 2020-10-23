extends Panel




var arUnlockSelected = false
var arMagSelected = false
var arDamageSelected = false


func hideDetails():
	$ARDetails.text = ""
	resetFlags()
	
func resetFlags():
	arUnlockSelected = false
	arMagSelected = false
	arDamageSelected = false





func _on_ARUnlock_pressed():
	hideDetails()
	arUnlockSelected = true
	if get_node("/root/Global").arUnlocked:
		$ARDetails.text = "You have the AR unlocked!"
	else:
		var text = "Unlock the AR!"
		text += "\nCost: " + String(get_node("/root/Global").arUnlockedPrice)
		$ARDetails.text = text


func _on_ARMag_pressed():
	hideDetails()
	arMagSelected = true
	if get_node("/root/Global").arUpgradeCosts.size() <= 0:
		var text = "You have the AR size maxed!"
		text += "\nCurrent: " + String(get_node("/root/Global").arSize)
		$ARDetails.text = text
	else:
		var text = "Upgrade the AR mag!"
		text += "\nCurrent: " + String(get_node("/root/Global").arSize)
		text += "\nCost: " + String(get_node("/root/Global").arUpgradeCosts[0])
		$ARDetails.text = text


func _on_ARDamage_pressed():
	hideDetails()
	arDamageSelected = true
	if get_node("/root/Global").arDamageUpgradeCosts.size() <= 0:
		var text = "You have the AR damage maxed!"
		text += "\nCurrent: " + String(get_node("/root/Global").arDamage)
		$ARDetails.text = text
	else:
		var text = "Upgrade the AR damage!"
		text += "\nCurrent: " + String(get_node("/root/Global").arDamage)
		text += "\nCost: " + String(get_node("/root/Global").arDamageUpgradeCosts[0])
		$ARDetails.text = text


func _on_ARBuy_pressed():
	
	if arUnlockSelected:
		if get_node("/root/Global").cash >= get_node("/root/Global").arUnlockedPrice:
			get_node("/root/Global").cash -= get_node("/root/Global").arUnlockedPrice
			get_node("/root/Global").arUnlocked = true
		_on_ARUnlock_pressed()
	
	elif arMagSelected:
		if get_node("/root/Global").arUpgradeCosts.size() > 0:
			if get_node("/root/Global").cash >= get_node("/root/Global").arUpgradeCosts[0]:
				get_node("/root/Global").cash -= get_node("/root/Global").arUpgradeCosts[0]
				get_node("/root/Global").arSize += get_node("/root/Global").arUpgradeAmount
				get_node("/root/Global").arUpgradeCosts.pop_front()
		_on_ARMag_pressed()
	
	elif arDamageSelected:
		if get_node("/root/Global").arDamageUpgradeCosts.size() > 0:
			if get_node("/root/Global").cash >= get_node("/root/Global").arDamageUpgradeCosts[0]:
				get_node("/root/Global").cash -= get_node("/root/Global").arDamageUpgradeCosts[0]
				get_node("/root/Global").arDamage += get_node("/root/Global").arDamageUpgradeAmount
				get_node("/root/Global").arDamageUpgradeCosts.pop_front()
		_on_ARDamage_pressed()
	
