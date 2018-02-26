
%macro moody_encrpt(A_key, E_Key) ;
	/** Takes as input an account specific Moodys Access Key and Encryption Key		**/	
	/** and produces as output the encriptied signature needed for API calls to Moodys	**/

	%global TimeStamp E_Sig;

	/** Create Timestamp **/
	data _null_;  
		length time_stmp $20;
		uctdatetime = tzones2u(datetime());    				*** Convert current date and time to UCT ;
		time_stmp =  strip(cat(put(uctdatetime, E8601DT20.), "Z"));	*** Build appropriate time stamp required for message;
		call symput("TimeStamp", time_stmp);				*** Write Time Stamp value to Macro variable;
		run;

	/** Create Hashed/Encrypted Signature **/
	/** Message is a concatenation of the Access Key and the TimeStamp **/
	/** That Message is encrypted using SHA256HMACHEX and the Encryption Key **/
	/** The Signature is the encrypted value of the Message ***/
	data _null_; 
		akey = "&A_key";
		tsmp = "&TimeStamp";
		ekey = "&E_key";
		msg = akey || tsmp;

		mysig = SHA256HMACHEX(ekey, msg,0);
		mysig = lowcase(mysig);
		call symput("E_Sig", mysig);

		put '    ';
		put '   ****************************************************** 	';
		put '   Final Input Values To API Call	';		
		put '   Time Stamp                ' tsmp;
		put '   My Moodys Access Key      ' akey;
		put '   My Moodys Encryption Key  ' ekey;
		put '   Resulting Signature       ' mysig;
		put '   ****************************************************** 	';

		run;
	%let E_Sig = %cmpres(&E_Sig);

%mend;