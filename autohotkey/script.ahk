
#!t::Run node %A_ScriptDir%\..\scripts\update-colors.js,,Hide
#!o::
Gui, +AlwaysOnTop -SysMenu -Caption +Owner  ; +Owner avoids a taskbar button.
Gui, Margin, 5, 5
Gui, Font, s10 , FiraCode NF
playicon := Chr(0xf909)
pauseicon := Chr(0xf8e3)
stopicon := Chr(0xf9da)
closeicon := Chr(0xfaac)
Gui, Add, Button, x25 gOBSCmd, %playicon%
Gui, Add, Button, ys gOBSCmd, %pauseicon%
Gui, Add, Button, ys gOBSCmd, %stopicon%
Gui, Add, Button, ys gWClose, %closeicon%
Gui, Show, , Title of Window  ;
OnMessage(0x201, "WM_LBUTTONDOWN") ;0x201 is the number for Windows Message WM_LBUTTONDOWN, which is the message Windows sends when the mouse clicks on our window.
return

OBSCmd:
MsgBox Yes
return

WClose:
Gui, Destroy
return

WM_LBUTTONDOWN(wParam, lParam, msg, hwnd)
{
Gui, +LastFound
Checkhwnd := WinExist()
if hwnd = %Checkhwnd%
{
PostMessage, 0xA1, 2 ;0xA1 is WM_NCLBUTTONDOWN, to make Windows think we clicked on the non-client area of the window (the border).  The "2" tells windows we clicked on caption at the top of the window, as if to drag it.
}
} 
