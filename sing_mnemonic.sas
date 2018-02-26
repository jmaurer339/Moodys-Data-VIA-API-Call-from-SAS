/*** Retrieves a single Moody mnemonic series ***/


/** Keys for Authentication **/
%let EncryptionKey = xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx;
%let AccessKey     = yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy;

/*** Build the URL ***/

/** specifiy mnemonic **/
%let mnemonic = FIP.US;
/* Series Endpoint */ 
%let uriEndpoint = https://api.economy.com/data/v1/series/;
%let sep1 = ?m= ;
/*** Final URL  ***/
%let URL = &uriEndpoint.&sep1.&mnemonic;

/** Build the Encrypted Signature **/
%moody_encrpt(&AccessKey, &EncryptionKey);

/** Make the API Call **/
filename modyresp TEMP;
proc http
 url="&URL"  
 method="GET"
 out=modyresp ;
 headers
 	"AccessKeyId"="&AccessKey"
	"TimeStamp"="&TimeStamp"
	"Signature"="&E_Sig";
run;

/** Read Response **/
libname moodyser json fileref=modyresp;
proc datasets lib=moodyser; run;

data ser_alldat;	set moodyser.alldata; run;
data ser_rootdat;	set moodyser.root; run;
data ser_dat;		set moodyser.data; run;
data ser_datdat;	set moodyser.data_data; run;