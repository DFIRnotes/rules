// Practice Yara rule: look for base64 encoded PE in a DOC file
// requires Yara 3.4+, magic module

/*
  github.com/dfirnotes/rules
  Version 0.0.0
*/

//import "pe"
//import "hash"
//import "math"
import "magic"

rule is_office_doc
{
//  strings:
//    $cdf_str="Composite Document File"

  condition:
//  magic.type() contains $cdf_str
    magic.type() contains "Composite Document File"
}

rule base64_pe_strings
{
  strings:
    $b64MZ = "TVpAAA"

  condition:
    $b64MZ
}

rule Office_Possible_Base64_PE: homework
{
  meta:
    author = "@adricnet"
  condition:
    is_office_doc and base64_pe_strings
}
