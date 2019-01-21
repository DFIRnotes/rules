In which we practice writing intelligence requirements as part of studying the process. As they say in novels:
"Any characters, locations, events, or and situations portrayed etc. etc." These are for example purposes only, YMMV.

# Example intelligence requirements (IRs)

_One question each only; Focus on a fact or activity_

## Network and Host Visibility
_part of environmental and analytical coverage_

### Which networks feed connection data into SIEM ?

* What are all of the logical networks?
  * foreach \$network
    1. Does it generate flows/Zeek logs ?
    1. Are those flowing into SIEM ?
      
### What endpoints feed process and network data into SIEM ?

* What are 'buckets' types of endpoints ?
  * foreach \$endpoint_bucket
    1. EDR installed, functional (or other collection) ?
    1. Flowing into SIEM ?
    
## Email malware capabilities (chain)

_email threat and block collection -> \$email\_threat\_data_

### (do good stuff to get email threat data)
* (email block events)
* (email attachment file data)
* (capabilities scans (yara?) and sampling manual analysis fill-ins)

_capabilities survey_

### What techniques are the \$email\_threat\_data exhibiting?
_Sifting file attachments from URLs, droppers from downloaders and stagers ..._

* What delivery techniques ?
* What document or file formats ?
* What obfuscation techniques ?
* What anti-analysis techniques ?
* What device fingerprinting techniques ?
* What network/C2 techniques ?
  * What COMSEC seen?
  * Does the sample exhibit the ability to use TLS ?
    * (Certificate questions)
    * (middlebox effectiveness vs their TLS/comsec )

* Which of these techniques do we not detect/prevent with currently deployed controls ?

## Web malware capabilities (chain)

_Build a chain like email but for drivebys and exploit kits_

### (do good stuff to get \$web_threat_data)

### What techniques are the \$web\_threat\_data exhibiting?
_URLs and web code delivery_

* What delivery techniques ?
* What document or file formats ?
* What obfuscation techniques ?
* What anti-analysis techniques ?
* What device fingerprinting techniques ?
* ... active media content platforms like Java applets, Flash, ActiveX, Silverlight?
* ... code (JS) minification, obfuscation, encryption ?

_File based questions cross over with files IR chain (started with email delivery)_

_COMSEC and TLS questions cross over with files IR chain_

* Which of these techniques do we not detect/prevent with currently deployed controls ?

## Indicator Sweeps

_given sources of various indicator types, can we broadly and confidentailly check for them in the environment?_

_Seven days (7d) log searches and live scans for contrast, log availability and time scope questions found elsewhere, like in in the collections management framework (CMF) and its data access IRs_

### Host

* With an executable hash, can we measure what percentage of endpoints executed that files in the past 7 days ?
  * How long does it take to get these sweep results ?
* With a mutex, can we measure what percentage of endpoints manifested that in the past 7 days ?
  * How long does it take to get these sweep results ?
* With a Yara (mem) pattern,  can we measure what percentage of endpoints in-memory processes match ?
  * How long does it take to get these sweep results ?
* With a Yara (file) pattern,  can we measure what percentage of endpoints have that file in their local filesystem ?
  * How long does it take to get these sweep results ?
* With a data file hash (and size), can we measure what percentage of endpoints have that file in their local filesystem ?
  * How long does it take to get these sweep results ?

### Network

* With a domain name, can we measure what percentage of endpoints had any contact in the past 7 days ?
  * How long does it take to get these sweep results ?
* With a IPv4 (ARIN) address, can we measure what percentage of endpoints had any contact in the past 7 days ?
  * How long does it take to get these sweep results ?

### Other places for files
_clouds, fileshares, external media, backups..._

foreach \$fileshare
* With an executable hash, can we measure what percentage of fileshare have that file in their storage ?
  * How long does it take to get these sweep results ?
* With a data file hash (and size), can we measure what percentage of fileshare have that file in their storage ?
  * How long does it take to get these sweep results ?
* With a Yara (file) pattern,  can we measure what percentage of fileshare have that file in their storage ?
  * How long does it take to get these sweep results ?

## Threat Model

_Some chains leading towards threat models or at least thinking about strategic risks_

What do we have that they want (CNE)?
*  Who are they?
*  What do we have?
*  ... that they want?
  
What might they do to get it (CNE)?
* (threat actor capabilities)
* (vs. attack surface)

How could our operations be significantly disrupted by an attack (CNA) ?
* (attack service vs DoS techniques)
* (threat actor capabilities)

### Software supply chain

_In which SSDLC, module and dependency management, license management, build standards and configuration meet back up with threat modeling via vulnerability management..._