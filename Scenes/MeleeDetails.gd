extends Panel


var meleeUnlockSelected = false
var meleeDamageSelected = false
var meleeKnockbackSelected = false




func hideDetails():
	$meleeDetails.text = ""
	resetFlags()
	
func resetFlags():
	meleeUnlockSelected = false
	meleeDamageSelected = false
	meleeKnockbackSelected = false


func _on_meleeUnlock_pressed():
	hideDetails()
	meleeUnlockSelected = true
	if get_node("/root/Global").meleeUnlocked:
		$meleeDetails.text = "Melee is already unlocked!"
	else:
		$meleeDetails.text = "Unlock melee!\nPrice: " + String(get_node("/root/Global").meleeUnlockedPrice)


func _on_meleeDamage_pressed():
	hideDetails()
	meleeDamageSelected = true
	if get_node("/root/Global").meleeDamageUpgradeCosts.size() > 0:
		var text = "Increase the force of your melee attacks."
		text += "\nCurrent Damage: " + String(get_node("/root/Global").meleeDamage)
		text += "\nPrice: " + String(get_node("/root/Global").meleeDamageUpgradeCosts[0])
		$meleeDetails.text = text
	else:
		var text = "Damage maxed!"
		text += "\nCurrent Damage: " + String(get_node("/root/Global").meleeDamage)
		$meleeDetails.text = text

func _on_meleeKnockback_pressed():
	hideDetails()
	meleeKnockbackSelected = true
	if get_node("/root/Global").meleeKnockbackUpgradeCosts.size() > 0:
		var text = "Knockback is a vital part of melee combat.\nCurrent: "
		text += String(get_node("/root/Global").meleeKnockback)
		text += "\nPrice: " + String(get_node("/root/Global").meleeKnockbackUpgradeCosts[0])
		$meleeDetails.text = text
	else:
		var text = "Knockback maxed!"
		text += "\nCurrent: " + String(get_node("/root/Global").meleeKnockback)
		$meleeDetails.text = text



func _on_meleeBuy_pressed():
	
	if meleeUnlockSelected:
		if get_node("/root/Global").meleeUnlocked:
			pass
		else:
			if get_node("/root/Global").cash >= get_node("/root/Global").meleeUnlockedPrice:
				get_node("/root/Global").cash -= get_node("/root/Global").meleeUnlockedPrice
				get_node("/root/Global").meleeUnlocked = true
			else:
				pass
		_on_meleeUnlock_pressed()
		
	if meleeDamageSelected:
		if get_node("/root/Global").meleeDamageUpgradeCosts.size() > 0:
			var price = get_node("/root/Global").meleeDamageUpgradeCosts[0]
			if get_node("/root/Global").cash >= price:
				get_node("/root/Global").meleeDamage += get_node("/root/Global").meleeDamageUpgradeAmount
				get_node("/root/Global").meleeDamageUpgradeCosts.pop_front()
			else:
				pass
		_on_meleeDamage_pressed()
		
		
	if meleeKnockbackSelected:
		if get_node("/root/Global").meleeKnockbackUpgradeCosts.size() > 0:
			var price = get_node("/root/Global").meleeKnockbackUpgradeCosts[0]
			if get_node("/root/Global").cash >= price:
				get_node("/root/Global").meleeKnockback += get_node("/root/Global").meleeKnockbackUpgradeAmount
				get_node("/root/Global").meleeKnockbackUpgradeCosts.pop_front()
			else:
				pass
		_on_meleeKnockback_pressed()
