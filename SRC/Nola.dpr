{
* Copyright (c) 2020, Reijo Pursiainen, Hannu Pursiainen
* All rights reserved.
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
*
*     * Redistributions of source code must retain the above copyright
*       notice, this list of conditions and the following disclaimer.
*     * Redistributions in binary form must reproduce the above copyright
*       notice, this list of conditions and the following disclaimer in the
*       documentation and/or other materials provided with the distribution.
*     * Neither the name of Reijo Pursiainen, Hannu Pursiainen nor the
*       names of its contributors may be used to endorse or promote products
*       derived from this software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY REIJO PURSIAINEN, HANNU PURSIAINEN AND
* CONTRIBUTORS ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING,
* BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
* A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL REIJO PURSIAINEN,
* HANNU PURSIAINEN AND CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
* INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
* LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
* LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
* ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
}

program Nola; //Jos tiedostonimiä muutetaan, on SE TEHTÄVÄ SAVE AS käskyllä DELPHISTÄ. Muuten .DCU-
              //tiedostot eivät päivity eikä niiden NIMIEN MUUTTAMINEN KÄSIN AUTA, todettu !!!!!!
{HUO! HUOM! HUOM! HUOM!:
      Varo Project/Options/Compiler -ChkBx-asetuksia; mm. Syntax options/Complete boolean eval aiheut-
      taa sen. että () AND () AND ... ehtoketjuissa TUTKITAAN VIKA EHTOKIN, eikä lopeteta tutkimista,
      VAIKKA LOPPUTULOS SELVIÄISI JO EKASSA => AIHEUTTAA "Error: Out on index range..." tmv. virheen,
      jos esim. Cell[index,...] on pielessä. Todettu + ks. Help "AND" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!}
{$B-} //< =enables short-circuit evaluation. To enable complete evaluation locally, add the B+
      //'  Tämä varm.vuoksi +4.0.0



uses
  Vcl.Forms,
  PaaVal in 'Main\PaaVal.pas' {PaaValFrm},
  Y_ in 'Globals\Y_.pas' {Y_DemoFrm},
  GlobInfo in 'Globals\GlobInfo.pas' {ClobInfoFrm},
  InfoDlgUnit in 'Globals-2\InfoDlgUnit.pas' {InfoDlgFrm},
  DetEv in 'EdvNj\DetEv.pas' {DetEvFrm},
  Z_A2 in 'Impedanssi\Z_A2.pas' {Z_A2Frm},
  Z_PaaVal in 'Impedanssi\Z_PaaVal.pas' {Z_PaaValFrm},
  ZS_ in 'Impedanssi\ZS_.pas' {ZS_Frm},
  Odota in 'Main\Odota.pas' {OdotaFrm},
  Asetus in 'Main\Asetus.pas' {AsetusFrm},
  EdvNew in 'EdvNj\EdvNew.pas' {EdvNewFrm},
  EdvNewLask in 'EdvNj\EdvNewLask.pas',
  FormatCable in 'EdvNj\FormatCable.pas',
  IkKayra in 'EdvNj\IkKayra.pas' {IkFrm},
  Johdot in 'EdvNj\Johdot.pas',
  Johto in 'EdvNj\Johto.pas',
  NjTul3 in 'EdvNj\NjTul3.PAS' {NjTulFrm},
  CableImages in 'EdvNj\CableImages.pas',
  AlkuOdot in 'Globals\AlkuOdot.pas' {AlkuOdotFrm},
  Globals in 'Globals\Globals.pas',
  Moot in 'Moottori\Moot.pas' {MoFrm},
  CutInfo in 'Globals\CutInfo.pas' {CutFrm},
  Herja1 in 'Globals\Herja1.pas' {Herja1Frm},
  Koe in 'Globals\Koe.pas' {KoeFrm},
  KoePaa in 'Globals\KoePaa.pas' {KoePaaFrm},
  Korj in 'Globals\Korj.pas' {KorjFrm},
  LaskeeOd in 'Globals\LaskeeOd.pas' {LaskeeOdFrm},
  license in 'Globals\license.pas',
  LicenseDlg in 'Globals\LicenseDlg.pas' {LicenseConfirmDlg},
  LicenseMove2 in 'Globals\LicenseMove2.pas' {LicenseMove2Frm},
  LicenseMoveDlg in 'Globals\LicenseMoveDlg.pas' {LicenseMoveFrm},
  LicensePanelNola in 'Components\LicensePanelNola.pas',
  Log in 'Globals\Log.pas',
  NolaCount in 'Globals\NolaCount.pas',
  NolaForms in 'Globals\NolaForms.pas' {FormNola},
  CablePanelNola in 'Components\CablePanelNola.pas',
  ComboBoxXY in 'Components\ComboBoxXY.pas',
  LabelNola in 'Components\LabelNola.pas',
  PrintDialogNola in 'Globals\PrintDialogNola.pas' {PrintDlgNola},
  PrintPreview in 'Globals\PrintPreview.pas' {PrintPreviewDlg},
  Progres in 'Globals\Progres.pas' {ProgresFrm},
  Syotto in 'Globals\Syotto.pas' {SyottoFrm},
  SyottoAv in 'Globals\SyottoAv.pas' {SyottoAvFrm},
  TextBase in 'Globals\TextBase.pas',
  TextBaseTexts in 'Globals\TextBaseTexts.pas',
  MoDet in 'Moottori\MoDet.pas' {MoDetFrm},
  TilLom in 'Globals\TilLom.PAS' {TilLomFrm},
  NolaComp in 'Components\NolaComp.pas',
  PanelNola in 'Components\PanelNola.pas',
  RichEditNola in 'Components\RichEditNola.pas',
  Settings in 'Components\Settings.pas',
  StringGridNola in 'Components\StringGridNola.pas',
  Unit0 in 'Globals\Unit0.pas',
  Unit1 in 'Globals\Unit1.pas',
  LicenseFuncs in 'Components\LicenseFuncs.pas',
  Vcl.Themes,
  Vcl.Styles,
  FileLstN in 'Common\FileLstN.pas' {FileLstFrm},
  Defs in 'Globals\Defs.pas',
  NjVrk in 'EdvNj\NjVrk.PAS' {NjFrm},
  KysyUnit in 'Globals\KysyUnit.pas' {KysyFrm},
  Kayra in 'Sulake\Kayra.pas' {KayraFrm},
  S_PaaVal in 'Sulake\S_PaaVal.pas' {S_PaaValFrm},
  Apu in 'Globals\Apu.pas' {ApuFrm};

//Apu in 'Globals\Apu.pas' {ApuFrm};

{$R *.RES}
{-$R 'NolaIconRes.res' 'NolaIconRes.rc'} //<+12.0.08 Jälkimm itse lisätty (?).

begin
  DTot := 0;{:=101 :120.5o:} DExc := 0;  KumTOT := 0; //<,+120.5o:  Alkusijoitus tässä aikaisintaan, testattu
  EtsiExenJuuri_TeeAjoDir;                            //<+130.0  Ainoa kutsu (myös RekPaa.PAS´ssa) siirrtty AlkuOdot.PAS´sista.
  if RegFnVirhe<>''  then             //<+1415f. Tässä Exit lopettaa ajon, OK.
     Exit;
  Application.MainFormOnTaskbar := True;
  {Application.Initialize;}
  Application.HintPause := 100;
  Application.HintHidePause := 7000;
Chk64B_ohitus := false;             //<+120.4:  Tämä oltava FA JAKELUversiossa. Ehto tutkitaan PRC TPaaValFrm.FormShow. ,,,,,,,,,,,,,,
//Chk64B_ohitus := true;            //<+120.4:  Tämä rivi  KOMMENTOITAVA VEX JAKELUversiossa. Tämä jotta voi debukata 32B, := Nola.dpr
//if NOT Chk64B_ohitus  then          //<Ehtotesti tässä VAIN jotta saadaan saman lauseen sisään.                       ''''''''''''''''
//   if Start64Version('Nola') then   //<+12.0.07:  DEVELOPER2 vihje:  DPR-filestä kutsutaan Start64Version, löytyikin DEVELOPER2_U´sta.
//      exit;                         //<'120.4:    if NOT IsDebuggerPresent then  ei onaa.
//Application.Icon.LoadFromFile ('\\REIJO-XP\e\Projektit XE2\NolaKehi\SRC\Nola_IconU.ico');//<Tämä OK, mutta workkii vain omassa koneessa.
//,NolaIconRes.rc= MAINICON ICON "Nola_IconU.ico"
//Application.Icon.LoadFromResourceName ({Handle}hInstance{MainInstance},'MAINICON');
//'''''''''''''''''''''''''''''Koe

{Od}AlkuOdotFrm := TAlkuOdotFrm.Create(Application);
    {try }AlkuOdotFrm.Show;
    {Except                                //<,Jos ei Read +Write -oikeuksia Config -dirrissä, tulee "Invalid file name - %s" error.
     Vcl.Dialogs.ShowMessage('V7irhe0');
    end;}
    AlkuOdotFrm.Refresh;                   //,Edeltä Apu in 'Globals\Apu.pas' {ApuFrm}; myös kommentoitava vex. Ei ehkä tarvis???
//Application.CreateForm(TApuFrm, ApuFrm); //<Siirrtty käsin tähän 120.45, otettu vex jottei ApuFrm tulisi näytölle, kun Y_.PAS/FNC fMSpixPit valmis.
  CreateGlobals;                           //'############################''''''''''''''''''''''''''''''''''''''''##################################
  Application.CreateForm(TPaaValFrm, PaaValFrm);
  Application.CreateForm(TDetEvFrm, DetEvFrm);
  Application.CreateForm(TKayraFrm, KayraFrm);
  Application.CreateForm(TS_PaaValFrm, S_PaaValFrm);
  Application.CreateForm(TS_PaaValFrm, S_PaaValFrm);
  Application.CreateForm(TS_PaaValFrm, S_PaaValFrm);
  Application.CreateForm(TClobInfoFrm, ClobInfoFrm);
  Application.CreateForm(TApuFrm, ApuFrm);
  //Application.CreateForm(TGlobFrm, GlobFrm); Tuli kun tein GlobInfoUnit´tia muistamatta, että GlobInfo oli jo.
  //<120.5n/6:  Jälenpää tähän, jotta FileEv.INC voisi sitä käyttää. EdRvllä'' ollessa lopetti Nolan.!!!!!!
  Application.CreateForm(TFileLstFrm, FileLstFrm);
  Application.CreateForm(TNjFrm, NjFrm);
  Application.CreateForm(TKysyFrm, KysyFrm);
  //Application.CreateForm(TApuFrm, ApuFrm);
  //<PaaValFrm oltava ekana. komm: +12.0.01
  Application.CreateForm(TAsetusFrm, AsetusFrm);
  Application.CreateForm(TInfoDlgFrm, InfoDlgFrm);
  Application.CreateForm(TSyottoAvFrm, SyottoAvFrm);
  Application.CreateForm(TY_DemoFrm, Y_DemoFrm);
  Application.CreateForm(TZ_A2Frm, Z_A2Frm);
  Application.CreateForm(TZ_PaaValFrm, Z_PaaValFrm);
  Application.CreateForm(TZS_Frm, ZS_Frm);
  Application.CreateForm(TS_PaaValFrm, S_PaaValFrm);
  Application.CreateForm(THerja1Frm, Herja1Frm);
  Application.CreateForm(TKoeFrm, KoeFrm);
  Application.CreateForm(TNjFrm, NjFrm);
  Application.CreateForm(TEdvNewFrm, EdvNewFrm);
  Application.CreateForm(TPrintDlgNola, PrintDlgNola);
//Application.CreateForm(TDetEvFrm, DetEvFrm);
  Application.CreateForm(TOdotaFrm, OdotaFrm);
  Application.CreateForm(TLicenseConfirmDlg, LicenseConfirmDlg);
  Application.CreateForm(TProgresFrm, ProgresFrm);
  Application.CreateForm(TNjTulFrm, NjTulFrm);
  Application.CreateForm(TMoFrm, MoFrm);
  Application.CreateForm(TLicenseMoveFrm, LicenseMoveFrm);
  Application.CreateForm(TLicenseMove2Frm, LicenseMove2Frm);
  Application.CreateForm(TTilLomFrm, TilLomFrm);
  Application.CreateForm(TMoDetFrm, MoDetFrm);
  Application.CreateForm(TKayraFrm, KayraFrm);
  Application.CreateForm(TPrintPreviewDlg, PrintPreviewDlg);
  Application.CreateForm(TIkFrm, IkFrm);
  Application.CreateForm(TSyottoFrm, SyottoFrm);
  Application.CreateForm(TLaskeeOdFrm, LaskeeOdFrm);
  Application.CreateForm(TCutFrm, CutFrm);
  Application.CreateForm(TKorjFrm, KorjFrm);
  Application.CreateForm(TKoePaaFrm, KoePaaFrm);
  Application.CreateForm(TFormNola, FormNola);
                                                //DefsFile3('dpr 37'); //,PaaValFrm.FormShow´ssa
  PaaValFrm.Visible := true;
                                                //DefsFile3('dpr 38');
//DTot := 101;{:120.5o:} DExc := 66;  KumTot := 0;  //<Siirrtty heti alkuun BEGIN´in jälkeen.
  PaaValFrm.Refresh;        //<Tämä 'pakottaa' PaaValFrm :n piirtymään kokonaan vaikka ENTERiä pai-
                            //'nettaisiin "NOLA latautuu, odota" viestin aikana = ennen ao. formia
                       //AlkuOdotFrm.Hide;
  //,Clipboardiin leikkausta / kotisivun taustakuvaa varten:
  AlkuOdotFrm.Close;   //8.0.5u Kuvakaappausta varten kommentoi vex, jotta PrintScreen workkisi.
                       //AlkuOdotFrm.free;?
  Application.Run;
end.
