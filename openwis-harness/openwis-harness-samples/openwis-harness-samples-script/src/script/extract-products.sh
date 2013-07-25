#!/bin/sh
echo "=== Extracting Products ==="

# Retrieve arguments
EXTRACT_ID=$1
URN=$2
PARAMETERS=$3
STAGING_URI=$4

echo "[$EXTRACT_ID] Extract product with URN $URN and parameters '$PARAMETERS' to $STAGING_URI"

# Initialize monitoring file
mkdir -p $STAGING_URI
MONITOR_FILE=${STAGING_URI}/extraction${EXTRACT_ID}.tmp
echo "Using montior file: $MONITOR_FILE"
touch $MONITOR_FILE

# Write some dummy products into the staging uri
PRODUCTS=("X_FVXX04EGRR031204_C_20110117120400" "X_FVXX04EGRR031204_C_20110219150600")

for ((i=0; i<${#PRODUCTS[@]}; i++)); do
	OUTPUT_FILE=${STAGING_URI}/${PRODUCTS[${i}]}
	# Create product file
	touch  $OUTPUT_FILE
	# Update monitoring file
	echo ${PRODUCTS[${i}]} >> $MONITOR_FILE
	# Create dummy content
	echo "FVXX01 EGRR 061105\nVA ADVISORY\nDTG: 20100506/1200Z\nVAAC: LONDON\nVOLCANO: EYJAFJALLAJOKULL 1702-02\nPSN: N6338 W01937\nAREA: ICELAND\nSUMMIT ELEV: 1666M\nADVISORY NR: 2010/086\nINFO SOURCE: ICELAND MET OFFICE\nAVIATION COLOUR CODE: RED\nERUPTION DETAILS: PLUME CONTINUES TO FLUCTUATE WITH MAX ERUPTION\nHEIGHT TO APPROX. FL300\nOBS VA DTG: 06/1200Z\nOBS VA CLD: SFC/FL200 N6348 W02017 - N6346 W01633 - N6407 W01254 -\nN5950 W01259 - N5616 W01202 - N5105 W01143 - N5214 W00716 - N5413\nW00406 - N5044 W00444 - N4835 W00425 - N4516 W00726 - N4029 W01235 -\nN4203 W01910 - N4636 W02429 - N5359 W02855 - N5754 W02836 - N5652\nW02637 - N5117 W02317 - N4626 W01905 - N4432 W01415 - N4741 W01114 -\nN4829 W01512 - N5020 W01701 - N5425 W01725 - N5511 W01846 - N5752\nW01730 - N6157 W01808 - N6323 W02055 - N6348 W02017 FL200/FL350 N6343\nW02014 - N6341 W01541 - N6302 W01334 - N5408 W01321 - N5125 W01459 -\nN5131 W01555 - N5534 W01731 - N5844 W01718 - N6210 W01726 - N6319\nW02039 - N6343 W02014\nFCST VA CLD +6HR: 06/1800Z SFC/FL200 N6341 W02020 - N6356 W01518 -\nN6501 W01150 - N6451 W01001 - N5915 W00956 - N5720 W01315 - N4916\nW01310 - N4825 W00914 - N5111 W00758 - N5230 W00541 - N5005 W00555 -\nN4623 W00435 - N4152 W00947 - N3909 W01145 - N3916 W01329 - N4353\nW02159 - N5134 W02856 - N5658 W03200 - N5946 W02943 - N6001 W02818 -\nN5640 W02716 - N5123 W02435 - N4524 W01938 - N4315 W01504 - N4547\nW01208 - N4544 W01600 - N4816 W01914 - N5017 W02020 - N5235 W02020 -\nN5431 W02223 - N5637 W01933 - N5751 W01923 - N6013 W01610 - N6110\nW01716 - N6250 W02020 - N6341 W02020 FL200/FL350 N6351 W02005 - N6351\nW01637 - N6228 W01143 - N6046 W00936 - N5816 W00952 - N5722 W01210 -\nN5535 W01441 - N5217 W01456 - N4929 W01602 - N4904 W01715 - N5029\nW01856 - N5458 W02005 - N5650 W01829 - N5834 W01606 - N6116 W01610 -\nN6259 W02017 - N6351 W02005\nFCST VA CLD +12HR: 07/0000Z SFC/FL200 N6351 W01951 - N6343 W01730 -\nN6302 W01441 - N6442 W01220 - N6549 W00940 - N6422 W00801 - N6101\nW00853 - N5607 W00926 - N5408 W01128 - N5327 W01316 - N5338 W01431 -\nN4711 W01455 - N4617 W01344 - N4617 W00839 - N4802 W00931 - N4923\nW00926 - N4859 W00540 - N4544 W00458 - N4357 W00733 - N3754 W01100 -\nN3750 W01340 - N4028 W01605 - N4135 W01436 - N4259 W01147 - N4343\nW01344 - N4401 W01556 - N4604 W01937 - N4843 W02158 - N4511 W02226 -\nN4859 W02722 - N5302 W02943 - N4954 W02304 - N5244 W02337 - N5511\nW03058 - N5814 W03416 - N6045 W03401 - N6117 W03030 - N6026 W02755 -\nN5911 W02929 - N5559 W02842 - N5617 W02139 - N5913 W01547 - N6300\nW02047 - N6351 W01951 FL200/FL350 N6402 W02005 - N6301 W01412 - N6038\nW00945 - N5735 W00904 - N5427 W01035 - N5326 W01326 - N5256 W01552 -\nN4914 W01915 - N4940 W02149 - N5312 W02207 - N5537 W02059 - N5631\nW01802 - N5858 W01610 - N6255 W02023 - N6402 W02005\nFCST VA CLD +18HR: 07/0600Z SFC/FL200 N6422 W01856 - N6215 W01204 -\nN6520 W00928 - N6535 W00459 - N6138 W00653 - N5453 W01104 - N5017\nW01416 - N5025 W01808 - N4820 W01802 - N4411 W00823 - N3838 W00922 -\nN3751 W01228 - N4002 W01404 - N4332 W01216 - N4453 W01533 - N4958\nW02507 - N5457 W02749 - N5514 W03112 - N5707 W03054 - N5752 W02725 -\nN5651 W02449 - N5615 W02314 - N5601 W01820 - N5737 W01457 - N6008\nW01521 - N6331 W02014 - N6422 W01856 FL200/FL350 N6429 W01932 - N6303\nW01443 - N6000 W01107 - N5423 W01113 - N5020 W01443 - N5016 W02255 -\nN5243 W02503 - N5459 W02235 - N5502 W01516 - N6007 W01456 - N6349\nW02040 - N6429 W01932\nRMK:\nNXT ADVISORY: 20100506/1800Z=" >> $OUTPUT_FILE
	sleep 2
done

# Update the monitor file
MONITOR_FILE_OK=${STAGING_URI}/extraction${EXTRACT_ID}.ok
mv ${MONITOR_FILE} ${MONITOR_FILE_OK}

echo "Extraction complete see: $MONITOR_FILE_OK"