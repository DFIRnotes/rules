rule CAP_HookExKeylogger
{
meta:
    author = "Brian C. Bell -- @biebsmalwareguy"

	strings:
	$str_Win32hookapi = "SetWindowsHookEx" nocase
	$str_Win32llkey = "WH_KEYBOARD_LL" nocase
	$str_Win32key = "WH_KEYBOARD" nocase

	condition:
    2 of them
}
