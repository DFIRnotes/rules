# rules
*Yara rules of some use to us*

In particular @thatguy31415 is working on a collection of rules to categorize files by capabilities, with inspiration from
michael.ligh@mnin.org's marvelous example in Chapter 4 of the *Malware Analyst Cookbook*, carried from Google Code into GitHub by @yararules, and shipped in @lennyzeltser's @REMnux (seriously, the MD5 hashes match).

# TODO
* [.] Win32Inet CAP yara rule 
	* [ ] needs ordinal detection, which will require yara++ and pe module
* [ ] RSA enh strings CAP yara rule
* [ ] Ransomware strings CAP yara rule 
	* bc help sites?
* [ ] DotNet CAP yara rule
* [ ] OpenIOC rule: $browser -> .* -> vssadmin (cryptowall prev ver)
  
