English briefly:

To remove NOLA totally from the computer:
   - With Regedit.exe rename or remove HKEY_CURRENT_USER/Software/Nola -folder
     
=========================================================================================================     

Nämä tiedot on esitetty myös NOLAssa:
   Päävalikko / Ohjeet,Tietoa    välilehdillä "Ohjeita, rajoituksia" ja 
                                              "Ohjelman siirtäminen ja poistaminen"

YLEISTÄ:
- Ohjelman valmistaja ei vastaa ohjelman mahdollisesta virheellisestä toiminnasta tai sen käytöstä 
  aiheutuneista virheellisistä suunnitelmista eikä niiden taloudellisista seuraamuksista.

- Työskentelyikkunat ovat yleensä muokattavia;   min./max.koko tai portaattomasti tartuntapisteenä 
  ikkunan sivut ja nurkkapisteet.

- Liukulukujen desimaaliosan erottimena voidaan käyttää joko "." tai "," , alkunolla voidaan jättää 
  pois, esim. 0.9 => ,9 tai .9

- Kosketusjännitetarkastelut kädessä pidettäville laitteille suoritetaan SFS 6000 ja A2 / 413.1.3.3 
  - .5 (TN-järjestelmä) mukaan käyttäen taulukko 41 A :n poiskytkentäaikarajoja, jonka Uo jännite 
  lasketaan annetusta nimellis(pää) jännitteestä.   Uo -jännitettä määritettäessä ohjelma tulkitsee 
  Uv-10% arvon kynnysarvoksi. Siten esim.  762 V :n pääjännitteellä Uo :ksi tulkitaan 762 / V¨3 =
  440 =>  Uo = 400 V, jolle poiskytkentäaikavaatimus on 0.2 s.

- Johtojen asennustapojen (A,C,D) kuormitettavuustekijät ovat A2 / Liite 1 :n mukaisia.

- Kirjalliset käyttöohjeet on korvattu syöttötapahtumakohtaisilla ja hiiren liikkeen mukaan, omaan 
  ikkunaan päivittyvillä avusteilla, jotka sisältävät taustatiedot, laskentamenetelmäkuvaukset, 
  varoitukset tarvittaessa jne. Tapauskohtaisia vertailulaskelmia, väli- ja apuarvoja, 
  yksityiskohtaista teoriaa yms. on saatavissa mm. Verkonlaskennan "Detaljit" -painikkeen tulosteista. 
  Kaikki avusteet voidaan ottaa ohjelmaosittain kattavina paperitulosteina haluttaessa  käyttöohjeiksi 
  "Tulosta" -painikkeen jälkeisellä valinnalla  TAI avusteikkunakohtaisesti Ctrl+P :llä.

- Nousujohtolaskennan hintatiedosto (KaapHinD.NOL) on itse muokattavissa ASCII -muotoisena.   
  Tiedoston Nimi -sarakkeessa ilmaistaan tulostuksessa käytettävä kaapelin nimitys.   Laji- ja 
  johdinlukumäärä (jLkm)-sarakeet ovat varauksia, joiden arvoilla ei toistaiseksi ole merkitystä:   
  nousujohtolaskenta tapahtuu aina MCMK-, AMCMK- kaapeleiden ja/tai SVjärjestelmien ja edeltävän 
  verkon laskenta annettujen johtotyyppien sähköisillä arvoilla.

-------------------------------------------------------------------------------------------------------

NOLA - OHJELMAN POISTO KONEESTA:

- Poista NOLA.EXE´n sisältämä hakemisto (alihakemistoineen).
- Käynnistä (C:)\WINDOWS\REGEDIT.EXE, kaksoisklikkaa HKEY_CURRENT_USET -hakemistokuvaketta ja sen 
  jälkeen Software -hakemistokuvaketta, mistä poista Nola -hakemisto.
  NOLA ei kopioi DLL -ohjaustiedostoja kovalevylle vaan tarvittavat ohjaukset ovat ohjelmakoodissa, 
  jolloin ylimääräistä tiedostomäärien kasvamista ei pääse syntymään.

=======================================================================================================

LAITTEISTO-ONGELMIA JA MUITA VIKATILANTEITA

1. PAINIKKEIDEN YMS. IKKUNAKOMPONENTTIEN TEKSTIT EIVÄT MAHDU NIILLE VARATUILLE PAIKOILLE JA/TAI
   DETALJI- JA NOUSUJOHTOTULOSTUSIKKUNOISSA SARAKEJÄSENTELY EI MUOTOILE TEKSTIÄ OIKEIN SARAKKEISIIN.
   Syyt:
      Työskentelyikkunoiden suunnitteluvaiheessa on käytetty Windowsissa fonttikokoa LARGE.
   Ratkaisu:
      Kokeile muuttaa omat asetuksesi Smal´iksi:
      Windowsin asetus: Control Panel / Display / Settings / Advanced / Small Fonts.

2. PÄÄVALINNAN "Verkkolaskenta" JÄLKEEN EI TULE VERKKOKUVAIKKUNAA NÄKYVIIN, VAIKKA
   LASKENTA-/ LATAUSKUVAAJA (Progres bar) NÄYTTI LASKENNAN TAPAHTUNEEN.
   Versiomuutos:  Versiosta 4.0.0 lähtien ikkunoita luotaessa tarkistetaan, onko talletetut
      ikkunakoordinaatit sellaiset, että ikkunan tartuntaosaa (nimiöpaneli ylhäällä) on riittävän
      paljon (min. 100 pixeliä) näkyvissä, jotta ikkunaa päästään siirtämään ja zoomaamaan. Ikkunan
      minimikoko ja koordinaatit korjataan nyt tarvittaessa automaattisesti. Tätä virhettä ei 3.0.3 ja
      tuoreemmissa versioissa pitäisi enää esiintyä.
   Syyt 4.1:
      Kortin mukana tulevat ajurit sisältävät vielä virheitä. Virheet johtunevan siitä, että
      näyttökorttien kehitys on niin kiivasta, ettei ajurikehitys pysy mukana. Ajurivirhe aiheuttaa
      mahdollisesti sen, että sulkeutuvan ikkunan koordinaatit välittyvät virheellisinä käyttöjärjes
      telmän rekisteröintirutiineihin, ks. Syyt 4.2 .
   Ratkaisu 4.1:
      Imuroi näyttökortin valmistajan kotisivulta viimeisin ajuriversio.
   Ensiapu 4.1:
      Vähennä näytön asetuksen värimäärää (esim. 256, 16 tms.) ja/tai pienennä resoluutiota. Jos tämä
      auttaa, vika on todennäköisimmin näytönohjaimen ajurissa.
   Syyt 4.2:
      Windows on NOLAa tai jotain sen työikkunaa sulkiessaan rekisteröinyt sulkeutuvan työikkunan
      koordinaatit virheellisesti näyttöresoluution ulkopuolelle. Siten esim. 1200x... -näytöllä
      vaakasuuntainen asetus onkin tallettunut esim. 1500 :ksi, jolloin ao. ikkuna on seuraavan
      kerran avautuessaan jo näytön ulkopuolella.
         On mahdollista, että jos NOLAn viimeisen ajon jälkeen on resoluutoasetuksia muutettu käsin
      pienemmiksi tai jokin ohjelma on sen tehnyt ''automaattisesti'', saattaa NOLAn ikkunakoordinaatit
      näinkin mennä näyttöalueen ulkopuolelle.
   Ratkaisu 4.2:
      Ks. "9. Oletusarvojen palauttaminen."

3. EDELTÄVÄN VERKON "Detaljit" -PAINIKKEEN JA NOUSUJOHTOLASKENNAN TULOSTEIDEN SARAKKEET
   EIVÄT PYSY KOHDAKKAIN.
   Syyt:
      Ohjelmointivaihessa tulosteita suunnitellaan ja testataan eri laskentaparametreilla siten, että 
      sarakkeet pysyvät mahdollisimman hyvin kohdallaan. Koska pohjana on Microsoftin Rich Edit -
      formaatti, jonka kiinteiden sarakeasetusten vapautukselle ei ole löytynyt keinoa, saattaa joillain
      näytönohjaimien ja joillain Windowsin fonttiasetuksilla (Large/Small) sarakesiirto (Tab) pysähtyä
      Rich Editin kiinteään sarakekohtaan, mistä tarvittaisiin ylimääräinen sarakesiirtokäsky tekstin
      kohdistamiseksi haluttuun paikkaan.
         Tällainen ylimääräisen sarakesiirron tarve voitaisiin tutkia ohjelmallisesti, mutta koska
      pitkien tekstiosuuksien tutkiminen merkki kerrallaan venyttää tulosteen ruudulleilmestymisaikaa
      merkittävästi, ei tätä vielä ole toteutettu.
         Asia korjataan heti, kun tähän löytyy riittävän nopea algoritmi tai muu ongelman kiertotie.
   Ratkaisu:
      Kokeile muuttaa fonttiasetuksiasi:
      Windowsin asetus: Control Panel / Display / Settings / Advanced / Small(Large) Fonts.
   
4. VIRHEILMOITUS: "Program has performed an illegal operation and will be shut down ..." TAI
   "Floating point divided by zero".
      Virheilmoitus käynnistysvaiheessa aiheutuu siitä, että resoluutioasetusten perusteella lasketaan
      uuden, aiemmin käyttämättömän ikkunan sijaintia suhteellisesti ruudulle asettaen ja jos jakajaksi
      muodostuu nolla, aiheutuu virhe "Floating point divided by zero", korjaus ks. Ratkaisu 4.2 .
      Tämä virhe on korjattu versiosta 4.0.0 lähtien.

5. Käyttöjärjestelmällä XP käynnistystilanteessa VIRHEILMOITUS:  "Invalid floating point operation".
   Syyt:
      Vaikka XP on NT -pohjainen, on ko. käyttöjärjestelmä kokonaan kirjoitettu uudestaan, jolloin eroja
      on tullut ilmeisesti mm. ikkunoiden luontivaiheeseen. Ongelman korjaaminen ohjelmallisesti on työn
      alla.
   Ratkaisu:
      Tässä käytetään XP-käyttöjärjestelmän sovelluskohtaisia muokkauksominaisuuksia hyväksi:
      Klikkaa tiedostoluettelossa Nola.EXE -tiedostoa hiiren kakkospainikkeella ja valitse
            Ominaisuudet (Properties)
      ja välilehdeltä Yhteensopivuus (Application Combatibility) valitse käyttöjärjestelmäversio
            esim. Windows 98/Windows ME,
      johon valittu sovellus sopeutetaan. Näyttöasetuksista valitse
            Poista teemat käytöstä

      Nämä valinnat voidaan tehdä myös NOLAn pikakuvakkeelle, jos sellainen on olemassa ja tekemällä
      vastaavat määritykset sille. XP:n virittelystä on laajempi artikkeli Tietokone -lehden joulukuun
      2002 numerossa (12 / 2002) sivuilla 95 - 96, mistä eo. ohjeetkin on tarkistettu.

6. AJETTAESSA ESIM. KOELUONTOISESTI UUDEMMAN NOLAn VERSION AJON JÄLKEEN JOTAIN VANHEMPAA VERSIOTA,
   TULEE OHJELMAN SISÄISIÄ VIRHEILMOITUKSIA (esim: Ilmoita valmistajalle ...).
   Syyt:
      Uudempi versio on tehnyt tiedostoon uusia ominaisuuksia käyttäviä muutoksia, joita vanhempi
      versio ei tunnista.
   Ratkaisu:
   1. Lopeta ohjelma. Jos virheilmoitus on pitkään jatkuvassa silmukassa (perätysten toistuva,
      sama virheilmoitus), keskeytä ajo CTRL+ALT+DEL, minkä jälkeen hyväksy käyttöjärjestelmän
      ehdottama ajon lopetus.
   2. Poista ..NOLA\Config\xxxNimet.txt -tiedostosta ylin rivi (se tiedostonimi, jota ohjelma
      yrittää oletuksena lukea. Poista myös sen jälkeiset rivit, jos niissä on liian uusi päiväys.
         Viimeksi ajetun, kyseisen ohjelmaosan ajotiedoston nimi voidaan muuttaa tai poistaa myös
      Windowsin rekisterinhallintaohjelmalla:
         (..\Windows (tai: WinNT) / RegEdit.EXE / HKEY_CURRENT_USER / Software / NOLA / xxx,
      missä xxx = viimeksi talletettu tiedosto:
         LastBranch = Nousujohtojen laskenta
         LastNotor  = Moottorilähtöjen käsittely
         PreNet     = Edeltävän verkon käsittely.

7. OLETUSARVOJEN PALAUTTAMINEN.
   Jos NOLAn käynnistyminen ei onnistu tai käynnistymisen yhteydessä tulee virheilmoituksia, joista
   ohjelma ei toivu, voit palauttaa oletusarvot, jolloin ruudun ikkuna-asetukset, tiedostopolut ja
   viimeksi tallettunut tiedosto (mah. vioittunut) ohittuvat.
      Käynnistä (C:)\WINDOWS\REGEDIT.EXE, kaksoisklikkaa HKEY_CURRENT_USER -hakemistokuvaketta ja sen
   jälkeen Software -hakemistokuvaketta, mistä uudelleennimeä Nola -hakemisto (esim. NolaE :ksi),
   jolloin kaikki oletusasetukset astuvat voimaan. NOLAa käynnistettäessä em. hakemisto tehdään
   uudestaan, joten pääset vertailemaan hakemistojen asetuseroja. Hakemiston sisältöä voidaan myös
   tutkia ja käyttäjän riskillä myös muuttaa esim. jos jonkin ikkunan koordinaatit ovat isompia kuin
   resoluutio.
      Kohdan 8. ohjeiden mukaan löydät tiedostot, joiden sisältöä tutkimalla ja vertaamalla uusimpiin
   vastaaviin, voit nähdä ja päätellä mahd. virhekohdat.

