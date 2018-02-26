
/*** EXECUTES/RUNS (does not download or retrieve) a particular Basket on the Moody Site ***/

/** Keys for Authentication **/
%let EncryptionKey = xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx;
%let AccessKey     = yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy;


%let BasketId		=bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb;

/** Build the URL **/
%let url1  = %nrstr(https://api.economy.com/data/v1/orders?type=baskets&action=run&id=);
%let URL   = &url1.&BasketID;


/** Build the Encrypted Signature **/
%moody_encrpt(&AccessKey, &EncryptionKey);

/** Make the API Call **/
filename modyresp TEMP;
proc http
 url="&url"  
 method="POST"
 out=modyresp ;
 headers
 	"AccessKeyId"="&AccessKey"
	"TimeStamp"="&TimeStamp"
	"Signature"="&E_Sig";
run;

/** Read Response **/
libname testmapi json fileref=modyresp;
proc datasets lib=testmapi; run;
data run_root; 		set testmapi.root; run;
data run_alldata; 	set testmapi.alldata; run;