rule CAP_HookExKeylogger
{
meta:
    author = "Brian C. Bell -- @biebsmalwareguy"

	strings:
	$s1 = "SetWindowsHookExA" nocase
	$s2 = "WH_KEYBOARD_LL" nocase
	$s3 = "WH_KEYBOARD" nocase

	condition:
    2 of them
}
