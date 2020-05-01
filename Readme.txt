1. MUUTOSHISTORIA:
------------------

15.0.0   01.05.2020
- Lisenssi on muutettu avoimeksi BSD-lisenssiksi (ks. license.txt).
- Käyttörajoitukset on poistettu ja toimintalaajuus on pakotettu laajimmaksi (GLOB).
- Ohjelmaa voi käyttää ja kehittää lisenssin mukaisesti, mutta alkuperäiset kehittäjät eivät enää tarjoa tukea.


2. KÄÄNTÄMINEN JA ASENNUSPAKETIN TEKEMINEN:
-------------------------------------------

2.1. Asenna Embarcadero Delphi Community edition [https://www.embarcadero.com/free-tools]:
	- Tämä ohje on kirjoitettu käyttäen Delphi 10.3.3 -versiota.
	- Vähimmäisvaatimuksena ovat Dephi Windows 32-bit ja Delphi Windows 64-bit käännösympäristöt.

2.2. Hae Nola-ohjelmiston lähdekoodit hakemistoon:
	- Hakemistoon viitataan jatkossa lyhenteellä [NOLA] 

2.3. Käännä ja asenna visuaaliset komponentit:
	- Käynnistä Delphi.
	- Valitse valikosta "File"/"Open Project".
	- Avaa projektitiedosto [NOLA]/SRC/Components/NolaComponents.dproj
	- Aktivoi "Projects"-ikkunassa "Target Platforms"/"Windows 32-bit"
	- Käännä valitsemalla "Projects"-ikkunassa "Build Configurations"/"Release" oikealla hiiren napilla ja valitse "Build".
	- Valitse valikosta "Component"/"Install Packages"
	- Klikkaa "Add..."
	- Avaa komponenttitiedosto [NOLA]/packages/Components/Win32/Release/NolaComponents.bpl
	- Varmista että "Design packages"-listassa näkyy "Nola-ohjelmiston komponentit" ja sen edessä olevassa laatikossa on ruksi.
	- Klikkaa "Save"
	- Sulje Delphi. Delphi kysyy että tallennetaanko muutokset NolaComponents-projektiin ja tähän voi vastata "Kyllä".

2.4. Käännä Nola-ohjelmisto:
	- Käynnistä Delphi.
	- Valitse valikosta "File"/"Open Project".
	- Avaa projektitiedosto [NOLA]/SRC/Nola.dproj
	- Aktivoi "Projects"-ikkunassa "Target Platforms"/"Windows 32-bit"
	- Käännä valitsemalla "Projects"-ikkunassa "Build Configurations"/"Release" oikealla hiiren napilla ja valitse "Build".
	- Aktivoi "Projects"-ikkunassa "Target Platforms"/"Windows 64-bit"
	- Käännä valitsemalla "Projects"-ikkunassa "Build Configurations"/"Release" oikealla hiiren napilla ja valitse "Build".
	- Sulje Delphi. Delphi kysyy että tallennetaanko muutokset Nola-projektiin ja tähän voi vastata "Kyllä".

2.5. Tee asennuspaketti
	- Tee .zip paketti hakemistosta [NOLA]/BIN


3. ASENTAMINEN:
---------------

3.1. Pura hakemistosta [NOLA]/BIN tehty .zip paketti haluttuun paikkaan.
3.2. Käynnistä joko [NOLA]/BIN/Nola.exe tai [NOLA]/BIN/Nola_win32.exe
	
