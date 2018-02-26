/*** RETRIVES/DOWNLOADS  data from a particular Basket on the Moodys Site  									  ***/
/*** assumes data has already been created (that is the Basket has already been run) on the Moodys site 	  ***/
/*** This particular basket was created on the Moodys site as a CSV - response file is set up to expect a CSV ***/

/** Keys for Authentication **/
%let EncryptionKey = xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx;
%let AccessKey     = yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy;

%let BasketId		=bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb;

/** Build the URL **/
%let url1  = %nrstr(https://api.economy.com/data/v1/orders?type=baskets&id=);
%let URL   = &url1.&BasketID;

/** Build the Encrypted Signature **/
%moody_encrpt(&AccessKey, &EncryptionKey);

/** Make the API Call **/
filename modyresp '/home/sas/data/Jim/Test Data/mdataout.csv' ;
proc http
 url="&url"  
 method="GET"
 out=modyresp ;
 headers
 	"AccessKeyId"="&AccessKey"
	"TimeStamp"="&TimeStamp"
	"Signature"="&E_Sig";
run;

