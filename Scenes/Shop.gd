extends Button



var pistolClipUpgrade = false
var pistolAutoUpgrade = false
var pistolDamageUpgrade = false


func hideAll():
	$ItemSelect/PistolDetails.visible = false
	$ItemSelect/ItemDesc.text = ""


func toggleAll():
	pistolClipUpgrade = false
	pistolAutoUpgrade = false
	pistolDamageUpgrade = false


func _on_Pistol_pressed():
	if $ItemSelect/PistolDetails.visible == true:
		hideAll()
	else:
		hideAll()
		$ItemSelect/PistolDetails.visible = true
		$ItemSelect/ItemDesc.text = "A magazine fed pistol. Good all around, but can struggle at close quarters. It's main struggle is ammo."
	


func _on_pistolDamage_pressed():
	var txt
	toggleAll()
	if $ItemSelect/PistolDetails/pistolUpradeDetails.text == "":
		txt = "The current pistol damage is: " + String(get_node("/root/Global").pistolDamage)
		if get_node("/root/Global").pistolDamageUpgradeCosts.size() > 0:
			txt += "\nUpgrading it costs..." + String(get_node("/root/Global").pistolDamageUpgradeCosts[0])
			pistolDamageUpgrade = true
		$ItemSelect/PistolDetails/pistolUpradeDetails.text = txt
	else:
		txt = "The current pistol damage is: " + String(get_node("/root/Global").pistolDamage)
		if get_node("/root/Global").pistolDamageUpgradeCosts.size() > 0:
			txt += "\nUpgrading it costs..." + String(get_node("/root/Global").pistolDamageUpgradeCosts[0])
			pistolDamageUpgrade = true
		$ItemSelect/PistolDetails/pistolUpradeDetails.text = txt
		



func _on_pistolClip_pressed():
	toggleAll()
	if $ItemSelect/PistolDetails/pistolUpradeDetails.text == "":
		var txt = "The current pistol clip size is: " + String(get_node("/root/Global").pistolSize)
		txt += "\nIt currently costs..."
		if get_node("/root/Global").pistolUpgradeCosts.size() > 0:
			txt += String(get_node("/root/Global").pistolUpgradeCosts[0])
			pistolClipUpgrade = true
		$ItemSelect/PistolDetails/pistolUpradeDetails.text = txt
	else:
		var txt = "The current pistol clip size is: " + String(get_node("/root/Global").pistolSize)
		txt += "\nIt currently costs..."
		if get_node("/root/Global").pistolUpgradeCosts.size() > 0:
			txt += String(get_node("/root/Global").pistolUpgradeCosts[0])
			pistolClipUpgrade = true
		$ItemSelect/PistolDetails/pistolUpradeDetails.text = txt


func _on_pistolAuto_pressed():
	toggleAll()
	var details
	if get_node("/root/Global").pistolAuto:
		details = "Your pistol IS auto!"
	else:
		details = "You can change the pistol to an automatic!\n$100"
	if $ItemSelect/PistolDetails/pistolUpradeDetails.text == "":
		if get_node("/root/Global").pistolAuto == false:
			pistolAutoUpgrade = true
		$ItemSelect/PistolDetails/pistolUpradeDetails.text = details
	else:
		if get_node("/root/Global").pistolAuto == false:
			pistolAutoUpgrade = true
		$ItemSelect/PistolDetails/pistolUpradeDetails.text = details


func _on_pistolConfirm_pressed():
	if pistolClipUpgrade:
		if get_node("/root/Global").cash >= get_node("/root/Global").pistolUpgradeCosts[0]:
			get_node("/root/Global").cash -= get_node("/root/Global").pistolUpgradeCosts[0]
			get_node("/root/Global").pistolUpgradeCosts.pop_front()
			get_node("/root/Global").pistolSize += 3
			_on_pistolClip_pressed()
	elif pistolAutoUpgrade:
		if get_node("/root/Global").cash >= get_node("/root/Global").pistolAutoCost[0]:
			get_node("/root/Global").cash -= get_node("/root/Global").pistolAutoCost[0]
			get_node("/root/Global").pistolUpgradeCosts.pop_front()
			get_node("/root/Global").pistolAuto = true
			_on_pistolAuto_pressed()
	elif pistolDamageUpgrade:
		if get_node("/root/Global").cash >= get_node("/root/Global").pistolDamageUpgradeCosts[0]:
			get_node("/root/Global").cash -= get_node("/root/Global").pistolDamageUpgradeCosts[0]
			get_node("/root/Global").pistolDamageUpgradeCosts.pop_front()
			get_node("/root/Global").pistolDamage += get_node("/root/Global").pistolDamageUpgradeAmount
			_on_pistolDamage_pressed()
