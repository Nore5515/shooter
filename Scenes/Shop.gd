extends Button



var pistolClipUpgrade = false
var pistolAutoUpgrade = false



func hideAll():
	$ItemSelect/PistolDetails.visible = false
	$ItemSelect/ItemDesc.text = ""


func toggleAll():
	pistolClipUpgrade = false
	pistolAutoUpgrade = false


func _on_Pistol_pressed():
	if $ItemSelect/PistolDetails.visible == true:
		hideAll()
	else:
		hideAll()
		$ItemSelect/PistolDetails.visible = true
		$ItemSelect/ItemDesc.text = "A magazine fed pistol. Good all around, but can struggle at close quarters. It's main struggle is ammo."
	


func _on_pistolDamage_pressed():
	toggleAll()
	if $ItemSelect/PistolDetails/pistolUpradeDetails.text == "":
		$ItemSelect/PistolDetails/pistolUpradeDetails.text = "DAMAGE: damage is WIP."
	elif $ItemSelect/PistolDetails/pistolUpradeDetails.text == "DAMAGE: damage is WIP.":
		$ItemSelect/PistolDetails/pistolUpradeDetails.text = ""
	else:
		$ItemSelect/PistolDetails/pistolUpradeDetails.text = "DAMAGE: damage is WIP."
		



func _on_pistolClip_pressed():
	toggleAll()
	if $ItemSelect/PistolDetails/pistolUpradeDetails.text == "":
		var txt = "The current pistol clip size is: " + String(get_node("/root/Global").pistolSize)
		txt += "\nIt currently costs..."
		if get_node("/root/Global").pistolUpgradeCosts.size() > 0:
			txt += String(get_node("/root/Global").pistolUpgradeCosts[0])
			pistolClipUpgrade = true
		$ItemSelect/PistolDetails/pistolUpradeDetails.text = txt
	elif $ItemSelect/PistolDetails/pistolUpradeDetails.text == "Clip is WIP too..":
		$ItemSelect/PistolDetails/pistolUpradeDetails.text = ""
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
	elif $ItemSelect/PistolDetails/pistolUpradeDetails.text == details:
		$ItemSelect/PistolDetails/pistolUpradeDetails.text = ""
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
