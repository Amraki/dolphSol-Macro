#singleinstance, force
#noenv
RegExMatch(A_ScriptDir, ".*(?=\\paths)", mainDir)
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen
#Include ..\lib\pathReference.ahk

; patch by Amraki
; revision by sanji (sir.moxxi) and Flash (drflash55). Also unofficially by Xilenti (xianleigh) and Lizz (lizz44fu)

walkSend("s","Down")
walkSend("a","Down")
walkSleep(1300)
walkSend("a","Up")
walkSleep(2150)
walkSend("s","Up")
collect(1)

walkSend("d","Down")
walkSleep(3200)
walkSend("s","Down")
walkSleep(600)
walkSend("s","Up")
walkSleep(400)
walkSend("d","Up")
collect(2)
if (options.VIP){

    walkSend("a","Down")
    walkSleep(150)
    walkSend("w","Down")
    walkSleep(950)
    walkSend("a","Up")
    walkSleep(1950)
    jump()
    walkSleep(600)
    walkSend("d","Down")
    jump()
    walkSleep(450)
    walkSend("d","Up")
    jump()
    walkSleep(350)
    walkSend("w","Up")
    collect(3)

    walkSend("w","Down")
    walkSleep(100)
    walkSend("d","Down")
    walkSleep(600)
    walkSend("d","Up")
    walkSleep(200)
    walkSend("w","Up")
    collect(4)

    reset()
    Sleep, 2000

    walkSend("w","Down")
    walkSend("a","Down")
    walkSleep(3750)
    walkSend("a","Up")
    walkSleep(750)
    walkSend("w","Up")
    collect(5)

    walkSend("a","Down")
    walkSleep(777)
    ; :)
    jump()
    walkSend("w","Down")
    walkSleep(350)
    walkSend("w","Up")
    walkSend("a","Down")
    walkSleep(750)
    walkSend("s","Down")
    walkSleep(350)
    walkSend("s","Up")
    walkSleep(1125)
    jump()
    walkSleep(350)
    walkSend("a","Up")
    collect(6)

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
} else {
    ; back to spawn
    reset()
    Sleep, 2000

    walkSend("d","Down")
    walkSleep(300)
    jump()
    walkSleep(350)
    walkSend("w","Down")
    walkSleep(250)
    jump()
    walkSleep(350)
    walkSend("d","Up")
    walkSleep(250)
    jump()
    walkSleep(350)
    walkSend("w","Up")
    walkSend("d","Down")
    walkSleep(100)
    jump()
    walkSleep(350)
    walkSend("s","Down")
    walkSleep(350)
    walkSend("s","Up")
    walkSleep(225)
    walkSend("d","Up")
    collect(3)

    walkSend("d","Down")
    walkSleep(500)
    walkSend("w","Down")
    walkSleep(350)
    walkSend("d","Up")
    walkSleep(200)
    walkSend("w","Up")
    collect(4)

    reset()
    Sleep, 2000

    walkSend("w","Down")
    walkSend("a","Down")
    walkSleep(3750)
    walkSend("a","Up")
    walkSleep(750)
    walkSend("w","Up")
    collect(5)

    walkSend("a","Down")
    walkSleep(777)
    ; :)
    jump()
    walkSend("w","Down")
    walkSleep(350)
    walkSend("w","Up")
    walkSend("a","Down")
    walkSleep(750)
    walkSend("s","Down")
    walkSleep(350)
    walkSend("s","Up")
    walkSleep(1125)
    jump()
    walkSleep(350)
    walkSend("a","Up")
    collect(6)

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