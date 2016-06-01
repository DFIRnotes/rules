import "pe"

rule upx_section_name
{
	strings:
		$upx0 = "upx0" nocase
		$upx1 = "upx1" nocase
	condition:
		any of ($upx*) and 
		for any j in (0..pe.number_of_sections - 1): (
			pe.sections[j].name == "UPX0" or
			pe.sections[j].name == "UPX1" )
}
