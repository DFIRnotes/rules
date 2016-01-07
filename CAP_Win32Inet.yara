/* 
  Version 0.0.0
*/

rule String_Winsock2
{
    meta:
        author = "@adricnet"
        description = "Match Winsock 2 API library declaration"
        method = "String match"
    strings:
        $ws2_lib = "Ws2_32"
    condition:
	(all of ($ws2*))
}

rule String_Wininet
{
    meta:
        author = "@adricnet"
        description = "Match Windows Inet API library declaration"
        method = "String match"
    strings:
        $wininet_lib = "WININET.dll" nocase
    condition:
	(all of ($wininet*))
}
