# rules
*Rule files of some use to us, and perhaps some scripts*

In particular @thatguy31415 is working on a collection of rules to categorize files by capabilities, with inspiration from
michael.ligh@mnin.org's marvelous example in Chapter 4 of the *Malware Analyst Cookbook*, carried from Google Code into GitHub by @yararules, and shipped in @lennyzeltser's @REMnux (seriously, the MD5 hashes match).

# here
* some simple yara rules that hit on imported libraries and function calls (CAP_something)
* a batch processing Volatility script or two (eg for SIFT)
* other sample yara rules, such as for PE module

# todos
* [.] Win32 Inet CAP yara rule : string match works
	* [ ] needs ordinal detection, which will require yara++ and pe module
* [.] Win32 crypto CAP yara rule : string match works
	* [ ] needs ordinal detection, which will require yara++ and pe module
* [ ] Ransomware strings CAP yara rule 
	* cryptocurrency help sites?
* [ ] DotNet CAP yara rule
	* DotNet doesn't use PE header so much 	
* [.] OpenIOC sample rules, but see some [caveats](https://gist.github.com/adricnet/cb46d182200a40deb6d62c3906da59c9) 
