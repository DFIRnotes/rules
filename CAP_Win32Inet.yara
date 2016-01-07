/* 
  github.com/dfirnotes/rules
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

rule String_Wininet_Library
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

rule String_Internet_API
{
    meta:
        author = "@adricnet"
        description = "Match Windows Inet API call"
        method = "String match, trim the As"
    strings:
	$wininet_call_closeh = "InternetCloseHandle"
	$wininet_call_readf = "InternetReadFile"
	$wininet_call_connect = "InternetConnect"
	$wininet_call_open = "InternetOpen"

    condition:
	(any of ($wininet_call*))
}

rule String_Http_API
{
    meta:
        author = "@adricnet"
        description = "Match Windows Http API call"
        method = "String match, trim the As"
    strings:
	$wininet_call_httpr = "HttpSendRequest"
	$wininet_call_httpq = "HttpQueryInfo"
	$wininet_call_httpo = "HttpOpenRequest"
    condition:
	(any of ($wininet_call_http*))
}
