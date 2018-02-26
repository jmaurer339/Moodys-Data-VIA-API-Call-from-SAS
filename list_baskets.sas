*** Retrieves a list of Baskets Available on the Account ***/


/** Keys for Authentication **/
%let EncryptionKey = xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx;
%let AccessKey     = yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy;


/*** URL for retrieving a list of Baskets Available on the Account  ***/
%let URL  = https://api.economy.com/data/v1/baskets/;

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
libname testmapi json fileref=modyresp;
proc datasets lib=testmapi; run;
data basketlist; 		set testmapi.root; run;

