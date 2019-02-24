#!/bin/bash

### requirements ###
# scrape-cli https://github.com/aborruso/scrape-cli/releases
# yq https://github.com/kislyuk/yq
# mlr http://johnkerl.org/miller/doc/
### requirements ###

set -x

rm ./data/*
rm ./report/*

# scarica gli URL di base
curl "http://portalesgi.isprambiente.it/it/categorie-servizi-wms" | scrape -be '//div[@class="block block-system block-system-main-block"]//a' | \
xq -r '.html.body.a[]|{url:("http://portalesgi.isprambiente.it"+.["@href"])}|.url' | sed 's/ /%20/g' >./data/urlBase.txt

# scarica gli URL delle sorgenti WMS
while read p; do
  curl "$p" | scrape -be '//a[contains(text(),"Get Cap")]' | xq -r '.html.body.a[]["@href"]' >>./data/urlWMS_RAW.txt
done <./data/urlBase.txt

# rimuovi IFFI perché momentaneamente non funzionante
<./data/urlWMS_RAW.txt grep -v "IFFI" >./data/tmp_urlWMS.txt

# correggi URL WMS con doppio ?? nell'URL
sed -i -r 's/\?\?/\?/g' ./data/tmp_urlWMS.txt

# rimuovi URL WMS duplicati
<./data/tmp_urlWMS.txt sort | uniq >./data/urlWMS.txt

# estrai dati su licenza
while read p; do
  curl "$p" | xq '.|{url:"'"$p"'",license:.WMS_Capabilities.Service.AccessConstraints?,title:.WMS_Capabilities.Service.Title?}' >>./data/fee.json
done <./data/urlWMS.txt

# crea csv dei dati sulle licenze
<./data/fee.json jq -s . | mlr --j2c cat >./data/fee.csv


# aggiungi riga di intestazione agli URL WMS
mlr --n2c label url ./data/urlWMS.txt >./data/urlWMS.csv

# fai il join tra gli URL WMS e i dati sulle licenze
mlr --csv join --ul -j url -f ./data/urlWMS.csv then unsparsify --fill-with "NoGetCapabilitiesReply" ./data/fee.csv >./data/report.csv

# assegna licenze
mlr -I --csv put -S 'if ($license =~ "-NC" || $license =~ "intelletuale") {$OD = "NO"} else {$OD=""}' ./data/report.csv
mlr -I --csv put -S 'if ($license =~ "CC BY SA 3.0") {$OD = "YES"} else {$OD=$OD}' ./data/report.csv
mlr -I --csv put -S 'if ($license == "" && title =~ ".+") {$OD = "ND"} else {$OD=$OD}' ./data/report.csv
mlr -I --csv put -S 'if ($license =~ "webgis") {$OD = "YES"} else {$OD=$OD}' ./data/report.csv
mlr -I --csv put -S 'if ($license == "NoGetCapabilitiesReply") {$OD = "NoGetCapabilitiesReply"} else {$OD=$OD}' ./data/report.csv
mlr -I --csv put -S 'if ($license == "none") {$OD = "ND"} else {$OD=$OD}' ./data/report.csv
mlr -I --csv put -S 'if ($license == "none") {$license = "ND"} else {$license=$license}' ./data/report.csv
mlr -I --csv put -S 'if ($license == "") {$license = "ND"} else {$license=$license}' ./data/report.csv

# riordina campi
csvsql --query "select OD,title,license,url from report" ./data/report.csv >./data/tmp_report.csv
mv ./data/tmp_report.csv ./data/report.csv
mlr -I --csv sort -f OD,url then uniq -a ./data/report.csv

### report ###

sed -r 's/\?\?/\?/g' ./data/urlWMS_RAW.txt >./data/urlWMS_RAW_clean.txt

cp ./data/report.csv ./report/reportLicenzeURL.csv

# URL problematici
mlr --icsv --onidx --ofs "," filter '$license=="NoGetCapabilitiesReply"' then cut -f url data/report.csv >./report/URLproblematici.txt
<./data/urlWMS_RAW_clean.txt grep "IFFI" >>./report/URLproblematici.txt
mlr -I --nidx uniq -a ./report/URLproblematici.txt

# risorse non verificabili, perché associate a URL problematici
mlr --icsv --implicit-csv-header --onidx join -j 1 -f data/urlWMS_RAW_clean.txt report/URLproblematici.txt >./report/RisorseNonVerificabili.txt

# risorse verificabili
mlr --csv --implicit-csv-header join --np --ul -j 1 -f data/urlWMS_RAW_clean.txt then label url report/URLproblematici.txt >./report/RisorseVerificabili.txt

# report finale licenze delle risorse
mlr --csv join -j url -f ./report/RisorseVerificabili.txt then cut -x -f title ./report/reportLicenzeURL.csv >./report/reportLicenzeRisorse.csv

# riepilogo Open Data
mlr --icsv --omd uniq -c -g OD then sort -nr count then rename "OD,Open Data,count,Numero" ./report/reportLicenzeRisorse.csv >./report/riepilogoOpenData.md

### report ###
<<comment1
comment1