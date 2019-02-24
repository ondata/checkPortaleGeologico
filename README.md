<!-- TOC -->

- [La maggior parte dei dati della sezione "Utilizza i dati" del Portale del Servizio Geologico d'Italia non sono dati aperti](#la-maggior-parte-dei-dati-della-sezione-utilizza-i-dati-del-portale-del-servizio-geologico-ditalia-non-sono-dati-aperti)
- [Dove sono pubblicate le informazioni sulle licenze](#dove-sono-pubblicate-le-informazioni-sulle-licenze)
- [I dati raccolti](#i-dati-raccolti)
- [Il quadro generale](#il-quadro-generale)
- [Note conclusive](#note-conclusive)

<!-- /TOC -->

# La maggior parte dei dati della sezione "Utilizza i dati" del Portale del Servizio Geologico d'Italia non sono dati aperti

Il 18 febbraio 2019 è stato presentato il **nuovo** [**Portale del Servizio Geologico d'Italia**](http://www.isprambiente.gov.it/it/events/il-portale-del-servizio-geologico-ditalia-dati-a-servizio-del-professionista)

I dati geografici sono da sempre tra i dati di maggiore interesse, a maggior forza quelli di questo contesto. Abbiamo voluto allora verificare se fossero **dati aperti**, se fossero pienamente **riutilizzabili**. Abbiamo creato uno [script](./check.sh) per verificare automaticamente quali siano le licenze in essere nella sezione denominata "[Utilizza i dati](http://portalesgi.isprambiente.it/it/categorie-servizi-wms)".

Emerge che **alla gran parte delle risorse non è associata una licenza aperta**, in quanto non è consentito l'uso commerciale.

✋✋ Chiedi anche tu [**con un tweet**](https://twitter.com/intent/tweet?text=Voglio%20una%20licenza%20che%20consenta%20anche%20il%20riuso%20commerciale%2C%20per%20i%20dati%20del%20Portale%20del%20Servizio%20Geologico%20d%27Italia.%20Voglio%20una%20licenza%20aperta%20%40ISPRA_Press%20%40AgidGov%20%40minambienteIT%20%40SergioCosta_min%20%40teamdigitaleIT) di rilasciare questi dati con un licenza che ne **consenta** il **riuso** **commerciale**.

# Dove sono pubblicate le informazioni sulle licenze

La licenza generale del sito (è a fondo pagina) è una [CC BY-NC-SA 3.0 IT](https://creativecommons.org/licenses/by-nc-sa/3.0/it/), una licenza **non aperta**. Quella di cui tenere conto non è questa, ma quella associata alle singole risorse.

La [sezione](http://portalesgi.isprambiente.it/it/categorie-servizi-wms) di sopra è suddivisa in **14 temi** ([questi](./data/urlBase.txt) gli URL), al cui interno sono elencati **182 servizi/risorse** ([questi](./data/tmp_urlWMS.txt) gli URL, da cui sono stati rimossi quelli IFFI perché non raggiungibili). Sono pubblicati come `Web Map Service`, quindi (semplificando un po') esposti come pixel. **I dati su cui abbiamo costruito questo report, sono questi 182**.

Accedendo in questa modalità, la licenza è da leggere nella risposta `XML` fornita dai vari servizi, in particolare quella alla chiamata `GetCapabilities`, in cui è presente il tag `<AccessConstraints>`. Ad esempio il servizio sui [limiti amministrativi](http://sgi2.isprambiente.it/arcgis/services/servizi/limiti_amministrativi/MapServer/WmsServer?Request=GetCapabilities&service=WMS), risponde con questa stringa:

```xml
<AccessConstraints><![CDATA[Licenza d'uso CC-BY-NC]]></AccessConstraints>
```

Su questo servizio vogliamo aprire una piccola parentesi, perché probabilmente c'è da fare una verifica. La licenza qui è infatti una CC-BY-NC, ma il dato che fa da sorgente (la fonte è ISTAT) non è con licenza NC. Quindi probabilmente c'è piccolo errore.

# I dati raccolti

Alcune delle 182 risorse **non consentono la lettura automatica delle licenza** associata, perché i loro URL non forniscono una risposta `GetCapabilities` (o perché l'URL indicato nel sito non è quello esatto, o perché il servizio non è funzionante). In particolare si tratta di [questi 10](./report/URLproblematici.txt).<br>
Questi URL problematici hanno un impatto su **16** delle 182 risorse (perché a un singolo URL può essere associata più di una risorsa): è stato quindi possibile raccogliere in modo automatico informazioni sulle licenze di **166 risorse** su 182 (circa il 90%).

[Qui](./report/reportLicenzeRisorse.csv) i dati raccolti.

# Il quadro generale

Dai dati raccolti emerge questa **sintesi**:

| Licenza Open Data | Numero |
| --- | --- |
| NO | 130 |
| ND | 31 |
| SÌ | 5 |

Quindi **130 risorse su 166** (circa l'80%) **non sono dati aperti**. Il valore `ND` (Non Determinabile) è stato usato laddove non è stato possibile associare una licenza a una risorsa, perché non documentata nella risposta alla richiesta `GetCapabilities`.<br>

A seguire le varie tipologie di licenza. Sono per la gran parte - scritte in forma diversa - quasi tutte licenze **Non Commerciali** (NC), non utilizzabili per fini commerciali. Non sono quindi licenze aperte, perché queste devono consentire il riuso anche per questi fini.

| licenza | Numero |
| --- | --- |
| ND | 31 |
| I dati pubblicati dal Servizio Geologico d'Italia sono liberi nella consultazione e visualizzazione. L'uso delle informazioni  nel rispetto della proprieta' intelletuale e della corretta scala di applicazione del dato. ISPRA non garantisce sulla qualita',la completezza e l'accuratezza  dei dati non prodotti direttamente dalla stessa. L'uso dei dati per altri fini che non siano la semplice visualizzazione e' soggetto alla legge e deve esserne richiesto l'uso al Servizio Geologico d'Italia. | 24 |
| CC-BY-NC | 18 |
| Ogni iniziativa di divulgazione delle informazioni contenute nel dataset o da esso derivate (cartogrammi, relazioni, servizi informativi), dovrà sempre citare la fonte del dato originale (autori, proprietario). La visualizzazione è libera, mentre l'uso del dato è soggetto ai riferimenti della proprietà ed ai diritti d' autore. Licenza d'uso: CC-BY-NC | 14 |
| I dati pubblicati dal Servizio Geologico d'Italia sono liberi nella consultazione e visualizzazione. L'uso delle informazioni nel rispetto della proprieta' intelletuale e della corretta scala di applicazione del dato. ISPRA non garantisce sulla qualita',la completezza e l'accuratezza dei dati non prodotti direttamente dalla stessa. L'uso dei dati per altri fini che non siano la semplice visualizzazione e' soggetto alla legge e deve esserne richiesto l'uso al Servizio Geologico d'Italia.Licenza CC-BY-NC | 13 |
| L'uso dei dati è consentito per la visualizzazione e consultazione. ISPRA avverte l'uso dei dati è correlato alla correttezza intellettuale del dato in relazione a qualità, correttezza e completezza dei dati, pertanto qualunque uso inproprio non può essere responsabilità del Servizio Geologico d'Italia e sarà perseguito secondo i termini di legge vigente sul territorio italiano. Licenza CC-BY-NC. | 10 |
| Licenza d'uso CC-BY-NC | 8 |
| L'uso dei dati è consentito per la visualizzazione e consultazione. ISPRA avverte l'uso dei dati è correlato alla correttezza intellettuale del dato in relazione a qualità, correttezza e completezza dei dati, pertanto qualunque uso inproprio non può essere responsabilità del Servizio Geologico d'Italia e sarà perseguito secondo i termini di legge vigente sul territorio italiano. Licenza d'uso CC-BY-NC | 7 |
| I dati pubblicati dal Servizio Geologico d'Italia sono liberi nella consultazione e visualizzazione. L'uso delle informazioni e' nel rispetto della proprieta' intelletuale e della corretta scala di applicazione del dato. ISPRA non garantisce sulla qualita', la completezza e l'accuratezza dei dati non prodotti direttamente dalla stessa. L'uso dei dati per altri fini che non siano la semplice visualizzazione e' soggetto alla legge e deve esserne richiesto l'uso al Servizio Geologico d'Italia.Licenza CC-BY-NC | 6 |
| I dati pubblicati dal Servizio Geologico d'Italia sono liberi nella consultazione e visualizzazione. L'uso delle informazioni e' nel rispetto della proprieta' intelletuale e della corretta scala di applicazione del dato. ISPRA non garantisce sulla qualita', la completezza e l'accuratezza dei dati non prodotti direttamente dalla stessa. L'uso dei dati per altri fini che non siano la semplice visualizzazione e' soggetto alla legge e deve esserne richiesto l'uso al Servizio Geologico d'Italia. Licenza d'uso CC-BY-NC | 6 |
| La visualizzazione è libera, mentre l'uso del dato è soggetto ai riferimenti della proprietà ed ai diritti d'autore. Licenza d'uso CC-BY-NC | 5 |
| I dati pubblicati dal Servizio Geologico d'Italia sono liberi nella consultazione e visualizzazione. L'uso delle informazioni e' nel rispetto della proprieta' intelletuale e della corretta scala di applicazione del dato. ISPRA non garantisce sulla qualita',la completezza e l'accuratezza dei dati non prodotti direttamente dalla stessa. L'uso dei dati per altri fini che non siano la semplice visualizzazione e' soggetto alla legge e deve esserne richiesto l'uso al Servizio Geologico d'Italia. Licenza d'uso CC-BY-NC | 5 |
| I dati pubblicati dal Servizio Geologico d'Italia sono liberi nella consultazione e visualizzazione. L'uso delle informazioni nel rispetto della proprieta' intelletuale e della corretta scala di applicazione del dato. ISPRA non garantisce sulla qualita',la completezza e l'accuratezza dei dati non prodotti direttamente dalla stessa. L'uso dei dati per altri fini che non siano la semplice visualizzazione e' soggetto alla legge e deve esserne richiesto l'uso al Servizio Geologico d'Italia.Licenza d'uso CC-BY-NC | 5 |
| I dati pubblicati dal Servizio Geologico d'Italia sono liberi nella consultazione e visualizzazione. L'uso delle informazioni e' nel rispetto della proprieta' intelletuale e della corretta scala di applicazione del dato. ISPRA non garantisce sulla qualita', la completezza e l'accuratezza dei dati non prodotti direttamente dalla stessa. L'uso dei dati per altri fini che non siano la semplice visualizzazione e' soggetto alla legge e deve esserne richiesto l'uso al Servizio Geologico d'Italia. Licenza CC-BY-NC | 4 |
| Licenza Attribuzione 3.0 Italia (CC BY SA 3.0 IT) | 4 |
| I dati pubblicati dal Servizio Geologico d'Italia sono liberi nella consultazione e visualizzazione. L'uso delle informazioni  nel rispetto della proprieta' intelletuale e della corretta scala di applicazione del dato. ISPRA non garantisce sulla qualita',la completezza e l'accuratezza  dei dati non prodotti direttamente dalla stessa. L'uso dei dati per altri fini che non siano la semplice visualizzazione e' soggetto alla legge e deve esserne richiesto l'uso al Servizio Geologico d'Italia | 2 |
| The Geologic data of Italy is available only for visualization. Your use of any information provided by the Geological Survey of Italy (ISPRA) is at your own risk. Neither ISPRA gives any warranty, condition or representation as to the quality, accuracy or completeness of the information or its suitability for any use or purpose. All implied conditions relating to the quality or suitability of the information, and all liabilities arising from the supply of the information (including any liability arising in negligence) are excluded to the fullest extent permitted by law. Licenza CC-BY-NC. | 2 |
| I dati pubblicati dal Servizio Geologico d'Italia sono liberi nella consultazione e visualizzazione. L'uso delle informazioni nel rispetto della proprieta' intelletuale e della corretta scala di applicazione del dato. ISPRA non garantisce sulla qualita',la completezza e l'accuratezza dei dati non prodotti direttamente dalla stessa. L'uso dei dati per altri fini che non siano la semplice visualizzazione e' soggetto alla legge e deve esserne richiesto l'uso al Servizio Geologico d'Italia. Licenza d'uso CC-BY-NC | 1 |
| http://webgis.arpa.piemonte.it/w-metadoc/_Licenze/Licenza_map_service.pdf | 1 |

# Note conclusive

Dati e servizi di questa natura sono di **grande valore** e **interesse**, ricadono tra i cosiddetti "**dati pubblici**", quindi andrebbero pubblicati con **licenze aperte**, che ne consentano il **pieno riuso**. È una conclusione di buon senso, per la quale crediamo non sia necessario citare il Codice Amministrazione Digitale (CAD) e le norme sul riutilizzo di documenti nel settore pubblico.

Il portale non è sempre fonte primaria del dato, quindi non è responsabile sempre della scelta sulle licenze. Ma il suo essere un indice di risorse ci ha consentito di riuscire a creare rapidamente questo _report_ di riepilogo.

Chiediamo ai responsabili delle varie risorse di **scegliere** per queste (laddove nulla osta) una **licenza aperta**. E se vuoi unirti, [✋✋ **fallo con un tweet**](https://twitter.com/intent/tweet?text=Voglio%20una%20licenza%20che%20consenta%20anche%20il%20riuso%20commerciale%2C%20per%20i%20dati%20del%20Portale%20del%20Servizio%20Geologico%20d%27Italia.%20Voglio%20una%20licenza%20aperta%20%40ISPRA_Press%20%40AgidGov%20%40minambienteIT%20%40SergioCosta_min%20%40teamdigitaleIT).