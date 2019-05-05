use 5.006;
use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";
use NmerMatch qw(read_fasta build_catalog retrieve_catalog);
use Test::More;
use Data::Dumper;
use Data::Compare;

plan tests => 7;

my $expected_results = get_expected_results();

my $catalog_fasta = "$FindBin::Bin/test_db.fasta";
my $catalog_seq_ref = read_fasta($catalog_fasta);
ok(Compare($catalog_seq_ref, $expected_results->{catalog_seq_ref}), 'catalog fasta import');

my $nmer_length = 15;
my $catalog_name = "$FindBin::Bin/test_cat1";
my ($unique_nmer_id, $nmer_catalog,
	$seq_names_catalog, $catalog_info) = build_catalog($nmer_length, $catalog_name);

ok(Compare($unique_nmer_id, $expected_results->{unique_nmer_id}), 'unique nmer id generation');

ok(Compare($nmer_catalog, $expected_results->{nmer_catalog}), 'nmer catalog generation');

ok(Compare($seq_names_catalog, $expected_results->{seq_names_catalog}), 'seq names catalog generation');

# Now retrieve the catalog and see if the values match
($unique_nmer_id, $nmer_catalog,$seq_names_catalog) = retrieve_catalog();

ok(Compare($unique_nmer_id, $expected_results->{unique_nmer_id}), 'unique nmer id loading');

ok(Compare($nmer_catalog, $expected_results->{nmer_catalog}), 'nmer catalog loading');

ok(Compare($seq_names_catalog, $expected_results->{seq_names_catalog}), 'seq names catalog loading');


# load the expected results to compare with what is generated
sub get_expected_results {

	my $cat_seq_ref = [{'id' => 'sp|P31946|1433B_HUMAN','seq' => 'MTMDKSELVQKAKLAEQAERYDDMAAAMKAVTEQGHELSNEERNLLSVAYKNVVGARRSSWRVISSIEQKTERNEKKQQMGKEYREKIEAELQDICNDVLELLDKYLIPNATQPESKVFYLKMKGDYFRYLSEVASGDNKQTTVSNSQQAYQEAFEISKKEMQPTHPIRLGLALNFSVFYYEILNSPEKACSLAKTAFDEAIAELDTLNEESYKDSTLIMQLLRDNLTLWTSENQGDEGDAGEGEN'},{'id' => 'sp|P62258|1433E_HUMAN','seq' => 'MDDREDLVYQAKLAEQAERYDEMVESMKKVAGMDVELTVEERNLLSVAYKNVIGARRASWRIISSIEQKEENKGGEDKLKMIREYRQMVETELKLICCDILDVLDKHLIPAANTGESKVFYYKMKGDYHRYLAEFATGNDRKEAAENSLVAYKAASDIAMTELPPTHPIRLGLALNFSVFYYEILNSPDRACRLAKAAFDDAIAELDTLSEESYKDSTLIMQLLRDNLTLWTSDMQGDGEEQNKEALQDVEDENQ'}];
	my $unique_nmer = {'LAEQAERYDDMAAAM' => 13,'KLICCDILDVLDKHL' => 325,'SKVFYYKMKGDYHRY' => 348,'YDDMAAAMKAVTEQG' => 20,'ARRASWRIISSIEQK' => 286,'EENKGGEDKLKMIRE' => 301,'ELKLICCDILDVLDK' => 323,'YLKMKGDYFRYLSEV' => 119,'NSPEKACSLAKTAFD' => 184,'SELVQKAKLAEQAER' => 5,'EERNLLSVAYKNVIG' => 271,'ACRLAKAAFDDAIAE' => 412,'QMGKEYREKIEAELQ' => 78,'KGDYHRYLAEFATGN' => 356,'YYEILNSPDRACRLA' => 402,'IISSIEQKEENKGGE' => 293,'AYKNVIGARRASWRI' => 279,'REYRQMVETELKLIC' => 314,'DYHRYLAEFATGNDR' => 358,'GARRASWRIISSIEQ' => 285,'EMVESMKKVAGMDVE' => 253,'RLAKAAFDDAIAELD' => 414,'DDAIAELDTLSEESY' => 421,'ICCDILDVLDKHLIP' => 327,'RACRLAKAAFDDAIA' => 411,'RRASWRIISSIEQKE' => 287,'CCDILDVLDKHLIPA' => 328,'LDKYLIPNATQPESK' => 102,'AKAAFDDAIAELDTL' => 416,'GDNKQTTVSNSQQAY' => 136,'NLLSVAYKNVIGARR' => 274,'KEAAENSLVAYKAAS' => 373,'KQQMGKEYREKIEAE' => 76,'DRACRLAKAAFDDAI' => 410,'NKGGEDKLKMIREYR' => 303,'VTEQGHELSNEERNL' => 30,'DNLTLWTSENQGDEG' => 224,'DTLNEESYKDSTLIM' => 205,'ESKVFYLKMKGDYFR' => 114,'RYDEMVESMKKVAGM' => 250,'AYQEAFEISKKEMQP' => 149,'LALNFSVFYYEILNS' => 171,'LVAYKAASDIAMTEL' => 380,'HPIRLGLALNFSVFY' => 165,'NFSVFYYEILNSPDR' => 397,'AKLAEQAERYDEMVE' => 242,'VAYKAASDIAMTELP' => 381,'SVFYYEILNSPEKAC' => 176,'YLSEVASGDNKQTTV' => 129,'ELPPTHPIRLGLALN' => 393,'AKTAFDEAIAELDTL' => 193,'RVISSIEQKTERNEK' => 61,'TERNEKKQQMGKEYR' => 70,'LLSVAYKNVVGARRS' => 44,'IEQKEENKGGEDKLK' => 297,'ARRSSWRVISSIEQK' => 55,'YFRYLSEVASGDNKQ' => 126,'LTLWTSDMQGDGEEQ' => 440,'KAAFDDAIAELDTLS' => 417,'IRLGLALNFSVFYYE' => 167,'QAERYDEMVESMKKV' => 247,'VLDKHLIPAANTGES' => 334,'SIEQKTERNEKKQQM' => 65,'LWTSENQGDEGDAGE' => 228,'ELVQKAKLAEQAERY' => 6,'NATQPESKVFYLKMK' => 109,'DDREDLVYQAKLAEQ' => 233,'NSQQAYQEAFEISKK' => 145,'AMKAVTEQGHELSNE' => 26,'FSVFYYEILNSPEKA' => 175,'AANTGESKVFYYKMK' => 342,'EQAERYDEMVESMKK' => 246,'HRYLAEFATGNDRKE' => 360,'GNDRKEAAENSLVAY' => 369,'ELTVEERNLLSVAYK' => 267,'FDDAIAELDTLSEES' => 420,'RNLLSVAYKNVIGAR' => 273,'AVTEQGHELSNEERN' => 29,'DVELTVEERNLLSVA' => 265,'EDKLKMIREYRQMVE' => 307,'TVSNSQQAYQEAFEI' => 142,'EAELQDICNDVLELL' => 88,'WRVISSIEQKTERNE' => 60,'KLAEQAERYDDMAAA' => 12,'LELLDKYLIPNATQP' => 99,'LNSPDRACRLAKAAF' => 406,'QKTERNEKKQQMGKE' => 68,'GHELSNEERNLLSVA' => 34,'KLAEQAERYDEMVES' => 243,'REKIEAELQDICNDV' => 84,'MVESMKKVAGMDVEL' => 254,'QPESKVFYLKMKGDY' => 112,'ERYDDMAAAMKAVTE' => 18,'DREDLVYQAKLAEQA' => 234,'LWTSDMQGDGEEQNK' => 442,'MQPTHPIRLGLALNF' => 161,'MKGDYFRYLSEVASG' => 122,'HLIPAANTGESKVFY' => 338,'AEQAERYDEMVESMK' => 245,'FSVFYYEILNSPDRA' => 398,'DIAMTELPPTHPIRL' => 388,'SVAYKNVIGARRASW' => 277,'QPTHPIRLGLALNFS' => 162,'LSVAYKNVIGARRAS' => 276,'MTMDKSELVQKAKLA' => 0,'TELPPTHPIRLGLAL' => 392,'KNVIGARRASWRIIS' => 281,'YYKMKGDYHRYLAEF' => 352,'ATQPESKVFYLKMKG' => 110,'SYKDSTLIMQLLRDN' => 211,'CDILDVLDKHLIPAA' => 329,'NFSVFYYEILNSPEK' => 174,'YHRYLAEFATGNDRK' => 359,'LLSVAYKNVIGARRA' => 275,'IAMTELPPTHPIRLG' => 389,'LTVEERNLLSVAYKN' => 268,'DEMVESMKKVAGMDV' => 252,'VYQAKLAEQAERYDE' => 239,'YKNVVGARRSSWRVI' => 49,'EERNLLSVAYKNVVG' => 40,'LNFSVFYYEILNSPE' => 173,'TELKLICCDILDVLD' => 322,'LKLICCDILDVLDKH' => 324,'YKMKGDYHRYLAEFA' => 353,'DGEEQNKEALQDVED' => 450,'MAAAMKAVTEQGHEL' => 23,'KLKMIREYRQMVETE' => 309,'YKNVIGARRASWRII' => 280,'EMQPTHPIRLGLALN' => 160,'TEQGHELSNEERNLL' => 31,'SDMQGDGEEQNKEAL' => 445,'REDLVYQAKLAEQAE' => 235,'TMDKSELVQKAKLAE' => 1,'GDYHRYLAEFATGND' => 357,'VAYKNVVGARRSSWR' => 47,'DVLELLDKYLIPNAT' => 97,'ANTGESKVFYYKMKG' => 343,'YLIPNATQPESKVFY' => 105,'EILNSPEKACSLAKT' => 181,'LKMKGDYFRYLSEVA' => 120,'YKAASDIAMTELPPT' => 383,'YEILNSPEKACSLAK' => 180,'IMQLLRDNLTLWTSE' => 218,'QDICNDVLELLDKYL' => 92,'TTVSNSQQAYQEAFE' => 141,'QAYQEAFEISKKEMQ' => 148,'EVASGDNKQTTVSNS' => 132,'VASGDNKQTTVSNSQ' => 133,'IPNATQPESKVFYLK' => 107,'FYYEILNSPEKACSL' => 178,'SGDNKQTTVSNSQQA' => 135,'KAVTEQGHELSNEER' => 28,'GMDVELTVEERNLLS' => 263,'KIEAELQDICNDVLE' => 86,'TGNDRKEAAENSLVA' => 368,'DRKEAAENSLVAYKA' => 371,'VFYYEILNSPDRACR' => 400,'DKSELVQKAKLAEQA' => 3,'SWRVISSIEQKTERN' => 59,'MIREYRQMVETELKL' => 312,'LGLALNFSVFYYEIL' => 169,'QKAKLAEQAERYDDM' => 9,'ELLDKYLIPNATQPE' => 100,'ERNEKKQQMGKEYRE' => 71,'LNEESYKDSTLIMQL' => 207,'KEENKGGEDKLKMIR' => 300,'SPEKACSLAKTAFDE' => 185,'YYEILNSPEKACSLA' => 179,'TGESKVFYYKMKGDY' => 345,'LVQKAKLAEQAERYD' => 7,'GGEDKLKMIREYRQM' => 305,'LPPTHPIRLGLALNF' => 394,'VQKAKLAEQAERYDD' => 8,'VVGARRSSWRVISSI' => 52,'RYLSEVASGDNKQTT' => 128,'SNSQQAYQEAFEISK' => 144,'PESKVFYLKMKGDYF' => 113,'GEEQNKEALQDVEDE' => 451,'ELDTLSEESYKDSTL' => 426,'KGDYFRYLSEVASGD' => 123,'TLSEESYKDSTLIMQ' => 429,'NDVLELLDKYLIPNA' => 96,'EEQNKEALQDVEDEN' => 452,'KYLIPNATQPESKVF' => 104,'KDSTLIMQLLRDNLT' => 213,'GKEYREKIEAELQDI' => 80,'YQAKLAEQAERYDEM' => 240,'KMKGDYFRYLSEVAS' => 121,'KVFYYKMKGDYHRYL' => 349,'KGGEDKLKMIREYRQ' => 304,'GLALNFSVFYYEILN' => 170,'YKDSTLIMQLLRDNL' => 212,'ELQDICNDVLELLDK' => 90,'SNEERNLLSVAYKNV' => 38,'ERNLLSVAYKNVIGA' => 272,'EYREKIEAELQDICN' => 82,'KMKGDYHRYLAEFAT' => 354,'SMKKVAGMDVELTVE' => 257,'AKLAEQAERYDDMAA' => 11,'ISSIEQKTERNEKKQ' => 63,'EESYKDSTLIMQLLR' => 209,'ERYDEMVESMKKVAG' => 249,'NLLSVAYKNVVGARR' => 43,'GEDKLKMIREYRQMV' => 306,'SKKEMQPTHPIRLGL' => 157,'EISKKEMQPTHPIRL' => 155,'MTELPPTHPIRLGLA' => 391,'IEAELQDICNDVLEL' => 87,'AAFDDAIAELDTLSE' => 418,'SQQAYQEAFEISKKE' => 146,'ATGNDRKEAAENSLV' => 367,'EKKQQMGKEYREKIE' => 74,'RSSWRVISSIEQKTE' => 57,'ASGDNKQTTVSNSQQ' => 134,'QEAFEISKKEMQPTH' => 151,'DKHLIPAANTGESKV' => 336,'DYFRYLSEVASGDNK' => 125,'AGMDVELTVEERNLL' => 262,'VGARRSSWRVISSIE' => 53,'VAGMDVELTVEERNL' => 261,'KEMQPTHPIRLGLAL' => 159,'QLLRDNLTLWTSENQ' => 220,'AAMKAVTEQGHELSN' => 25,'DMAAAMKAVTEQGHE' => 22,'AAENSLVAYKAASDI' => 375,'KAASDIAMTELPPTH' => 384,'EAFEISKKEMQPTHP' => 152,'LKMIREYRQMVETEL' => 310,'LRDNLTLWTSDMQGD' => 436,'VIGARRASWRIISSI' => 283,'ELSNEERNLLSVAYK' => 36,'QLLRDNLTLWTSDMQ' => 434,'MQLLRDNLTLWTSDM' => 433,'AERYDDMAAAMKAVT' => 17,'DNLTLWTSDMQGDGE' => 438,'LSEVASGDNKQTTVS' => 130,'MGKEYREKIEAELQD' => 79,'RYLAEFATGNDRKEA' => 361,'LAEQAERYDEMVESM' => 244,'TLWTSDMQGDGEEQN' => 441,'NEESYKDSTLIMQLL' => 208,'SDIAMTELPPTHPIR' => 387,'FYLKMKGDYFRYLSE' => 118,'LSEESYKDSTLIMQL' => 430,'AIAELDTLSEESYKD' => 423,'VFYYKMKGDYHRYLA' => 350,'RKEAAENSLVAYKAA' => 372,'YEILNSPDRACRLAK' => 403,'RQMVETELKLICCDI' => 317,'DDMAAAMKAVTEQGH' => 21,'RDNLTLWTSDMQGDG' => 437,'TLIMQLLRDNLTLWT' => 216,'QGHELSNEERNLLSV' => 33,'AIAELDTLNEESYKD' => 200,'CRLAKAAFDDAIAEL' => 413,'NEERNLLSVAYKNVV' => 39,'AYKNVVGARRSSWRV' => 48,'DKLKMIREYRQMVET' => 308,'PEKACSLAKTAFDEA' => 186,'QTTVSNSQQAYQEAF' => 140,'ENKGGEDKLKMIREY' => 302,'SSWRVISSIEQKTER' => 58,'MDDREDLVYQAKLAE' => 232,'TAFDEAIAELDTLNE' => 195,'RASWRIISSIEQKEE' => 288,'RNLLSVAYKNVVGAR' => 42,'DNKQTTVSNSQQAYQ' => 137,'SIEQKEENKGGEDKL' => 296,'MKKVAGMDVELTVEE' => 258,'RYDDMAAAMKAVTEQ' => 19,'AMTELPPTHPIRLGL' => 390,'STLIMQLLRDNLTLW' => 215,'IAELDTLNEESYKDS' => 201,'KAKLAEQAERYDDMA' => 10,'IAELDTLSEESYKDS' => 424,'LIPAANTGESKVFYY' => 339,'GDYFRYLSEVASGDN' => 124,'EQKTERNEKKQQMGK' => 67,'KVAGMDVELTVEERN' => 260,'MQLLRDNLTLWTSEN' => 219,'CSLAKTAFDEAIAEL' => 190,'QQAYQEAFEISKKEM' => 147,'AYKAASDIAMTELPP' => 382,'TSENQGDEGDAGEGE' => 230,'SWRIISSIEQKEENK' => 290,'MQGDGEEQNKEALQD' => 447,'QGDGEEQNKEALQDV' => 448,'TLWTSENQGDEGDAG' => 227,'LSVAYKNVVGARRSS' => 45,'ESKVFYYKMKGDYHR' => 347,'WTSENQGDEGDAGEG' => 229,'KKVAGMDVELTVEER' => 259,'LLRDNLTLWTSENQG' => 221,'SLAKTAFDEAIAELD' => 191,'ICNDVLELLDKYLIP' => 94,'EILNSPDRACRLAKA' => 404,'YLAEFATGNDRKEAA' => 362,'ILDVLDKHLIPAANT' => 331,'EAAENSLVAYKAASD' => 374,'LSNEERNLLSVAYKN' => 37,'DMQGDGEEQNKEALQ' => 446,'NSLVAYKAASDIAMT' => 378,'ILNSPDRACRLAKAA' => 405,'LDVLDKHLIPAANTG' => 332,'SSIEQKEENKGGEDK' => 295,'WTSDMQGDGEEQNKE' => 443,'HELSNEERNLLSVAY' => 35,'DKYLIPNATQPESKV' => 103,'AFEISKKEMQPTHPI' => 153,'PAANTGESKVFYYKM' => 341,'KKEMQPTHPIRLGLA' => 158,'VETELKLICCDILDV' => 320,'SEESYKDSTLIMQLL' => 431,'AFDDAIAELDTLSEE' => 419,'MDKSELVQKAKLAEQ' => 2,'GARRSSWRVISSIEQ' => 54,'DAIAELDTLSEESYK' => 422,'IGARRASWRIISSIE' => 284,'KTERNEKKQQMGKEY' => 69,'KTAFDEAIAELDTLN' => 194,'PTHPIRLGLALNFSV' => 163,'LIPNATQPESKVFYL' => 106,'AASDIAMTELPPTHP' => 385,'LDTLNEESYKDSTLI' => 204,'SKVFYLKMKGDYFRY' => 115,'MKAVTEQGHELSNEE' => 27,'AFDEAIAELDTLNEE' => 196,'AERYDEMVESMKKVA' => 248,'ELDTLNEESYKDSTL' => 203,'VEERNLLSVAYKNVI' => 270,'LICCDILDVLDKHLI' => 326,'ESYKDSTLIMQLLRD' => 210,'VELTVEERNLLSVAY' => 266,'FATGNDRKEAAENSL' => 366,'ACSLAKTAFDEAIAE' => 189,'CNDVLELLDKYLIPN' => 95,'LNSPEKACSLAKTAF' => 183,'TSDMQGDGEEQNKEA' => 444,'AELDTLNEESYKDST' => 202,'LNFSVFYYEILNSPD' => 396,'SLVAYKAASDIAMTE' => 379,'YREKIEAELQDICND' => 83,'TVEERNLLSVAYKNV' => 269,'SVAYKNVVGARRSSW' => 46,'VFYYEILNSPEKACS' => 177,'QKEENKGGEDKLKMI' => 299,'FEISKKEMQPTHPIR' => 154,'TLNEESYKDSTLIMQ' => 206,'FYYKMKGDYHRYLAE' => 351,'LDKHLIPAANTGESK' => 335,'EQKEENKGGEDKLKM' => 298,'LLDKYLIPNATQPES' => 101,'LAKAAFDDAIAELDT' => 415,'VAYKNVIGARRASWR' => 278,'ESMKKVAGMDVELTV' => 256,'VSNSQQAYQEAFEIS' => 143,'SVFYYEILNSPDRAC' => 399,'FYYEILNSPDRACRL' => 401,'KHLIPAANTGESKVF' => 337,'NSPDRACRLAKAAFD' => 407,'QAKLAEQAERYDEMV' => 241,'PPTHPIRLGLALNFS' => 395,'PNATQPESKVFYLKM' => 108,'DSTLIMQLLRDNLTL' => 214,'ETELKLICCDILDVL' => 321,'EKIEAELQDICNDVL' => 85,'EQGHELSNEERNLLS' => 32,'MDVELTVEERNLLSV' => 264,'TQPESKVFYLKMKGD' => 111,'QAERYDDMAAAMKAV' => 16,'ISKKEMQPTHPIRLG' => 156,'IMQLLRDNLTLWTSD' => 432,'KMIREYRQMVETELK' => 311,'ERNLLSVAYKNVVGA' => 41,'NLTLWTSDMQGDGEE' => 439,'EKACSLAKTAFDEAI' => 187,'SPDRACRLAKAAFDD' => 408,'LQDICNDVLELLDKY' => 91,'EDLVYQAKLAEQAER' => 236,'LIMQLLRDNLTLWTS' => 217,'SEVASGDNKQTTVSN' => 131,'NVVGARRSSWRVISS' => 51,'NLTLWTSENQGDEGD' => 225,'ISSIEQKEENKGGED' => 294,'VISSIEQKTERNEKK' => 62,'KVFYLKMKGDYFRYL' => 116,'KNVVGARRSSWRVIS' => 50,'KEYREKIEAELQDIC' => 81,'KKQQMGKEYREKIEA' => 75,'LVYQAKLAEQAERYD' => 238,'ASWRIISSIEQKEEN' => 289,'VESMKKVAGMDVELT' => 255,'KQTTVSNSQQAYQEA' => 139,'YDEMVESMKKVAGMD' => 251,'DTLSEESYKDSTLIM' => 428,'EQAERYDDMAAAMKA' => 15,'GESKVFYYKMKGDYH' => 346,'GDGEEQNKEALQDVE' => 449,'LAEFATGNDRKEAAE' => 363,'VFYLKMKGDYFRYLS' => 117,'RDNLTLWTSENQGDE' => 223,'NKQTTVSNSQQAYQE' => 138,'DLVYQAKLAEQAERY' => 237,'LLRDNLTLWTSDMQG' => 435,'ENSLVAYKAASDIAM' => 377,'YRQMVETELKLICCD' => 316,'LRDNLTLWTSENQGD' => 222,'ASDIAMTELPPTHPI' => 386,'LDTLSEESYKDSTLI' => 427,'QQMGKEYREKIEAEL' => 77,'NVIGARRASWRIISS' => 282,'EAIAELDTLNEESYK' => 199,'DEAIAELDTLNEESY' => 198,'NDRKEAAENSLVAYK' => 370,'MKGDYHRYLAEFATG' => 355,'IPAANTGESKVFYYK' => 340,'DILDVLDKHLIPAAN' => 330,'NTGESKVFYYKMKGD' => 344,'RIISSIEQKEENKGG' => 292,'THPIRLGLALNFSVF' => 164,'FDEAIAELDTLNEES' => 197,'ALNFSVFYYEILNSP' => 172,'SENQGDEGDAGEGEN' => 231,'LTLWTSENQGDEGDA' => 226,'WRIISSIEQKEENKG' => 291,'SSIEQKTERNEKKQQ' => 64,'RLGLALNFSVFYYEI' => 168,'EQNKEALQDVEDENQ' => 453,'YQEAFEISKKEMQPT' => 150,'AENSLVAYKAASDIA' => 376,'AEQAERYDDMAAAMK' => 14,'DVLDKHLIPAANTGE' => 333,'EYRQMVETELKLICC' => 315,'KACSLAKTAFDEAIA' => 188,'RNEKKQQMGKEYREK' => 72,'IREYRQMVETELKLI' => 313,'ILNSPEKACSLAKTA' => 182,'LAKTAFDEAIAELDT' => 192,'AELDTLSEESYKDST' => 425,'VLELLDKYLIPNATQ' => 98,'FRYLSEVASGDNKQT' => 127,'DICNDVLELLDKYLI' => 93,'AAAMKAVTEQGHELS' => 24,'EFATGNDRKEAAENS' => 365,'RRSSWRVISSIEQKT' => 56,'QMVETELKLICCDIL' => 318,'KSELVQKAKLAEQAE' => 4,'PDRACRLAKAAFDDA' => 409,'IEQKTERNEKKQQMG' => 66,'AEFATGNDRKEAAEN' => 364,'NEKKQQMGKEYREKI' => 73,'AELQDICNDVLELLD' => 89,'MVETELKLICCDILD' => 319,'PIRLGLALNFSVFYY' => 166};
	my $nmer_cat = [{'0' => [0]},{'0' => [1]},{'0' => [2]},{'0' => [3]},{'0' => [4]},{'0' => [5]},{'0' => [6]},{'0' => [7]},{'0' => [8]},{'0' => [9]},{'0' => [10]},{'0' => [11]},{'0' => [12]},{'0' => [13]},{'0' => [14]},{'0' => [15]},{'0' => [16]},{'0' => [17]},{'0' => [18]},{'0' => [19]},{'0' => [20]},{'0' => [21]},{'0' => [22]},{'0' => [23]},{'0' => [24]},{'0' => [25]},{'0' => [26]},{'0' => [27]},{'0' => [28]},{'0' => [29]},{'0' => [30]},{'0' => [31]},{'0' => [32]},{'0' => [33]},{'0' => [34]},{'0' => [35]},{'0' => [36]},{'0' => [37]},{'0' => [38]},{'0' => [39]},{'0' => [40]},{'0' => [41]},{'0' => [42]},{'0' => [43]},{'0' => [44]},{'0' => [45]},{'0' => [46]},{'0' => [47]},{'0' => [48]},{'0' => [49]},{'0' => [50]},{'0' => [51]},{'0' => [52]},{'0' => [53]},{'0' => [54]},{'0' => [55]},{'0' => [56]},{'0' => [57]},{'0' => [58]},{'0' => [59]},{'0' => [60]},{'0' => [61]},{'0' => [62]},{'0' => [63]},{'0' => [64]},{'0' => [65]},{'0' => [66]},{'0' => [67]},{'0' => [68]},{'0' => [69]},{'0' => [70]},{'0' => [71]},{'0' => [72]},{'0' => [73]},{'0' => [74]},{'0' => [75]},{'0' => [76]},{'0' => [77]},{'0' => [78]},{'0' => [79]},{'0' => [80]},{'0' => [81]},{'0' => [82]},{'0' => [83]},{'0' => [84]},{'0' => [85]},{'0' => [86]},{'0' => [87]},{'0' => [88]},{'0' => [89]},{'0' => [90]},{'0' => [91]},{'0' => [92]},{'0' => [93]},{'0' => [94]},{'0' => [95]},{'0' => [96]},{'0' => [97]},{'0' => [98]},{'0' => [99]},{'0' => [100]},{'0' => [101]},{'0' => [102]},{'0' => [103]},{'0' => [104]},{'0' => [105]},{'0' => [106]},{'0' => [107]},{'0' => [108]},{'0' => [109]},{'0' => [110]},{'0' => [111]},{'0' => [112]},{'0' => [113]},{'0' => [114]},{'0' => [115]},{'0' => [116]},{'0' => [117]},{'0' => [118]},{'0' => [119]},{'0' => [120]},{'0' => [121]},{'0' => [122]},{'0' => [123]},{'0' => [124]},{'0' => [125]},{'0' => [126]},{'0' => [127]},{'0' => [128]},{'0' => [129]},{'0' => [130]},{'0' => [131]},{'0' => [132]},{'0' => [133]},{'0' => [134]},{'0' => [135]},{'0' => [136]},{'0' => [137]},{'0' => [138]},{'0' => [139]},{'0' => [140]},{'0' => [141]},{'0' => [142]},{'0' => [143]},{'0' => [144]},{'0' => [145]},{'0' => [146]},{'0' => [147]},{'0' => [148]},{'0' => [149]},{'0' => [150]},{'0' => [151]},{'0' => [152]},{'0' => [153]},{'0' => [154]},{'0' => [155]},{'0' => [156]},{'0' => [157]},{'0' => [158]},{'0' => [159]},{'0' => [160]},{'0' => [161]},{'0' => [162]},{'0' => [163],'1' => [164]},{'1' => [165],'0' => [164]},{'0' => [165],'1' => [166]},{'0' => [166],'1' => [167]},{'0' => [167],'1' => [168]},{'1' => [169],'0' => [168]},{'1' => [170],'0' => [169]},{'0' => [170],'1' => [171]},{'0' => [171],'1' => [172]},{'1' => [173],'0' => [172]},{'0' => [173]},{'0' => [174]},{'0' => [175]},{'0' => [176]},{'0' => [177]},{'0' => [178]},{'0' => [179]},{'0' => [180]},{'0' => [181]},{'0' => [182]},{'0' => [183]},{'0' => [184]},{'0' => [185]},{'0' => [186]},{'0' => [187]},{'0' => [188]},{'0' => [189]},{'0' => [190]},{'0' => [191]},{'0' => [192]},{'0' => [193]},{'0' => [194]},{'0' => [195]},{'0' => [196]},{'0' => [197]},{'0' => [198]},{'0' => [199]},{'0' => [200]},{'0' => [201]},{'0' => [202]},{'0' => [203]},{'0' => [204]},{'0' => [205]},{'0' => [206]},{'0' => [207]},{'0' => [208]},{'1' => [210],'0' => [209]},{'1' => [211],'0' => [210]},{'1' => [212],'0' => [211]},{'1' => [213],'0' => [212]},{'0' => [213],'1' => [214]},{'0' => [214],'1' => [215]},{'0' => [215],'1' => [216]},{'0' => [216],'1' => [217]},{'0' => [217],'1' => [218]},{'0' => [218]},{'0' => [219]},{'0' => [220]},{'0' => [221]},{'0' => [222]},{'0' => [223]},{'0' => [224]},{'0' => [225]},{'0' => [226]},{'0' => [227]},{'0' => [228]},{'0' => [229]},{'0' => [230]},{'0' => [231]},{'1' => [0]},{'1' => [1]},{'1' => [2]},{'1' => [3]},{'1' => [4]},{'1' => [5]},{'1' => [6]},{'1' => [7]},{'1' => [8]},{'1' => [9]},{'1' => [10]},{'1' => [11]},{'1' => [12]},{'1' => [13]},{'1' => [14]},{'1' => [15]},{'1' => [16]},{'1' => [17]},{'1' => [18]},{'1' => [19]},{'1' => [20]},{'1' => [21]},{'1' => [22]},{'1' => [23]},{'1' => [24]},{'1' => [25]},{'1' => [26]},{'1' => [27]},{'1' => [28]},{'1' => [29]},{'1' => [30]},{'1' => [31]},{'1' => [32]},{'1' => [33]},{'1' => [34]},{'1' => [35]},{'1' => [36]},{'1' => [37]},{'1' => [38]},{'1' => [39]},{'1' => [40]},{'1' => [41]},{'1' => [42]},{'1' => [43]},{'1' => [44]},{'1' => [45]},{'1' => [46]},{'1' => [47]},{'1' => [48]},{'1' => [49]},{'1' => [50]},{'1' => [51]},{'1' => [52]},{'1' => [53]},{'1' => [54]},{'1' => [55]},{'1' => [56]},{'1' => [57]},{'1' => [58]},{'1' => [59]},{'1' => [60]},{'1' => [61]},{'1' => [62]},{'1' => [63]},{'1' => [64]},{'1' => [65]},{'1' => [66]},{'1' => [67]},{'1' => [68]},{'1' => [69]},{'1' => [70]},{'1' => [71]},{'1' => [72]},{'1' => [73]},{'1' => [74]},{'1' => [75]},{'1' => [76]},{'1' => [77]},{'1' => [78]},{'1' => [79]},{'1' => [80]},{'1' => [81]},{'1' => [82]},{'1' => [83]},{'1' => [84]},{'1' => [85]},{'1' => [86]},{'1' => [87]},{'1' => [88]},{'1' => [89]},{'1' => [90]},{'1' => [91]},{'1' => [92]},{'1' => [93]},{'1' => [94]},{'1' => [95]},{'1' => [96]},{'1' => [97]},{'1' => [98]},{'1' => [99]},{'1' => [100]},{'1' => [101]},{'1' => [102]},{'1' => [103]},{'1' => [104]},{'1' => [105]},{'1' => [106]},{'1' => [107]},{'1' => [108]},{'1' => [109]},{'1' => [110]},{'1' => [111]},{'1' => [112]},{'1' => [113]},{'1' => [114]},{'1' => [115]},{'1' => [116]},{'1' => [117]},{'1' => [118]},{'1' => [119]},{'1' => [120]},{'1' => [121]},{'1' => [122]},{'1' => [123]},{'1' => [124]},{'1' => [125]},{'1' => [126]},{'1' => [127]},{'1' => [128]},{'1' => [129]},{'1' => [130]},{'1' => [131]},{'1' => [132]},{'1' => [133]},{'1' => [134]},{'1' => [135]},{'1' => [136]},{'1' => [137]},{'1' => [138]},{'1' => [139]},{'1' => [140]},{'1' => [141]},{'1' => [142]},{'1' => [143]},{'1' => [144]},{'1' => [145]},{'1' => [146]},{'1' => [147]},{'1' => [148]},{'1' => [149]},{'1' => [150]},{'1' => [151]},{'1' => [152]},{'1' => [153]},{'1' => [154]},{'1' => [155]},{'1' => [156]},{'1' => [157]},{'1' => [158]},{'1' => [159]},{'1' => [160]},{'1' => [161]},{'1' => [162]},{'1' => [163]},{'1' => [174]},{'1' => [175]},{'1' => [176]},{'1' => [177]},{'1' => [178]},{'1' => [179]},{'1' => [180]},{'1' => [181]},{'1' => [182]},{'1' => [183]},{'1' => [184]},{'1' => [185]},{'1' => [186]},{'1' => [187]},{'1' => [188]},{'1' => [189]},{'1' => [190]},{'1' => [191]},{'1' => [192]},{'1' => [193]},{'1' => [194]},{'1' => [195]},{'1' => [196]},{'1' => [197]},{'1' => [198]},{'1' => [199]},{'1' => [200]},{'1' => [201]},{'1' => [202]},{'1' => [203]},{'1' => [204]},{'1' => [205]},{'1' => [206]},{'1' => [207]},{'1' => [208]},{'1' => [209]},{'1' => [219]},{'1' => [220]},{'1' => [221]},{'1' => [222]},{'1' => [223]},{'1' => [224]},{'1' => [225]},{'1' => [226]},{'1' => [227]},{'1' => [228]},{'1' => [229]},{'1' => [230]},{'1' => [231]},{'1' => [232]},{'1' => [233]},{'1' => [234]},{'1' => [235]},{'1' => [236]},{'1' => [237]},{'1' => [238]},{'1' => [239]},{'1' => [240]}];
	my $seq_names_cat = ['sp|P31946|1433B_HUMAN','sp|P62258|1433E_HUMAN'];
	my $cat_info = {'catalog_name' => 'catalogs/test1','data_source' => '/Users/jgbaum/projects/nmer-match/t/test_db.fasta','num_nmers' => 455,'peptide_length' => 15};

	my $expected_results = {
		catalog_seq_ref => $cat_seq_ref,
		unique_nmer_id  => $unique_nmer,
		nmer_catalog    => $nmer_cat,
		seq_names_catalog => $seq_names_cat,
		catalog_info      => $cat_info,
	};

	return $expected_results;

};
