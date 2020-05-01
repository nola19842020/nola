English briefly:

To remove NOLA totally from the computer:
   - With Regedit.exe rename or remove HKEY_CURRENT_USER/Software/Nola -folder
     
=========================================================================================================     

N�m� tiedot on esitetty my�s NOLAssa:
   P��valikko / Ohjeet,Tietoa    v�lilehdill� "Ohjeita, rajoituksia" ja 
                                              "Ohjelman siirt�minen ja poistaminen"

YLEIST�:
- Ohjelman valmistaja ei vastaa ohjelman mahdollisesta virheellisest� toiminnasta tai sen k�yt�st� 
  aiheutuneista virheellisist� suunnitelmista eik� niiden taloudellisista seuraamuksista.

- Ty�skentelyikkunat ovat yleens� muokattavia;   min./max.koko tai portaattomasti tartuntapisteen� 
  ikkunan sivut ja nurkkapisteet.

- Liukulukujen desimaaliosan erottimena voidaan k�ytt�� joko "." tai "," , alkunolla voidaan j�tt�� 
  pois, esim. 0.9 => ,9 tai .9

- Kosketusj�nnitetarkastelut k�dess� pidett�ville laitteille suoritetaan SFS 6000 ja A2 / 413.1.3.3 
  - .5 (TN-j�rjestelm�) mukaan k�ytt�en taulukko 41 A :n poiskytkent�aikarajoja, jonka Uo j�nnite 
  lasketaan annetusta nimellis(p��) j�nnitteest�.   Uo -j�nnitett� m��ritett�ess� ohjelma tulkitsee 
  Uv-10% arvon kynnysarvoksi. Siten esim.  762 V :n p��j�nnitteell� Uo :ksi tulkitaan 762 / V�3 =
  440 =>  Uo = 400 V, jolle poiskytkent�aikavaatimus on 0.2 s.

- Johtojen asennustapojen (A,C,D) kuormitettavuustekij�t ovat A2 / Liite 1 :n mukaisia.

- Kirjalliset k�ytt�ohjeet on korvattu sy�tt�tapahtumakohtaisilla ja hiiren liikkeen mukaan, omaan 
  ikkunaan p�ivittyvill� avusteilla, jotka sis�lt�v�t taustatiedot, laskentamenetelm�kuvaukset, 
  varoitukset tarvittaessa jne. Tapauskohtaisia vertailulaskelmia, v�li- ja apuarvoja, 
  yksityiskohtaista teoriaa yms. on saatavissa mm. Verkonlaskennan "Detaljit" -painikkeen tulosteista. 
  Kaikki avusteet voidaan ottaa ohjelmaosittain kattavina paperitulosteina haluttaessa  k�ytt�ohjeiksi 
  "Tulosta" -painikkeen j�lkeisell� valinnalla  TAI avusteikkunakohtaisesti Ctrl+P :ll�.

- Nousujohtolaskennan hintatiedosto (KaapHinD.NOL) on itse muokattavissa ASCII -muotoisena.   
  Tiedoston Nimi -sarakkeessa ilmaistaan tulostuksessa k�ytett�v� kaapelin nimitys.   Laji- ja 
  johdinlukum��r� (jLkm)-sarakeet ovat varauksia, joiden arvoilla ei toistaiseksi ole merkityst�:   
  nousujohtolaskenta tapahtuu aina MCMK-, AMCMK- kaapeleiden ja/tai SVj�rjestelmien ja edelt�v�n 
  verkon laskenta annettujen johtotyyppien s�hk�isill� arvoilla.

-------------------------------------------------------------------------------------------------------

NOLA - OHJELMAN POISTO KONEESTA:

- Poista NOLA.EXE�n sis�lt�m� hakemisto (alihakemistoineen).
- K�ynnist� (C:)\WINDOWS\REGEDIT.EXE, kaksoisklikkaa HKEY_CURRENT_USET -hakemistokuvaketta ja sen 
  j�lkeen Software -hakemistokuvaketta, mist� poista Nola -hakemisto.
  NOLA ei kopioi DLL -ohjaustiedostoja kovalevylle vaan tarvittavat ohjaukset ovat ohjelmakoodissa, 
  jolloin ylim��r�ist� tiedostom��rien kasvamista ei p��se syntym��n.

=======================================================================================================

LAITTEISTO-ONGELMIA JA MUITA VIKATILANTEITA

1. PAINIKKEIDEN YMS. IKKUNAKOMPONENTTIEN TEKSTIT EIV�T MAHDU NIILLE VARATUILLE PAIKOILLE JA/TAI
   DETALJI- JA NOUSUJOHTOTULOSTUSIKKUNOISSA SARAKEJ�SENTELY EI MUOTOILE TEKSTI� OIKEIN SARAKKEISIIN.
   Syyt:
      Ty�skentelyikkunoiden suunnitteluvaiheessa on k�ytetty Windowsissa fonttikokoa LARGE.
   Ratkaisu:
      Kokeile muuttaa omat asetuksesi Smal�iksi:
      Windowsin asetus: Control Panel / Display / Settings / Advanced / Small Fonts.

2. P��VALINNAN "Verkkolaskenta" J�LKEEN EI TULE VERKKOKUVAIKKUNAA N�KYVIIN, VAIKKA
   LASKENTA-/ LATAUSKUVAAJA (Progres bar) N�YTTI LASKENNAN TAPAHTUNEEN.
   Versiomuutos:  Versiosta 4.0.0 l�htien ikkunoita luotaessa tarkistetaan, onko talletetut
      ikkunakoordinaatit sellaiset, ett� ikkunan tartuntaosaa (nimi�paneli ylh��ll�) on riitt�v�n
      paljon (min. 100 pixeli�) n�kyviss�, jotta ikkunaa p��st��n siirt�m��n ja zoomaamaan. Ikkunan
      minimikoko ja koordinaatit korjataan nyt tarvittaessa automaattisesti. T�t� virhett� ei 3.0.3 ja
      tuoreemmissa versioissa pit�isi en�� esiinty�.
   Syyt 4.1:
      Kortin mukana tulevat ajurit sis�lt�v�t viel� virheit�. Virheet johtunevan siit�, ett�
      n�ytt�korttien kehitys on niin kiivasta, ettei ajurikehitys pysy mukana. Ajurivirhe aiheuttaa
      mahdollisesti sen, ett� sulkeutuvan ikkunan koordinaatit v�littyv�t virheellisin� k�ytt�j�rjes
      telm�n rekister�intirutiineihin, ks. Syyt 4.2 .
   Ratkaisu 4.1:
      Imuroi n�ytt�kortin valmistajan kotisivulta viimeisin ajuriversio.
   Ensiapu 4.1:
      V�henn� n�yt�n asetuksen v�rim��r�� (esim. 256, 16 tms.) ja/tai pienenn� resoluutiota. Jos t�m�
      auttaa, vika on todenn�k�isimmin n�yt�nohjaimen ajurissa.
   Syyt 4.2:
      Windows on NOLAa tai jotain sen ty�ikkunaa sulkiessaan rekister�inyt sulkeutuvan ty�ikkunan
      koordinaatit virheellisesti n�ytt�resoluution ulkopuolelle. Siten esim. 1200x... -n�yt�ll�
      vaakasuuntainen asetus onkin tallettunut esim. 1500 :ksi, jolloin ao. ikkuna on seuraavan
      kerran avautuessaan jo n�yt�n ulkopuolella.
         On mahdollista, ett� jos NOLAn viimeisen ajon j�lkeen on resoluutoasetuksia muutettu k�sin
      pienemmiksi tai jokin ohjelma on sen tehnyt ''automaattisesti'', saattaa NOLAn ikkunakoordinaatit
      n�inkin menn� n�ytt�alueen ulkopuolelle.
   Ratkaisu 4.2:
      Ks. "9. Oletusarvojen palauttaminen."

3. EDELT�V�N VERKON "Detaljit" -PAINIKKEEN JA NOUSUJOHTOLASKENNAN TULOSTEIDEN SARAKKEET
   EIV�T PYSY KOHDAKKAIN.
   Syyt:
      Ohjelmointivaihessa tulosteita suunnitellaan ja testataan eri laskentaparametreilla siten, ett� 
      sarakkeet pysyv�t mahdollisimman hyvin kohdallaan. Koska pohjana on Microsoftin Rich Edit -
      formaatti, jonka kiinteiden sarakeasetusten vapautukselle ei ole l�ytynyt keinoa, saattaa joillain
      n�yt�nohjaimien ja joillain Windowsin fonttiasetuksilla (Large/Small) sarakesiirto (Tab) pys�hty�
      Rich Editin kiinte��n sarakekohtaan, mist� tarvittaisiin ylim��r�inen sarakesiirtok�sky tekstin
      kohdistamiseksi haluttuun paikkaan.
         T�llainen ylim��r�isen sarakesiirron tarve voitaisiin tutkia ohjelmallisesti, mutta koska
      pitkien tekstiosuuksien tutkiminen merkki kerrallaan venytt�� tulosteen ruudulleilmestymisaikaa
      merkitt�v�sti, ei t�t� viel� ole toteutettu.
         Asia korjataan heti, kun t�h�n l�ytyy riitt�v�n nopea algoritmi tai muu ongelman kiertotie.
   Ratkaisu:
      Kokeile muuttaa fonttiasetuksiasi:
      Windowsin asetus: Control Panel / Display / Settings / Advanced / Small(Large) Fonts.
   
4. VIRHEILMOITUS: "Program has performed an illegal operation and will be shut down ..." TAI
   "Floating point divided by zero".
      Virheilmoitus k�ynnistysvaiheessa aiheutuu siit�, ett� resoluutioasetusten perusteella lasketaan
      uuden, aiemmin k�ytt�m�tt�m�n ikkunan sijaintia suhteellisesti ruudulle asettaen ja jos jakajaksi
      muodostuu nolla, aiheutuu virhe "Floating point divided by zero", korjaus ks. Ratkaisu 4.2 .
      T�m� virhe on korjattu versiosta 4.0.0 l�htien.

5. K�ytt�j�rjestelm�ll� XP k�ynnistystilanteessa VIRHEILMOITUS:  "Invalid floating point operation".
   Syyt:
      Vaikka XP on NT -pohjainen, on ko. k�ytt�j�rjestelm� kokonaan kirjoitettu uudestaan, jolloin eroja
      on tullut ilmeisesti mm. ikkunoiden luontivaiheeseen. Ongelman korjaaminen ohjelmallisesti on ty�n
      alla.
   Ratkaisu:
      T�ss� k�ytet��n XP-k�ytt�j�rjestelm�n sovelluskohtaisia muokkauksominaisuuksia hyv�ksi:
      Klikkaa tiedostoluettelossa Nola.EXE -tiedostoa hiiren kakkospainikkeella ja valitse
            Ominaisuudet (Properties)
      ja v�lilehdelt� Yhteensopivuus (Application Combatibility) valitse k�ytt�j�rjestelm�versio
            esim. Windows 98/Windows ME,
      johon valittu sovellus sopeutetaan. N�ytt�asetuksista valitse
            Poista teemat k�yt�st�

      N�m� valinnat voidaan tehd� my�s NOLAn pikakuvakkeelle, jos sellainen on olemassa ja tekem�ll�
      vastaavat m��ritykset sille. XP:n virittelyst� on laajempi artikkeli Tietokone -lehden joulukuun
      2002 numerossa (12 / 2002) sivuilla 95 - 96, mist� eo. ohjeetkin on tarkistettu.

6. AJETTAESSA ESIM. KOELUONTOISESTI UUDEMMAN NOLAn VERSION AJON J�LKEEN JOTAIN VANHEMPAA VERSIOTA,
   TULEE OHJELMAN SIS�ISI� VIRHEILMOITUKSIA (esim: Ilmoita valmistajalle ...).
   Syyt:
      Uudempi versio on tehnyt tiedostoon uusia ominaisuuksia k�ytt�vi� muutoksia, joita vanhempi
      versio ei tunnista.
   Ratkaisu:
   1. Lopeta ohjelma. Jos virheilmoitus on pitk��n jatkuvassa silmukassa (per�tysten toistuva,
      sama virheilmoitus), keskeyt� ajo CTRL+ALT+DEL, mink� j�lkeen hyv�ksy k�ytt�j�rjestelm�n
      ehdottama ajon lopetus.
   2. Poista ..NOLA\Config\xxxNimet.txt -tiedostosta ylin rivi (se tiedostonimi, jota ohjelma
      yritt�� oletuksena lukea. Poista my�s sen j�lkeiset rivit, jos niiss� on liian uusi p�iv�ys.
         Viimeksi ajetun, kyseisen ohjelmaosan ajotiedoston nimi voidaan muuttaa tai poistaa my�s
      Windowsin rekisterinhallintaohjelmalla:
         (..\Windows (tai: WinNT) / RegEdit.EXE / HKEY_CURRENT_USER / Software / NOLA / xxx,
      miss� xxx = viimeksi talletettu tiedosto:
         LastBranch = Nousujohtojen laskenta
         LastNotor  = Moottoril�ht�jen k�sittely
         PreNet     = Edelt�v�n verkon k�sittely.

7. OLETUSARVOJEN PALAUTTAMINEN.
   Jos NOLAn k�ynnistyminen ei onnistu tai k�ynnistymisen yhteydess� tulee virheilmoituksia, joista
   ohjelma ei toivu, voit palauttaa oletusarvot, jolloin ruudun ikkuna-asetukset, tiedostopolut ja
   viimeksi tallettunut tiedosto (mah. vioittunut) ohittuvat.
      K�ynnist� (C:)\WINDOWS\REGEDIT.EXE, kaksoisklikkaa HKEY_CURRENT_USER -hakemistokuvaketta ja sen
   j�lkeen Software -hakemistokuvaketta, mist� uudelleennime� Nola -hakemisto (esim. NolaE :ksi),
   jolloin kaikki oletusasetukset astuvat voimaan. NOLAa k�ynnistett�ess� em. hakemisto tehd��n
   uudestaan, joten p��set vertailemaan hakemistojen asetuseroja. Hakemiston sis�lt�� voidaan my�s
   tutkia ja k�ytt�j�n riskill� my�s muuttaa esim. jos jonkin ikkunan koordinaatit ovat isompia kuin
   resoluutio.
      Kohdan 8. ohjeiden mukaan l�yd�t tiedostot, joiden sis�lt�� tutkimalla ja vertaamalla uusimpiin
   vastaaviin, voit n�hd� ja p��tell� mahd. virhekohdat.

