#SingleInstance, Force
SetWorkingDir, %A_ScriptDir%

; Reference script for paths

getINIData(path){
    FileRead, retrieved, %path%

    retrievedData := {}
    readingPoint := 0

    if (!ErrorLevel){
        ls := StrSplit(retrieved,"`r`n")
        for i,v in ls {
            isHeader := RegExMatch(v,"\[(.*)]")
            if (v && readingPoint && !isHeader){
                RegExMatch(v,"(.*)(?==)",index)
                RegExMatch(v,"(?<==)(.*)",value)
                if (index){
                    retrievedData[index] := value
                }
            } else if (isHeader){
                readingPoint := 1
            }
        }
    } else {
        MsgBox, An error occurred while reading %path% data, please review the file.
        return
    }
    return retrievedData
}
global options = getINIData("..\settings\config.ini")

global regWalkFactor := 1.25 ; since i made the paths all with vip, normalize

getWalkTime(d){
    return d*(1 + (regWalkFactor-1)*(1-options.VIP))
}

walkSleep(d){
    Sleep, % getWalkTime(d)
}

global azertyReplace := {"w":"z","a":"q"}

walkSend(k,t){
    if (options.AzertyLayout && azertyReplace[k]){
        k := azertyReplace[k]
    }
    Send, % "{" . k . (t ? " " . t : "") . "}"
}

press(k, duration := 50) {
    walkSend(k,"Down")
    walkSleep(duration)
    walkSend(k,"Up")
}
press2(k, k2, duration := 50) {
    walkSend(k,"Down")
    walkSend(k2,"Down")
    walkSleep(duration)
    walkSend(k,"Up")
    walkSend(k2,"Up")
}

reset() {
    press("Esc",150)
    Sleep, 50
    press("r",150)
    Sleep, 50
    press("Enter",150)
    Sleep, 50
}
jump() {
    press("Space")
}

collect(num){
    if (!options["ItemSpot" . num]){
        return
    }
    Loop, 5
    {
        Send {f}
        Sleep, 100
    }
    Send {e}
    Sleep, 50
}

isFullscreen() {
	WinGetPos,,, w, h, Roblox
	return (w = A_ScreenWidth && h = A_ScreenHeight)
}

GetRobloxHWND()
{
	if (hwnd := WinExist("Roblox ahk_exe RobloxPlayerBeta.exe"))
		return hwnd
	else if (WinExist("Roblox ahk_exe ApplicationFrameHost.exe"))
	{
		ControlGet, hwnd, Hwnd, , ApplicationFrameInputSinkWindow1
		return hwnd
	}
	else
		return 0
}

getRobloxPos(ByRef x := "", ByRef y := "", ByRef width := "", ByRef height := "", hwnd := ""){
    if !hwnd
        hwnd := GetRobloxHWND()
    VarSetCapacity( buf, 16, 0 )
    DllCall( "GetClientRect" , "UPtr", hwnd, "ptr", &buf)
    DllCall( "ClientToScreen" , "UPtr", hwnd, "ptr", &buf)

    x := NumGet(&buf,0,"Int")
    y := NumGet(&buf,4,"Int")
    width := NumGet(&buf,8,"Int")
    height := NumGet(&buf,12,"Int")
}

getColorComponents(color){
    return [color & 255, (color >> 8) & 255, (color >> 16) & 255]
}

compareColors(color1, color2) ; determines how far apart 2 colors are
{
    color1V := getColorComponents(color1)
    color2V := getColorComponents(color2)

    cV := [color1V[1] - color2V[1], color1V[2] - color2V[2], color1V[3] - color2V[3]]
    dist := Abs(cV[1]) + Abs(cV[2]) + Abs(cV[3])
    return dist
}

closeChat(){
    getRobloxPos(pX,pY,width,height)
    PixelGetColor, chatCheck, % pX + 75, % pY + 12, RGB
    if (compareColors(chatCheck,0xffffff) < 16){ ; is chat open??
        MouseMove, % pX + 75, % pY + 12
        Sleep, 300
        MouseClick
        Sleep, 100
    }
}

global menuBarOffset := 10 ;10 pixels from left edge

getMenuButtonPosition(num, ByRef posX := "", ByRef posY := ""){ ; num is 1-7, 1 being top, 7 only existing if you are the private server owner
    getRobloxPos(rX, rY, width, height)

    menuBarVSpacing := 10.5*(height/1080)
    menuBarButtonSize := 58*(width/1920)
    menuEdgeCenter := [rX + menuBarOffset, rY + (height/2)]
    startPos := [menuEdgeCenter[1]+(menuBarButtonSize/2),menuEdgeCenter[2]+(menuBarButtonSize/4)-(menuBarButtonSize+menuBarVSpacing-1)*3.5] ; final factor = 0.5x (x is number of menu buttons visible to all, so exclude private server button)
    
    posX := startPos[1]
    posY := startPos[2] + (menuBarButtonSize+menuBarVSpacing)*(num-1)

    MouseMove, % posX, % posY
}

clickMenuButton(num){
    getMenuButtonPosition(num, posX, posY)
    MouseMove, posX, posY
    Sleep, 200
    MouseClick
}

rotateCameraMode(){
    press("Esc")
    Sleep, 500
    press("Tab")
    Sleep, 500
    press("Down")
    Sleep, 150
    press("Right")
    Sleep, 150
    press("Right")
    Sleep, 150
    press("Esc")
    Sleep, 250

    camFollowMode := !camFollowMode
}

alignCamera(){
    closeChat()
    Sleep, 200

    reset()
    Sleep, 100

    getRobloxPos(rX,rY,rW,rH)

    rotateCameraMode()

    clickMenuButton(2)
    Sleep, 500
    
    MouseMove, % rX + rW*0.15, % rY + 44 + rH*0.05 + options.BackOffset
    Sleep, 200
    MouseClick
    Sleep, 200

    rotateCameraMode()

    Sleep, 100

    walkSend("w","Down")
    walkSend("d","Down")
    walkSleep(500)
    jump()
    walkSleep(400)
    jump()
    walkSleep(600)

    walkSend("d","Up")
    walkSend("a","Down")
    walkSleep(1500)

    walkSend("a","Up")
    walkSend("w","Up")

    rotateCameraMode()

    Sleep, 1500

    rotateCameraMode()

    reset()
    Sleep, 2000
}

global azertyReplace := {"w": "z", "a": "q"} 

sendKey(key, type = ""){
 azertyKey := azertyReplace[key]
 key := options.AzertyLayout && azertyKey ? azertyKey : key
 
 Send {%key% %type%}
}

arcaneTeleport(){
    press("x",50)
}

item5plus(){

    If (options.ArcanePath) {

        walkSend("w","Down")
        walkSend("a","Down")
        walkSleep(500)
        arcaneTeleport()
        walkSleep(2500)
        walkSend("a","Up")
        walkSleep(750)
        walkSend("w","Up")
        collect(5)

    } else {

        walkSend("w","Down")
        walkSend("a","Down")
        walkSleep(3750)
        walkSend("a","Up")
        walkSleep(750)
        walkSend("w","Up")
        collect(5)

    }
   
    walkSend("a","Down")
    walkSleep(777)
    ; :)
    jump()
    walkSend("w","Down")
    walkSleep(350)
    walkSend("w","Up")
    walkSleep(750)
    walkSend("s","Down")
    walkSleep(350)
    walkSend("s","Up")
    walkSleep(1000)
    jump()
    walkSleep(350)
    walkSend("a","Up")
    collect(6)

    If (options.Exoflex) {

        walkSend("s","Down")
        walkSleep(1750)
        walkSend("s","Up")
        walkSend("a","Down")
        walkSleep(350)
        jump()
        walkSleep(1500)
        jump()
        walkSleep(750)
        walkSend("s","Down")
        walkSleep(500)
        walkSend("s","Up")
        walkSleep(200)
        walkSend("a","Up")
        jump()
        walkSleep(250)
        walkSend("a","Down")
        walkSleep(500)
        jump()
        walkSleep(500)
        walkSend("s","Down")
        walkSleep(250)
        walkSend("a","Up")
        walkSend("s","Down")
        jump()
        walkSleep(175)
        walkSend("s","Up")
        walkSleep(350)
        walkSend("d","Down")
        walkSleep(350)
        walkSend("d","Up")
        collect(7)

    } else {

        walkSend("a","Down")
        walkSleep(2500)
        press("s",500)
        walkSend("a","Up")
        walkSend("s","Down")
        walkSleep(100)
        jump()
        walkSleep(800)
        walkSend("a","Down")
        walkSleep(400)
        jump()
        walkSleep(200)
        walkSend("a","Up")
        walkSend("s","Down")
        walkSleep(200)
        jump()
        walkSleep(800)
        jump()
        walkSleep(600)
        jump()
        walkSleep(800)
        jump()
        walkSleep(200)
        walkSend("s","Up")
        walkSend("d","Down")
        walksleep(100)
        walkSend("d","Up")
        sleep, 100
        collect(7)

    }
}