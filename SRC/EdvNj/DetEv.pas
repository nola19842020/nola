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

unit DetEv;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, PanelNola, StdCtrls, ComCtrls, RichEditNola, Printers, NolaForms,
  ComboBoxXY;

type
  TDetEvFrm = class(TFormNola)
    aRich: TRichEditNola;
    Panel1: TPanelNola;
    SuljeBtn: TButton;
    TulostaBtn: TButton;
    EtsiBtn: TButton;
    EtsiEdi: TComboBoxXY;
    bRich: TRichEditNola;
    procedure SuljeBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure EtsiBtnClick(Sender: TObject);
    procedure EtsiEdiKeyPress(Sender: TObject; var Key: Char);
    procedure aRichKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure aRichMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer); //<+3.0.0
    procedure FormShow(Sender: TObject);
  //procedure TulostaBtnClick(Sender: TObject);
    procedure TulostaBtnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,Y: Integer);
  private
  public
  end;

var
  DetEvFrm: TDetEvFrm;
  PROCEDURE tul_eritEdv;

implementation

uses Globals, Defs, Unit0, Unit1, Y_, Herja1, EdvNew, PrintDialogNola, Odota, Progres, InfoDlgUnit, PaaVal{IsDebug..},
     Koe{12.0.0};

{$R *.DFM}

(*procedure ad3SF (t :integer;  s1, s2, s3 :string);   FORWARD; //begin ad3S_ (t,s1,s2,s3);  LF;  end; // - " - + LF
  function fOhm :string;                               FORWARD;
  function EiTUPraj :string;                           FORWARD;
VAR PselOnJo,XselOnJo :Boolean{+9.0.1};*)
{$I '..\GlobINC\DetEv-1.INC'}  //<Siellä incluudattu DetEv-2.INC

procedure TDetEvFrm.SuljeBtnClick(Sender: TObject);      begin
  {DetEvFrm.+120.5n} Close;
end;

(*procedure TDetEvFrm.TulostaBtnClick(Sender: TObject);      begin
  TulostaBtn.Enabled := False;
  Screen.Cursor := crHourGlass;              //<Ilman SCREENiä vipattaa!!!
  IF PrintDlgNola.Execute(modeA2, self)  then begin   //DEVELOPER2 6.12.1998
    try
      aRich.PageRect := Rect (200,0, Printer.PageWidth,Printer.PageHeight);      //=2326,3389 =oaX,Y
      aRich.Print('');                       //Z_A2Frm.Print; = Print;  =Tulostaa VAIN FORMin=POHJAN
    finally
      Screen.Cursor := crDefault;
    end;
  end;
  Screen.Cursor := crDefault;
  TulostaBtn.Enabled := True;
end;*)

procedure TDetEvFrm.TulostaBtnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;  X,Y: Integer);
                                                                                                    VAR val :integer;
//procedure TDetEvFrm.TulostaBtnClick(Sender: TObject);      VAR val :integer;
                                                                                               //,,,+6.2.2
   function TulValittu :integer;      VAR tama :integer;      begin//Palauttaa:  1(Selected)  2(Kokon.)  9=Peru
       if aRich.SelLength>10          //< 10 =Muutamaa merkkiä pitempi, parempi kuin esim. >0
       then begin
          tama := InfoDlg ('Tulostetaanko valittu alue vai koko sisältö?',  mtCustom,
                     'Tulosta valittu',     //< 1
                     'Tulosta KAIKKI',      //< 2
                     'Peru','',             //< 3, jos suljetaan X :llä => tama := 9;

                     'Tulostetaan vain valittu osa',
                     'Tulostetaan koko sisältö',
                     'Palataan edeltävään tilanteeseen','');
          case tama of
             1 :begin bRich.Visible := true;
                      bRich.Lines.Clear;
                    //bRich.Assign(aRich);     //<Error. On asetettava käsin,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
                      bRich.Align := alClient;

                      aRich.CopyToClipboard;
                      bRich.PasteFromClipboard;
                      bRich.Visible := true;            //< MouseDown sulkee.
                      bRich.SelStart :=  0;             //< Cursori/focus alkuun
                      bRich.SelLength := 0;             //<JosKommentoi vex ja NOT ENABLED, PÄIVITTYMINEN NÄKYY TOSIAIKSTI, hidas
                      bRich.Width := aRich.Width -1;    //<,,Muutetaan tulfrmn kokoa hetkellisesti, jolloin sisennyk-
                                                        //   set päivittyvät oikein. !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                      bRich.Width := aRich.Width +1;
                    //bRich.Enabled := true;            //<-6.0.3:  Ei enää tarvetta, ks. ylempnä, enab := FA otettu vex.
                    //bRich.Perform (EM_SCROLL,SB_LINEDOWN,0); //<Editorin scroll/1xAlas
                      bRich.Update;
                      bRich.SetFocus;
                end;
             3 :tama := 9;                  //<'Valinnoista vain 1, 2 ja 9 jää ennalleen.
          end;//case
       end
       else begin
          tama := InfoDlg ('Tulostetaanko koko sisältö?',  mtCustom,
                     'Tulosta',             //< 1
                     'Peru','','',          //< 2, jos suljetaan X :llä => tama := 9;

                     'Tulostetaan koko sisältö',
                     'Palataan edeltävään tilanteeseen','','');
          case tama of
             1 :tama := 2;
             2 :tama := 9;                  //<'Valinnoista vain 9 jää ennalleen.
          end;//case
       end;
       result := tama;
   end;//TulValittu

begin//TulostaBtnMouseDown,,,,,,,,,,,,,,,,,,,,
  inherited;
if Shift=[ssLeft,ssAlt,ssCtrl]
then aRich.Lines.SaveToFile(gAjoPath +'_DetEvPRN.rtf')
else begin                                             //<''+120.4
  TulostaBtn.Enabled := False;
  Screen.Cursor := crHourGlass;              //<Ilman SCREENiä vipattaa!!!

  val := TulValittu;                         //<Jos eiOK, palauttaa 9.

  if val IN [1,2]  then begin //<Jokin tulostus:  Kaikki ve:t (=aRich) tai haluttu ve (=bRich).
{Kokeilun ajaksi ota vex.,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,KOE}
     IF PrintDlgNola.Execute(modeA2, self)  then begin  //DEVELOPER2 6.12.1998
       try
         case val of
            1 :begin                             //<Valitun alueen tulostus.
               bRich.PageRect := Rect (200,0, Printer.PageWidth,Printer.PageHeight);   //=2326,3389 =oaX,Y
               bRich.Print('');                  //Z_A2Frm.Print; = Print;  =Tulostaa VAIN FORMin=POHJAN}
             //bRich.Lines.Clear;
             //bRich.Update;
               bRich.Visible := false;
               aRich.SetFocus;  end;

            2 :begin                            //<Koko sisällön tulostus.
               aRich.PageRect := Rect (200,0, Printer.PageWidth,Printer.PageHeight);   //=2326,3389 =oaX,Y
               aRich.Print('');  end;
         end;//case
       finally
       //Screen.Cursor := crDefault;
       end;
     end;//Kokeilun ajaksi vex}
  end;
  aRich.SelLength := 0;
  Screen.Cursor := crDefault;
  TulostaBtn.Enabled := True;
end;//else
end;//TulostaBtnMouseDown

procedure TDetEvFrm.FormClose(Sender: TObject; var Action: TCloseAction);      begin
   DetEvAuki := false;
end;

procedure TDetEvFrm.FormResize(Sender: TObject);      begin
  inherited;//,Ei auta:  Minimize + Maximize + Minimize + Maximize peräkk. jättää oik.puolen ruudusta plankoksi
   aRich.Repaint;
end;

procedure TDetEvFrm.EtsiEdiKeyPress(Sender: TObject; var Key: Char);      begin
  inherited;
   if Ord(key)=13  then etsiStr (DetEvFrm.aRich, DetEvFrm.EtsiEdi);
end;

procedure TDetEvFrm.aRichKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);      VAR KeyC :Char;
begin
  inherited;
   if Key=114{F3}
   then begin
      KeyC := #13{Enter};
      EtsiEdiKeyPress(Sender,KeyC);  end
   else if (Key=70{f}) and (ssCtrl IN Shift)
   then EtsiEdi.SetFocus;
end;

procedure TDetEvFrm.EtsiBtnClick(Sender: TObject);      begin
  inherited;
   etsiStr (DetEvFrm.aRich,  DetEvFrm.EtsiEdi);
end;

procedure TDetEvFrm.aRichMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);      begin //<+3.0.0
  inherited;
 //SetFocus; //<+6.1.1
end;

procedure TDetEvFrm.FormShow(Sender: TObject);

{   procedure koetulost;      VAR Ry,Xy, Rm,Rmo,Xm,Xmo, R1v,R1vo,R1n,X1v,X1vo,X1n, R1v20,
                                 R2v,R2vo,R2n,X2v,X2vo,X2n, R2v20, //Rv,Rvo,Rn,Xv,Xvo,Xn,
                                 Zk1v,Zk3v,Ik1v,Ik3v, Uv :real;  //s :string;
      procedure adRv (sr :string);      begin DetEvFrm.aRich.AddText (sr);   end;
      procedure adLF (sr :string);      begin DetEvFrm.aRich.AddText (sr +'<br>');   end;
      function fR (sr :string;  r :real) :string;      begin result := '  ' +sr +fRmrkt0 (r, 1,-10);   end;
                                                                    //'-10 =Sijoitus pienentää, -=loppunollat vex
   begin
      Uv := 230.9401;
      Ry := 0.000098;   Xy := 0.001597;
      Rm := 0.00179;    Rmo := 0.0021;  Xm := 0.00967;  Xmo := 0.01009;
      //,,KiskAbb-CuS 3200, 40°C, 5 m
      R1v := 0.00005541;  R1vo := 0.00002817;  R1n := 0.00009081;   R1v20 := 0.00005137;
      X1v := 0.000535;    X1vo := 0.000169;    X1n := 0.0001635;
      //,,2xAMCMK4½ 185, 40°C, 5m
      R2v := 0.00089038/2;  R2vo := 0.00089038/2;  R2n := 0.00172576/2;   R2v20 := 0.00082397/2;
      X2v := 0.00040841/2;  X2vo := 0.00040841/2;  X2n := 0;

      DetEvFrm.aRich.Lines.Clear;
      adLF ('Detaljitiedoista saat kaikkien käytettyjen impedanssikomponenttien arvot [Ohmia], impedanssien '+
            'tarkasteluosassa (päävalikon painike "Impedanssit") saat halutun kaapelin ja muuntajan komponentit '+
            'halutulla pituudella ja lämpötilalla (esittelyversiossa jotkut arvot on esitetty peitearvoilla '+
            'Xxxx, xxDemo tms.:');
      adLF ('');
      adLF ('Syöttämäsi liittymäimpedanssi:   Ry=0.000098   Xy=0.001597');
      adLF ('Valitsemasi muuntaja 800 kVA, srj 2, T=75°C: '+fR('Rm=',Rm) +fR('Rmo=',Rmo) +fR('Xm=',Xm) +
            fR('Xmo=',Xmo));
      adLF ('1. johto-osa  KiskAbb-CuS 3200 40°C 5 m: ' +fR('Rv=',R1v) +fR('(20°C=',R1v20) +')'  +fR('Rvo=',R1vo) +
            fR('Rn=',R1n) +fR('Xv=',X1v) +fR('Xvo=',X1vo) +fR('Xn=',X1n));
      adLF ('2. johto-osa  2xAMCMK4½ 185 40°C 5m: ' +fR('Rv/2=',R2v) +fR('(20°C=',R2v20) +')'  +fR('Rvo=',R2vo) +
            fR('Rn/2=',R2n) +fR('Xv/2=',X2v) +fR('Xvo/2=',X2vo) +fR('Xn/2=',X2n));

         Zk1v := sqrt ( sqr(2*Ry + 2*Rm+Rmo) + sqr(2*Xy + 2*Xm+Xmo) ); //<,Napaoikosulku
         Ik1v := 3*0.95*Uv/Zk1v;
         Zk3v := sqrt ( sqr(Ry+Rm) + sqr(Xy+Xm));
         Ik3v := Uv/Zk3v;
      adLF ('');
      adLF ('1.johto-osan alussa (napaoikosulku) (palsta 1):');
      adLF ('   Zk1v = sqrt ( sqr(2*Ry + 2*Rm+Rmo) + sqr(2*Xy + 2*Xm+Xmo) ) = ' +fRmrkt0 (Zk1v,1,8));
      adLF ('   Ik1v = 3cUv/Zk1v =' +fRmrkt0 (Ik1v, 1,1) +' A ('+fRmrkt0 (Ik1v/1000, 1,2) +' kA)');
      adLF ('   Zk3v = sqrt ( sqr(Ry+Rm) + sqr(Xy+Xm) ) = ' +fRmrkt0 (Zk3v,1,8));
      adLF ('   Ik3v = Uv/Zk3v = ' +fRmrkt0 (Ik3v, 1,1) +' A ('+fRmrkt0 (Ik3v/1000, 1,2) +' kA)');

         Zk1v := sqrt ( sqr(2*Ry +2*Rm+Rmo +2*R1v+R1vo+3*R1n) + sqr(2*Xy + 2*Xm+Xmo +2*X1v+X1vo+3*X1n) ); //< 1.:n lopussa
         Ik1v := 3*0.95*Uv/Zk1v;
         Zk3v := sqrt ( sqr(Ry+Rm+R1v20) + sqr(Xy+Xm+X1v));
         Ik3v := Uv/Zk3v;
      adLF ('');
      adLF ('1.johto-osan lopussa (palsta 1):');
      adLF ('   Zk1v = sqrt ( sqr(2Ry +2Rm+Rmo +2Rv+Rvo+3Rn) + sqr(2Xy + 2Xm+Xmo +2Xv+Xvo+3Xn) ) = ' +
            fRmrkt0 (Zk1v,1,8));
      adLF ('   Ik1v = 3cUv/Zk1v =' +fRmrkt0 (Ik1v, 1,1) +' A ('+fRmrkt0 (Ik1v/1000, 1,2) +' kA)');
      adLF ('   Zk3v (palsta 2) = sqrt ( sqr(Ry+Rm+Rv20°) + sqr(Xy+Xm+Xv) ) = ' +fRmrkt0 (Zk3v,1,8));
      adLF ('   Ik3v = Uv/Zk3v = ' +fRmrkt0 (Ik3v, 1,1) +' A ('+fRmrkt0 (Ik3v/1000, 1,2) +' kA)');
   end;
}
begin//FormShow......
  inherited;
   //koetulost; //< 21.6.2003 Koeajo tsto Tiaiselle
   with DetEvFrm.EtsiEdi.Items  do begin
      Clear;
      Add ('johto-osan  n:o');
      Add ('johto-osan');
      Add ('johto-osa');
      Add ('lopussa');
      Add ('liittymä');
      Add ('muuntaja');
      Add ('ik1v');
      Add ('ik3v');
      Add ('max');
      Add ('sulak');
      Add ('pot');
      Add ('käsinlask');
      Add ('oikos');
      Add ('yliv');
      Add ('vikav');
   end;//with
 //EtsiEdi.Text := ;
   EtsiEdi.ItemIndex := 0; //<Eka ve näkyviin boxiin
end;//FormShow
(*,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
procedure TDetEvFrm.FormShow(Sender: TObject);
   procedure prc (Un,Sn :integer;  Rk,Xk,Ro,Xo :real);      VAR s :string;
      function fnc (Aprs :real) :real;      begin
         result := Aprs *Sqr (Un/1000) / (100 *Sn/1000);   end; //< Esim:  Rm = Rk% * Un²[kV] / (100 * Sn[MVA])
   begin                                                        //'        Xo = Xo% * Un²[kV] / (100 * Sn[MVA])
      s := fImrkt0 (Un,1) +', ' +fImrkt0 (Sn,4) +', ' +fRmrkt0 (fnc (Rk),8,5) +',' +fRmrkt0 (fnc (Xk),8,5) +', ' +
                                                       fRmrkt0 (fnc (Ro),8,5) +',' +fRmrkt0 (fnc (Xo),8,5) +'<br>';
      DetEvFrm.aRich.AddText (s);   end;
begin
   with DetEvFrm.aRich  do begin
      Lines.Clear;
      AddText ('Un   Teho     Rm       Xm        Ro       Xo<br>');
      AddText ('SARJA 1 (normaalit häviöt)<br>');
          {Un   Teho   Rk   Xk   R0   X0
           V    kVA     %    %    %    %}
      prc (410, 3150, 0.73, 6.7, 1.1, 7.7);
      prc (410, 2500, 0.76, 6.0, 1.1, 6.7);
      AddText ('-----------------------------------<br>');
      prc (690, 3150, 0.73, 6.7, 1.1, 7.7);
      prc (690, 2500, 0.76, 6.0, 1.1, 6.7);
      prc (410, 2000, 0.84, 5.9, 1.1, 6.5);
      prc (410, 1600, 0.88, 5.4, 1.1, 5.9);
      prc (410, 1250, 0.92, 5.4, 1.1, 5.8);
      prc (410, 1000, 1.02, 5.4, 1.2, 5.7);
      prc (410, 800 , 1.06, 5.4, 1.2, 5.6);
      prc (410, 630 , 1.17, 4.9, 1.3, 5.0);
      prc (410, 500 , 1.25, 4.6, 1.4, 4.8);
      prc (410, 315 , 1.40, 4.3, 1.5, 4.4);
      prc (410, 200 , 1.23, 3.8, 1.3, 3.9);

      AddText ('SARJA 2 (alennetut häviöt)<br>');
          {Un   Teho   Rk   Xk   R0   X0
           V    kVA     %    %    %    %}
      prc (410, 2000, 0.68, 6.0, 1.0, 6.6);
      prc (410, 1600, 0.70, 6.0, 1.0, 6.4);
      prc (410, 1250, 0.73, 5.2, 0.9, 5.6);
      prc (410, 1000, 0.80, 4.7, 0.9, 5.0);
      prc (410, 800 , 0.85, 4.6, 1.0, 4.8);
      prc (410, 630 , 0.89, 4.5, 1.0, 4.7);
      prc (410, 500 , 0.98, 4.4, 1.1, 4.5);
      prc (410, 315 , 1.00, 4.2, 1.1, 4.3);
      prc (410, 200 , 1.15, 3.8, 1.2, 3.9);
      prc (410, 100 , 1.49, 3.7, 1.5, 3.8);
      prc (410,  50 , 1.77, 3.6, 1.8, 3.6);
      prc (410,  30 , 1.95, 3.5,  1 , 0.2);

      Font.Name := 'Courier New';
   end;//with
end;//''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''*)
{Teho     Rm       Xm        Ro       Xo
SARJA 1 (normaalit häviöt)
3150,  0.00039, 0.00358,  0.00059, 0.00411
2500,  0.00051, 0.00403,  0.00074, 0.00451
2000,  0.00071, 0.00496,  0.00092, 0.00546
1600,  0.00092, 0.00567,  0.00116, 0.00620
1250,  0.00124, 0.00726,  0.00148, 0.00780
1000,  0.00171, 0.00908,  0.00202, 0.00958
 800,  0.00223, 0.01135,  0.00252, 0.01177
 630,  0.00312, 0.01307,  0.00347, 0.01334
 500,  0.00420, 0.01547,  0.00471, 0.01614
 315,  0.00747, 0.02295,  0.00800, 0.02348
 200,  0.01034, 0.03194,  0.01093, 0.03278
SARJA 2 (alennetut häviöt)
2000,  0.00057, 0.00504,  0.00084, 0.00555
1600,  0.00074, 0.00630,  0.00105, 0.00672
1250,  0.00098, 0.00699,  0.00121, 0.00753
1000,  0.00134, 0.00790,  0.00151, 0.00841
 800,  0.00179, 0.00967,  0.00210, 0.01009
 630,  0.00237, 0.01201,  0.00267, 0.01254
 500,  0.00329, 0.01479,  0.00370, 0.01513
 315,  0.00534, 0.02241,  0.00587, 0.02295
 200,  0.00967, 0.03194,  0.01009, 0.03278
 100,  0.02505, 0.06220,  0.02522, 0.06388
  50,  0.05951, 0.12103,  0.06052, 0.12103
  30,  0.10927, 0.19612,  0.05603, 0.01121
}
initialization
   DetEvAuki := false;

end.

