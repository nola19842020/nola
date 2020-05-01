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

{Kokeilu ks. C:\ProjektitKoe\IkKayra\IkKayra.PAS, miss‰ paljon muita k‰yri‰ ja kommentteja }

unit IkKayra;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,NolaForms, Dialogs,
  StdCtrls, ExtCtrls, PanelNola, LabelNola, ComboBoxXY, Printers, Math,
  ComCtrls, System.UITypes;

type
  TIkFrm = class(TFormNola){TForm_->TFormNola_ 4.0.0}
    PanelNola1: TPanelNola;
    SuljeBtn: TButton;
    TulostaBtn: TButton;
    PvitaBtn: TButton;
    ComBx: TComboBoxXY;
    LabelNola1: TLabelNola;
    Rich: TRichEdit;
    Image: TImage;
    procedure FormShow(Sender: TObject);
    procedure SuljeBtnClick(Sender: TObject);
    procedure TulostaBtnClick(Sender: TObject);
    procedure ComBxChange(Sender: TObject);
    procedure ComBxExit(Sender: TObject);
    procedure PvitaBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RichMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  IkFrm: TIkFrm;

implementation

uses Globals, Y_, Unit1, Unit0, EdvNew, DetEv{PRC pirr‰ koetulostukseen}, Defs{Color_RED}, RichEdit{+12.0.02 CHARFORMAT2}, Vcl.Tabs;//.TTabSet;

{$R *.DFM}


CONST pii=3.141593;  ADJ=8;                                //<ADJ=Tekstin kohdistaminen vaakaviivaan.
VAR LEV, ORGX,ORGY, VMARG,OMARG,alpEDJ :integer;      
    qR,qX :real;
    qIk3v,qIk3t,qIk3d, qIk3d_0,tau_0,OFAvalIs :real; //<qIk3d_0 edellinen vas.palstan Ik3d -arvo -> korkeussuhde
    qHz,edja,OFAsul :integer;

procedure PvitaBtnEnabON;       begin IkFrm.PvitaBtn.Font.Style := [fsBold];
                                      IkFrm.PvitaBtn.Enabled := true;   end;
procedure PvitaBtnEnabOFF;      begin IkFrm.PvitaBtn.Font.Style := [];
                                      IkFrm.PvitaBtn.Enabled := false;  end;
procedure BoxBtnOn;      begin
   with IkFrm do begin
      LabelNola1.Visible := true;
      LabelNola1.Left :=    ORGX;
      ComBx.Visible :=      true;
    //ComBx.Left :=         LabelNola1.Left +70;
      PvitaBtn.Visible :=   true;
    //PvitaBtn.Left :=      ComBx.Left +53;
      PvitaBtn.Enabled :=   false;  end;  end; //< := TRUE vasta, jos muutoksia, ks. OnChange + OnExit
procedure BoxBtnOFF;      begin
   with IkFrm do begin
      LabelNola1.Visible := false;
      ComBx.Visible :=      false;
      PvitaBtn.Visible :=   false;  end;  end;
procedure BoxBtnEnabOFF;      begin
   with IkFrm do begin
      LabelNola1.Enabled := false;
      ComBx.Enabled :=      false;
      PvitaBtn.Enabled :=   false;  end;  end;

procedure sijoita (os :integer);      VAR ar :real;  i :integer; //,,Ks.  ..\EdvNj\EdvLaskSij26-INC

{  FUNCTION _Ik3t (ik3 :real) :real;      VAR ar,tiq :real;      begin
      ar := sys_ker (qR,qX);                         //<AR :ss‰ nyt SYSKERR, jota k‰ytet‰‰n j‰lempn‰ Ik3th :ssa
      tiq := 1;
      ar := m_tasav (ar,tiq);                        //<m_tasavKerroin = f(sysKerr,Aika). ARsys..arvo sij.aiemmin
      ar := ik3 * Sqrt ((ar +1)*tiq);                //<*TIQ, vaikka TIQ onkin nyt 1, varausta mahd. muutksiin
      Result := ar;
   END;}

   procedure TeeItems;      VAR   i,e,o :integer;      begin
      e := IkFrm.ComBx.ItemIndex;
      IkFrm.ComBx.Items.Clear;
      if edja>1
      then begin
         IkFrm.ComBx.Enabled := true;
         IkFrm.PvitaBtn.Enabled := true;
         o := 2;                                                                            //<,, +6.0.4
         for i := 2 to edja  do begin
            IkFrm.ComBx.Items.Add (fImrkt0 (i,1)   +'  = ' +fImrkt0 (i,1) +':n alussa');
            if i=os  then o := IkFrm.ComBx.Items.Count-1;  end;
         IkFrm.ComBx.Items.Add (fImrkt0 (edja+1,1) +'  = ' +fImrkt0 (edja,1) +':n lopussa');
        {i := os-2;
         if i<=0  then
            i := IkFrm.ComBx.Items.Count-1;}
         if e<0
         then IkFrm.ComBx.ItemIndex := o  //IkFrm.ComBx.Items.Count-1;
         else IkFrm.ComBx.ItemIndex := e;
      end
      else begin
         IkFrm.ComBx.Items.Add ('1');   //< 0->1 +6.0.4
         IkFrm.ComBx.Enabled := false;
         IkFrm.PvitaBtn.Enabled := false;
         IkFrm.ComBx.ItemIndex := 1;    //< +6.0.4
      end;
   end;//TeeItems

begin
{|} if os<edja+1                                      //< Edja+1 :ll‰ ilmaistiin, jos haluttiin laskea vikan loppuun.
      then i := os-1                                 //< i=JohdnAlussa
      else i := os;                                  //< i=JohdnLopussa (edja)
  {qIk3v := Iks (Ik3vTR, Ziks (3,i,NJkinFA, '',0,0,0,0, qR,qX,ar,ar)) /1000; //<FALSE=EiNj  3=MaxI JohdnLOPUSSA.
   qIk3t := _Ik3t (qIk3v);                                               //<,N‰iss‰ jo  /1000 huomioitu, ks. ed.
   qIk3d := qIk3v *Sqrt(2) * sys_ker (qR,qX);{|}

{|}Ziks (31,i,NJkinFA,0, '',0,0,0,0, qR,qX,ar,ar);   //< 31=Ik3v MaxI JohdnLOPUSSA.  qR,qX AIKA-AKSELIIN.!!!!
   if os=edja+1                                      //< Edja+1 :ll‰ ilmaistiin, jos haluttiin laskea vikan loppuun.
   then begin
      qIk3v :=  a_getReaa (60003, edv.NjL.Ik3v)/1000;
      qIk3t :=  a_getReaa (60003, edv.NjL.Ik3t)/1000;
      qIk3d :=  a_getReaa (60003, edv.NjL.Ik3d)/1000;
      OFAsul := a_getIntg (60003, edv.edka[edja].OfaVal); //<Ed.johto-osalla valittu OFAA -sulakekoko.
      OFAvalIs := edv.NjL.Ik3dOfaVal/1000;
      if OFAvalIs<0.0001  then                                                                  //<,+6.1.1
         OFAvalIs := a_getReaa (60003, edv.NjL.Ik3d)/1000; //<Jos eioo OFAvalIs => Ik3d
   end
   else begin
      qIk3v := edv.edka[os].arvo [arvo_IK3V_2]/1000;
      qIk3t := edv.edka[os].arvo [arvo_IK3T_3]/1000;
      qIk3d := edv.edka[os].arvo [arvo_IK3D_4]/1000;
      OFAsul := 0;
      if os>1  then
         OFAsul := a_getIntg (60003, edv.edka[os-1].OfaVal);
      OFAvalIs := edv.edka[os].arvoU[3]/1000; //<[3]=ValitunOFAAnRaj_Is  [1]=OFAAoikoSULraj_Is  [2]=Ik1vJohnAlussa
      if OFAvalIs<0.0001  then                                                                  //<,+6.1.1
         OFAvalIs := qIk3d;                   //<'Juuri edell‰ sijoitettiin.
   end;
                                             {| if os=0  then begin
                                                   qR := 0.00044;   qX := 0.0054;
                                                   qIk3v := 42.3;   qIk3t := 43.2;   qIk3d := 107.2;  end else
                                                begin
                                                   qR := 0.006;     qX := 0.0076;
                                                   qIk3v := 23.9;   qIk3t := 23.9;   qIk3d := 37.6;
                                                   IkFrm.ComBx.Enabled := false;
                                                   IkFrm.PvitaBtn.Enabled := false;  end;|}
   TeeItems;
end;//sijoita

//====================================================================================================================
{T‰m‰ KOEAJO-osa siirretty j‰lemp‰‰ 12.0.02:=========================================================================================
                   //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Kokeilua iToTim ja Ykerr :lla,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
                         //if i=0  then begin
                              Image.Canvas.Pen.Color := clLime;//clRed;
                              y := 1/qHz;
                              for i := 1 to jaksoja  do begin         //<,,Vaaka-akselin merkkiviivat
                                    PX := ORGX + pyor (i * y/iToTim);
                                    PX := PX-2;
                                    if i=jaksoja  then PX := PX-1;    //<Muuten vika ei n‰y, todettu
                                 Image.Canvas.MoveTo(PX,ORGY-5-5);                   //,,MerkkiViiva
                                 Image.Canvas.LineTo(PX,ORGY+5+5);                   //,,MerkkiViiva
                              end;
                                 y := Yker*qIk3d;                     //<,,Pystyakselin merkkiviiva
                                 y := y-2;
                                 py := fY(-1 *y);
                              Image.Canvas.MoveTo(ORGX-12,py);                       //,,MerkkiViiva
                              Image.Canvas.LineTo(ORGX+10,py);                       //< MerkkiViiva
                         //end;//}
//--------------------------------------------------------------------------------------------------
{              //========= i = ( V®2 U / Z)  [ cos(wt)             - exp (-t / T)      =MaxDC       ====INSKO====
               //========= i = ( V®2 U / Z)  [ cos(wt)             - exp (-t*w*R/X)    =MaxDC       ====OK=======
if ohj=1  then begin         DetEvFrm.aRich.AddText ('<br>w=' +fRmrkt0(w,5,3) +'  iTo=' +fRmrkt0 (iToTim,1,8)+
                              '  r/x='+fRmrkt0 (qR/qX,5,3) +'  Yker=' +fRmrkt0 (Yker,1,5)  +
                              '  0.02*iToTim=' +fRmrkt0 (0.02*iToTim,1,8) +
                            //'  Pii='+fRmrkt0 (Pii*180/Pii,1,1) +
                            //'  2Pii='+fRmrkt0 (2*Pii*180/Pii,1,1) +'  Pii/2='+fRmrkt0 (Pii/2 *180/Pii,1,1) +
                              '      dC= cosEroEdelliseen  dY= yyEroEdelliseen<br>');
i := 0;
repeat
   ar := 0;  ec := 0;  ey := 0;
   case i of
      0 :s := '   y := cos(x) -yy';
      1 :s := '   y := -1*(cos(x) -yy)';
      2 :s := '   y := -1*cos(x) -yy';  end;
   DetEvFrm.aRich.AddText (s +'<br>');
   repeat
      x := ar +alfa;                   //< [Rad]
      tim := ar/Pii*0.02;              //< ar ajaksi:   Pii = 180∞ = 10ms = 1 jakso
      yy := exp (-1* tim*w*qR/qX);     //< -t/T, T=L/R =X/(w*R) -> -t*w*R/X #####################################
      case i of
         0 :y := cos(x) -yy;
         1 :y := -1*(cos(x) -yy);         //< -1* koska origo on VasYlh‰‰ll‰ =KASVAA ALAS. ALKUPERƒINEN.!
      else  y := -1*cos(x) -yy;  end;
                           s := 'ar='+fRmrkt0(ar,1,6) +'='+fRmrkt0(RadToDeg(ar),1,2) +'∞ t'+fRmrkt0 (tim,1,4)+
                                ' x='+fRmrkt0(x,1,2) +'  c(x)=' +if0_RED(cos(x),1,4) +'  yy'+if0_RED(yy,1,4) +
                                '  y';// +if0_RED(y,1,4);
                                if (y<=0) and (y<=ey)  then s := s +COLOR_RED;  s := s +
                                fRmrkt0 (y,1,4) +'</f>';  //'Punaiseksi taas kun Y alkaa kasvaa.
                                if (ec<>0) and (ey<>0)  then s := s +  //<Muuten ERROR. Erot edellisiin PISTEISIIN.
                                '  dC='+if0_BLU(cos(x)-ec,1,4) +'='+if0_BLU((cos(x)-ec)/ec *100,1,2) +'%'+
                                ' dY='+if0_BLU(y-ey,1,8)     +'='+if0_BLU((y-ey)/ey *100,1,3) +'% ';
                                //'ci[∞]='+fRmrkt0 (RadToDeg(ar),1,5) +'<br>'); //< ar*180/Pii = Rad asteina
                                DetEvFrm.aRich.AddText (s +'<br>');
                               //if Pyor(RadToDeg (ar))=90  then DetEvFrm.aRich.AddText ('^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^90∞huippu/k‰‰nne<br>');
      ey := y;              //< Edellinen talteen.
      ec := cos(x);         //< Edellinen talteen.

      ar := ar+pii/40;
 //until ar>=pii/2 +pii/10;
   until RadToDeg (ar)>=370;//150;95;
   DetEvFrm.aRich.AddText ('<br>');
   i := i+1;
until i>=1;//2;3;
end;//}
{     y := cos(x) -yy   ja  y := -1*(cos(x) -yy)   ero VAIN sarakkeessa y=..,,,,,,,,, ETUMERKKI !!! .....................
.........................................................................................................................
w=314.159  iTo=0.00023810  r/x=0.123  Yker=1.60909  0.02*iToTim=0.00000476      dC= cosEroEdelliseen  dY= yyEroEdelliseen
   y := cos(x) -yy
ar=0.000000=0.00∞ t0.0000 x=0.00  c(x)=1.0000  yy1.0000  y0.0000
ar=0.078540=4.50∞ t0.0005 x=0.08  c(x)=0.9969  yy0.9808  y0.0161
ar=0.157080=9.00∞ t0.0010 x=0.16  c(x)=0.9877  yy0.9620  y0.0257  dC=-0.0092=-0.93% dY=0.00957384=59.510%
ar=0.235619=13.50∞ t0.0015 x=0.24  c(x)=0.9724  yy0.9436  y0.0288  dC=-0.0153=-1.55% dY=0.00312395=12.174%
ar=0.314159=18.00∞ t0.0020 x=0.31  c(x)=0.9511  yy0.9255  y0.0256  dC=-0.0213=-2.19% dY=-0.00322458=-11.202%
ar=0.392699=22.50∞ t0.0025 x=0.39  c(x)=0.9239  yy0.9078  y0.0161  dC=-0.0272=-2.86% dY=-0.00943493=-36.912%
ar=0.471239=27.00∞ t0.0030 x=0.47  c(x)=0.8910  yy0.8904  y0.0007  dC=-0.0329=-3.56% dY=-0.01547108=-95.939%
ar=0.549779=31.50∞ t0.0035 x=0.55  c(x)=0.8526  yy0.8733  y-0.0206  dC=-0.0384=-4.31% dY=-0.02129803=-3252.248%
ar=0.628319=36.00∞ t0.0040 x=0.63  c(x)=0.8090  yy0.8565  y-0.0475  dC=-0.0436=-5.12% dY=-0.02688205=130.223%
ar=0.706858=40.50∞ t0.0045 x=0.71  c(x)=0.7604  yy0.8401  y-0.0797  dC=-0.0486=-6.01% dY=-0.03219084=67.734%
ar=0.785398=45.00∞ t0.0050 x=0.79  c(x)=0.7071  yy0.8240  y-0.1169  dC=-0.0533=-7.01% dY=-0.03719378=46.658%
ar=0.863938=49.50∞ t0.0055 x=0.86  c(x)=0.6494  yy0.8082  y-0.1588  dC=-0.0577=-8.15% dY=-0.04186207=35.807%
ar=0.942478=54.00∞ t0.0060 x=0.94  c(x)=0.5878  yy0.7927  y-0.2049  dC=-0.0617=-9.49% dY=-0.04616896=29.079%
ar=1.021018=58.50∞ t0.0065 x=1.02  c(x)=0.5225  yy0.7775  y-0.2550  dC=-0.0653=-11.11% dY=-0.05008988=24.441%
ar=1.099558=63.00∞ t0.0070 x=1.10  c(x)=0.4540  yy0.7626  y-0.3086  dC=-0.0685=-13.11% dY=-0.05360258=21.018%
ar=1.178097=67.50∞ t0.0075 x=1.18  c(x)=0.3827  yy0.7480  y-0.3653  dC=-0.0713=-15.71% dY=-0.05668733=18.367%
ar=1.256637=72.00∞ t0.0080 x=1.26  c(x)=0.3090  yy0.7337  y-0.4246  dC=-0.0737=-19.25% dY=-0.05932696=16.240%
ar=1.335177=76.50∞ t0.0085 x=1.34  c(x)=0.2334  yy0.7196  y-0.4862  dC=-0.0756=-24.46% dY=-0.06150705=14.484%
ar=1.413717=81.00∞ t0.0090 x=1.41  c(x)=0.1564  yy0.7058  y-0.5494  dC=-0.0770=-32.99% dY=-0.06321594=13.003%
ar=1.492257=85.50∞ t0.0095 x=1.49  c(x)=0.0785  yy0.6923  y-0.6138  dC=-0.0780=-49.85% dY=-0.06444486=11.731%
ar=1.570796=90.00∞ t0.0100 x=1.57  c(x)=-0.0000  yy0.6790  y-0.6790  dC=-0.0785=-100.00% dY=-0.06518797=10.620%
ar=1.649336=94.50∞ t0.0105 x=1.65  c(x)=-0.0785  yy0.6660  y-0.7444  dC=-0.0785=45298378.82% dY=-0.06544238=9.638%
ar=1.727876=99.00∞ t0.0110 x=1.73  c(x)=-0.1564  yy0.6532  y-0.8097  dC=-0.0780=99.38% dY=-0.06520819=8.759%
ar=1.806416=103.50∞ t0.0115 x=1.81  c(x)=-0.2334  yy0.6407  y-0.8741  dC=-0.0770=49.23% dY=-0.06448847=7.965%
ar=1.884956=108.00∞ t0.0120 x=1.88  c(x)=-0.3090  yy0.6284  y-0.9374  dC=-0.0756=32.37% dY=-0.06328926=7.240%
ar=1.963496=112.50∞ t0.0125 x=1.96  c(x)=-0.3827  yy0.6164  y-0.9991  dC=-0.0737=23.84% dY=-0.06161952=6.573%
ar=2.042035=117.00∞ t0.0130 x=2.04  c(x)=-0.4540  yy0.6046  y-1.0585  dC=-0.0713=18.63% dY=-0.05949109=5.955%
ar=2.120575=121.50∞ t0.0135 x=2.12  c(x)=-0.5225  yy0.5930  y-1.1155  dC=-0.0685=15.09% dY=-0.05691861=5.377%
ar=2.199115=126.00∞ t0.0140 x=2.20  c(x)=-0.5878  yy0.5816  y-1.1694  dC=-0.0653=12.50% dY=-0.05391940=4.834%
ar=2.277655=130.50∞ t0.0145 x=2.28  c(x)=-0.6494  yy0.5704  y-1.2199  dC=-0.0617=10.49% dY=-0.05051342=4.320%
ar=2.356195=135.00∞ t0.0150 x=2.36  c(x)=-0.7071  yy0.5595  y-1.2666  dC=-0.0577=8.88% dY=-0.04672309=3.830%
ar=2.434735=139.50∞ t0.0155 x=2.43  c(x)=-0.7604  yy0.5488  y-1.3092  dC=-0.0533=7.54% dY=-0.04257318=3.361%
ar=2.513274=144.00∞ t0.0160 x=2.51  c(x)=-0.8090  yy0.5383  y-1.3473  dC=-0.0486=6.39% dY=-0.03809065=2.909%
ar=2.591814=148.50∞ t0.0165 x=2.59  c(x)=-0.8526  yy0.5279  y-1.3806  dC=-0.0436=5.39% dY=-0.03330446=2.472%
ar=2.670354=153.00∞ t0.0170 x=2.67  c(x)=-0.8910  yy0.5178  y-1.4088  dC=-0.0384=4.50% dY=-0.02824546=2.046%
ar=2.748894=157.50∞ t0.0175 x=2.75  c(x)=-0.9239  yy0.5079  y-1.4318  dC=-0.0329=3.69% dY=-0.02294613=1.629%
ar=2.827434=162.00∞ t0.0180 x=2.83  c(x)=-0.9511  yy0.4982  y-1.4492  dC=-0.0272=2.94% dY=-0.01744041=1.218%
ar=2.905974=166.50∞ t0.0185 x=2.91  c(x)=-0.9724  yy0.4886  y-1.4610  dC=-0.0213=2.24% dY=-0.01176348=0.812%
ar=2.984513=171.00∞ t0.0190 x=2.98  c(x)=-0.9877  yy0.4792  y-1.4669  dC=-0.0153=1.58% dY=-0.00595157=0.407%
ar=3.063053=175.50∞ t0.0195 x=3.06  c(x)=-0.9969  yy0.4701  y-1.4670  dC=-0.0092=0.93% dY=-0.00004170=0.003%
ar=3.141593=180.00∞ t0.0200 x=3.14  c(x)=-1.0000  yy0.4610  y-1.4610  dC=-0.0031=0.31% dY=0.00592850=-0.404%
ar=3.220133=184.50∞ t0.0205 x=3.22  c(x)=-0.9969  yy0.4522  y-1.4491  dC=0.0031=-0.31% dY=0.01192109=-0.816%
ar=3.298673=189.00∞ t0.0210 x=3.30  c(x)=-0.9877  yy0.4435  y-1.4312  dC=0.0092=-0.93% dY=0.01789798=-1.235%
ar=3.377212=193.50∞ t0.0215 x=3.38  c(x)=-0.9724  yy0.4350  y-1.4074  dC=0.0153=-1.55% dY=0.02382122=-1.664%
ar=3.455752=198.00∞ t0.0220 x=3.46  c(x)=-0.9511  yy0.4267  y-1.3778  dC=0.0213=-2.19% dY=0.02965321=-2.107%
ar=3.534292=202.50∞ t0.0225 x=3.53  c(x)=-0.9239  yy0.4185  y-1.3424  dC=0.0272=-2.86% dY=0.03535691=-2.566%
ar=3.612832=207.00∞ t0.0230 x=3.61  c(x)=-0.8910  yy0.4105  y-1.3015  dC=0.0329=-3.56% dY=0.04089612=-3.047%
ar=3.691372=211.50∞ t0.0235 x=3.69  c(x)=-0.8526  yy0.4026  y-1.2553  dC=0.0384=-4.31% dY=0.04623567=-3.552%
ar=3.769912=216.00∞ t0.0240 x=3.77  c(x)=-0.8090  yy0.3949  y-1.2039  dC=0.0436=-5.12% dY=0.05134162=-4.090%
ar=3.848451=220.50∞ t0.0245 x=3.85  c(x)=-0.7604  yy0.3873  y-1.1477  dC=0.0486=-6.01% dY=0.05618152=-4.667%
ar=3.926991=225.00∞ t0.0250 x=3.93  c(x)=-0.7071  yy0.3799  y-1.0870  dC=0.0533=-7.01% dY=0.06072454=-5.291%
ar=4.005531=229.50∞ t0.0255 x=4.01  c(x)=-0.6494  yy0.3726  y-1.0221  dC=0.0577=-8.15% dY=0.06494175=-5.974%
ar=4.084071=234.00∞ t0.0260 x=4.08  c(x)=-0.5878  yy0.3655  y-0.9533  dC=0.0617=-9.49% dY=0.06880619=-6.732%
ar=4.162611=238.50∞ t0.0265 x=4.16  c(x)=-0.5225  yy0.3585  y-0.8810  dC=0.0653=-11.11% dY=0.07229314=-7.584%
ar=4.241151=243.00∞ t0.0270 x=4.24  c(x)=-0.4540  yy0.3516  y-0.8056  dC=0.0685=-13.11% dY=0.07538020=-8.556%
ar=4.319690=247.50∞ t0.0275 x=4.32  c(x)=-0.3827  yy0.3449  y-0.7275  dC=0.0713=-15.71% dY=0.07804746=-9.688%
ar=4.398230=252.00∞ t0.0280 x=4.40  c(x)=-0.3090  yy0.3383  y-0.6473  dC=0.0737=-19.25% dY=0.08027761=-11.034%
ar=4.476770=256.50∞ t0.0285 x=4.48  c(x)=-0.2334  yy0.3318  y-0.5652  dC=0.0756=-24.46% dY=0.08205607=-12.677%
ar=4.555310=261.00∞ t0.0290 x=4.56  c(x)=-0.1564  yy0.3254  y-0.4818  dC=0.0770=-32.99% dY=0.08337102=-14.750%
ar=4.633850=265.50∞ t0.0295 x=4.63  c(x)=-0.0785  yy0.3192  y-0.3976  dC=0.0780=-49.85% dY=0.08421357=-17.477%
ar=4.712389=270.00∞ t0.0300 x=4.71  c(x)=0.0000  yy0.3131  y-0.3131  dC=0.0785=-100.00% dY=0.08457770=-21.271%
ar=4.790929=274.50∞ t0.0305 x=4.79  c(x)=0.0785  yy0.3071  y-0.2286  dC=0.0785=15099459.41% dY=0.08446040=-26.980%
ar=4.869469=279.00∞ t0.0310 x=4.87  c(x)=0.1564  yy0.3012  y-0.1447  dC=0.0780=99.38% dY=0.08386162=-36.686%
ar=4.948009=283.50∞ t0.0315 x=4.95  c(x)=0.2334  yy0.2954  y-0.0619  dC=0.0770=49.23% dY=0.08278431=-57.200%
ar=5.026549=288.00∞ t0.0320 x=5.03  c(x)=0.3090  yy0.2897  y0.0193  dC=0.0756=32.37% dY=0.08123436=-131.141%
ar=5.105089=292.50∞ t0.0325 x=5.11  c(x)=0.3827  yy0.2842  y0.0985  dC=0.0737=23.84% dY=0.07922061=410.685%
ar=5.183628=297.00∞ t0.0330 x=5.18  c(x)=0.4540  yy0.2787  y0.1753  dC=0.0713=18.63% dY=0.07675476=77.915%
ar=5.262168=301.50∞ t0.0335 x=5.26  c(x)=0.5225  yy0.2734  y0.2491  dC=0.0685=15.09% dY=0.07385132=42.137%
ar=5.340708=306.00∞ t0.0340 x=5.34  c(x)=0.5878  yy0.2681  y0.3196  dC=0.0653=12.50% dY=0.07052750=28.311%
ar=5.419248=310.50∞ t0.0345 x=5.42  c(x)=0.6494  yy0.2630  y0.3864  dC=0.0617=10.49% dY=0.06680314=20.899%
ar=5.497788=315.00∞ t0.0350 x=5.50  c(x)=0.7071  yy0.2580  y0.4491  dC=0.0577=8.88% dY=0.06270053=16.225%
ar=5.576328=319.50∞ t0.0355 x=5.58  c(x)=0.7604  yy0.2530  y0.5074  dC=0.0533=7.54% dY=0.05824432=12.968%
ar=5.654867=324.00∞ t0.0360 x=5.65  c(x)=0.8090  yy0.2482  y0.5609  dC=0.0486=6.39% dY=0.05346136=10.537%
ar=5.733407=328.50∞ t0.0365 x=5.73  c(x)=0.8526  yy0.2434  y0.6092  dC=0.0436=5.39% dY=0.04838052=8.626%
ar=5.811947=333.00∞ t0.0370 x=5.81  c(x)=0.8910  yy0.2387  y0.6523  dC=0.0384=4.50% dY=0.04303251=7.063%
ar=5.890487=337.50∞ t0.0375 x=5.89  c(x)=0.9239  yy0.2342  y0.6897  dC=0.0329=3.69% dY=0.03744970=5.741%
ar=5.969027=342.00∞ t0.0380 x=5.97  c(x)=0.9511  yy0.2297  y0.7214  dC=0.0272=2.94% dY=0.03166593=4.591%
ar=6.047567=346.50∞ t0.0385 x=6.05  c(x)=0.9724  yy0.2253  y0.7471  dC=0.0213=2.24% dY=0.02571630=3.565%
ar=6.126106=351.00∞ t0.0390 x=6.13  c(x)=0.9877  yy0.2210  y0.7667  dC=0.0153=1.58% dY=0.01963690=2.628%
ar=6.204646=355.50∞ t0.0395 x=6.20  c(x)=0.9969  yy0.2167  y0.7802  dC=0.0092=0.93% dY=0.01346469=1.756%
ar=6.283186=360.00∞ t0.0400 x=6.28  c(x)=1.0000  yy0.2126  y0.7874  dC=0.0031=0.31% dY=0.00723716=0.928%
ar=6.361726=364.50∞ t0.0405 x=6.36  c(x)=0.9969  yy0.2085  y0.7884  dC=-0.0031=-0.31% dY=0.00099218=0.126%
ar=6.440266=369.00∞ t0.0410 x=6.44  c(x)=0.9877  yy0.2045  y0.7832  dC=-0.0092=-0.93% dY=-0.00523226=-0.664%

   y := -1*(cos(x) -yy)
ar=0.000000=0.00∞ t=0.0000 x=0.00  c(x)=1.0000  yy=1.0000  c(x)-yy=0.0000  y=-0.0000
ar=0.078540=4.50∞ t=0.0005 x=0.08  c(x)=0.9969  yy=0.9808  c(x)-yy=0.0161  y=-0.0161  dC=-0.0031=-0.31% dY=-0.01917033=-1.917%
ar=0.157080=9.00∞ t=0.0010 x=0.16  c(x)=0.9877  yy=0.9620  c(x)-yy=0.0257  y=-0.0257  dC=-0.0092=-0.93% dY=-0.01880283=-1.917%
ar=0.235619=13.50∞ t=0.0015 x=0.24  c(x)=0.9724  yy=0.9436  c(x)-yy=0.0288  y=-0.0288  dC=-0.0153=-1.55% dY=-0.01844238=-1.917%
ar=0.314159=18.00∞ t=0.0020 x=0.31  c(x)=0.9511  yy=0.9255  c(x)-yy=0.0256  y=-0.0256  dC=-0.0213=-2.19% dY=-0.01808883=-1.917%
ar=0.392699=22.50∞ t=0.0025 x=0.39  c(x)=0.9239  yy=0.9078  c(x)-yy=0.0161  y=-0.0161  dC=-0.0272=-2.86% dY=-0.01774206=-1.917%
ar=0.471239=27.00∞ t=0.0030 x=0.47  c(x)=0.8910  yy=0.8904  c(x)-yy=0.0007  y=-0.0007  dC=-0.0329=-3.56% dY=-0.01740194=-1.917%
ar=0.549779=31.50∞ t=0.0035 x=0.55  c(x)=0.8526  yy=0.8733  c(x)-yy=-0.0206  y=0.0206  dC=-0.0384=-4.31% dY=-0.01706834=-1.917%
ar=0.628319=36.00∞ t=0.0040 x=0.63  c(x)=0.8090  yy=0.8565  c(x)-yy=-0.0475  y=0.0475  dC=-0.0436=-5.12% dY=-0.01674113=-1.917%
ar=0.706858=40.50∞ t=0.0045 x=0.71  c(x)=0.7604  yy=0.8401  c(x)-yy=-0.0797  y=0.0797  dC=-0.0486=-6.01% dY=-0.01642020=-1.917%
ar=0.785398=45.00∞ t=0.0050 x=0.79  c(x)=0.7071  yy=0.8240  c(x)-yy=-0.1169  y=0.1169  dC=-0.0533=-7.01% dY=-0.01610542=-1.917%
ar=0.863938=49.50∞ t=0.0055 x=0.86  c(x)=0.6494  yy=0.8082  c(x)-yy=-0.1588  y=0.1588  dC=-0.0577=-8.15% dY=-0.01579667=-1.917%
ar=0.942478=54.00∞ t=0.0060 x=0.94  c(x)=0.5878  yy=0.7927  c(x)-yy=-0.2049  y=0.2049  dC=-0.0617=-9.49% dY=-0.01549384=-1.917%
ar=1.021018=58.50∞ t=0.0065 x=1.02  c(x)=0.5225  yy=0.7775  c(x)-yy=-0.2550  y=0.2550  dC=-0.0653=-11.11% dY=-0.01519682=-1.917%
ar=1.099558=63.00∞ t=0.0070 x=1.10  c(x)=0.4540  yy=0.7626  c(x)-yy=-0.3086  y=0.3086  dC=-0.0685=-13.11% dY=-0.01490549=-1.917%
ar=1.178097=67.50∞ t=0.0075 x=1.18  c(x)=0.3827  yy=0.7480  c(x)-yy=-0.3653  y=0.3653  dC=-0.0713=-15.71% dY=-0.01461975=-1.917%
ar=1.256637=72.00∞ t=0.0080 x=1.26  c(x)=0.3090  yy=0.7337  c(x)-yy=-0.4246  y=0.4246  dC=-0.0737=-19.25% dY=-0.01433949=-1.917%
ar=1.335177=76.50∞ t=0.0085 x=1.34  c(x)=0.2334  yy=0.7196  c(x)-yy=-0.4862  y=0.4862  dC=-0.0756=-24.46% dY=-0.01406459=-1.917%
ar=1.413717=81.00∞ t=0.0090 x=1.41  c(x)=0.1564  yy=0.7058  c(x)-yy=-0.5494  y=0.5494  dC=-0.0770=-32.99% dY=-0.01379497=-1.917%
ar=1.492257=85.50∞ t=0.0095 x=1.49  c(x)=0.0785  yy=0.6923  c(x)-yy=-0.6138  y=0.6138  dC=-0.0780=-49.85% dY=-0.01353052=-1.917%
ar=1.570796=90.00∞ t=0.0100 x=1.57  c(x)=-0.0000  yy=0.6790  c(x)-yy=-0.6790  y=0.6790  dC=-0.0785=-100.00% dY=-0.01327113=-1.917%
ar=1.649336=94.50∞ t=0.0105 x=1.65  c(x)=-0.0785  yy=0.6660  c(x)-yy=-0.7444  y=0.7444  dC=-0.0785=45298378.82% dY=-0.01301672=-1.917%

   y := -1*cos(x) -yy
ar=0.000000=0.00∞ t=0.0000 x=0.00  c(x)=1.0000  yy=1.0000  c(x)-yy=0.0000  y=-2.0000
ar=0.078540=4.50∞ t=0.0005 x=0.08  c(x)=0.9969  yy=0.9808  c(x)-yy=0.0161  y=-1.9777  dC=-0.0031=-0.31% dY=-0.01917033=-1.917%
ar=0.157080=9.00∞ t=0.0010 x=0.16  c(x)=0.9877  yy=0.9620  c(x)-yy=0.0257  y=-1.9497  dC=-0.0092=-0.93% dY=-0.01880283=-1.917%
ar=0.235619=13.50∞ t=0.0015 x=0.24  c(x)=0.9724  yy=0.9436  c(x)-yy=0.0288  y=-1.9160  dC=-0.0153=-1.55% dY=-0.01844238=-1.917%
ar=0.314159=18.00∞ t=0.0020 x=0.31  c(x)=0.9511  yy=0.9255  c(x)-yy=0.0256  y=-1.8766  dC=-0.0213=-2.19% dY=-0.01808883=-1.917%
ar=0.392699=22.50∞ t=0.0025 x=0.39  c(x)=0.9239  yy=0.9078  c(x)-yy=0.0161  y=-1.8316  dC=-0.0272=-2.86% dY=-0.01774206=-1.917%
ar=0.471239=27.00∞ t=0.0030 x=0.47  c(x)=0.8910  yy=0.8904  c(x)-yy=0.0007  y=-1.7814  dC=-0.0329=-3.56% dY=-0.01740194=-1.917%
ar=0.549779=31.50∞ t=0.0035 x=0.55  c(x)=0.8526  yy=0.8733  c(x)-yy=-0.0206  y=-1.7259  dC=-0.0384=-4.31% dY=-0.01706834=-1.917%
ar=0.628319=36.00∞ t=0.0040 x=0.63  c(x)=0.8090  yy=0.8565  c(x)-yy=-0.0475  y=-1.6656  dC=-0.0436=-5.12% dY=-0.01674113=-1.917%
ar=0.706858=40.50∞ t=0.0045 x=0.71  c(x)=0.7604  yy=0.8401  c(x)-yy=-0.0797  y=-1.6005  dC=-0.0486=-6.01% dY=-0.01642020=-1.917%
ar=0.785398=45.00∞ t=0.0050 x=0.79  c(x)=0.7071  yy=0.8240  c(x)-yy=-0.1169  y=-1.5311  dC=-0.0533=-7.01% dY=-0.01610542=-1.917%
ar=0.863938=49.50∞ t=0.0055 x=0.86  c(x)=0.6494  yy=0.8082  c(x)-yy=-0.1588  y=-1.4577  dC=-0.0577=-8.15% dY=-0.01579667=-1.917%
ar=0.942478=54.00∞ t=0.0060 x=0.94  c(x)=0.5878  yy=0.7927  c(x)-yy=-0.2049  y=-1.3805  dC=-0.0617=-9.49% dY=-0.01549384=-1.917%
ar=1.021018=58.50∞ t=0.0065 x=1.02  c(x)=0.5225  yy=0.7775  c(x)-yy=-0.2550  y=-1.3000  dC=-0.0653=-11.11% dY=-0.01519682=-1.917%
ar=1.099558=63.00∞ t=0.0070 x=1.10  c(x)=0.4540  yy=0.7626  c(x)-yy=-0.3086  y=-1.2166  dC=-0.0685=-13.11% dY=-0.01490549=-1.917%
ar=1.178097=67.50∞ t=0.0075 x=1.18  c(x)=0.3827  yy=0.7480  c(x)-yy=-0.3653  y=-1.1307  dC=-0.0713=-15.71% dY=-0.01461975=-1.917%
ar=1.256637=72.00∞ t=0.0080 x=1.26  c(x)=0.3090  yy=0.7337  c(x)-yy=-0.4246  y=-1.0427  dC=-0.0737=-19.25% dY=-0.01433949=-1.917%
ar=1.335177=76.50∞ t=0.0085 x=1.34  c(x)=0.2334  yy=0.7196  c(x)-yy=-0.4862  y=-0.9530  dC=-0.0756=-24.46% dY=-0.01406459=-1.917%
ar=1.413717=81.00∞ t=0.0090 x=1.41  c(x)=0.1564  yy=0.7058  c(x)-yy=-0.5494  y=-0.8622  dC=-0.0770=-32.99% dY=-0.01379497=-1.917%
ar=1.492257=85.50∞ t=0.0095 x=1.49  c(x)=0.0785  yy=0.6923  c(x)-yy=-0.6138  y=-0.7707  dC=-0.0780=-49.85% dY=-0.01353052=-1.917%
ar=1.570796=90.00∞ t=0.0100 x=1.57  c(x)=-0.0000  yy=0.6790  c(x)-yy=-0.6790  y=-0.6790  dC=-0.0785=-100.00% dY=-0.01327113=-1.917%
ar=1.649336=94.50∞ t=0.0105 x=1.65  c(x)=-0.0785  yy=0.6660  c(x)-yy=-0.7444  y=-0.5875  dC=-0.0785=45298378.82% dY=-0.01301672=-1.917%
}
//--------------------------------------------------------------------------------------------------
(* for i := 0 to LEV  do begin
      x := w* i*iToTim +alfa;           //KOE y := exp (-1* i/100);  //    y := exp (-1* i*w*qR/qX);
      if qX>0
         then y := exp (-1* w* i*iToTim *qR/qX)  //< -t/T, T=R/w*X -> -w*t*R/X #################################
         else y := 0;                            //'y := 0 jottei ERROR
      y := Yker*qIk3v *Sqrt(2) *(cos(x) -y);
    //y := Yker*qIk3v *Sqrt(2) *cos(x) *0.5;               //<NSSsuunOhje sinik‰yr‰
      py := fY(y);                        //' -1 koska origo on vy eik‰Alhaallaa =KASVAA ALAS. y:=0 jottei ERROR
      if i=0  then Image.Canvas.MoveTo(ORGX+i,py)  //< i>0 = ''Seuraavaksi LineTo
              else Image.Canvas.LineTo(ORGX+i,py);
   end;*)

               //,OHJ =0 =K‰yr‰t liittym‰pisteelle   >0=Johto-osa n:o OHJ:lle ########################################
procedure piirra (ohj :integer);      CONST cr=18;  selRvja=11; //<cr=Riviv‰li.  selRvja = K‰yr‰n alap:n txtRivit
                                      VAR x,y,yy, iToTim,alfa,w,Yker, ar,{ey,ec,{}tim :real;
                                          jaksoja,t,i,ii, oh, px,py, ax,bx  :integer;   s :string;
   function fY (y :real) :integer;      begin
      result := trunc (y) +ORGY;  end;

   procedure pyyhiPohja;      VAR   vx,vy :integer;  ARect: TRect;      begin
                           //Copy1Click(Sender);                      // copy picture to Clipboard
      with IkFrm.Image.Canvas do
      begin
         CopyMode := cmWhiteness;	              // copy everything as white
         vx := VMARG;  vy := 0;
         ARect := Rect(vx,vy, IkFrm.Image.Width, IkFrm.Image.Height); // get bitmap rectangle
         CopyRect(ARect, IkFrm.Image.Canvas, ARect);	                // copy bitmap over itself
         CopyMode := cmSrcCopy;	                 // restore normal mode (Ei tarvetta kyll‰k‰‰n)
      end;
   end;

   function f_kA (r :real) :string;      VAR des :integer;  s :string;      begin //< r [kA] !!!!!!!!!!!!!!!!!!!!!
     {if r>9.95   then des := 1  else
      if r>0.95   then des := 2  else
                       des := 3;
      if des=3  then s := fDemRx (1, r*1000,1,0) +' A'
                else s := fDemRx (1, r,1,des) +' kA';
      if des=3  then s := fDemRx (1, r*1000,1,0) +' A'
                else s := fDemRx (1, r,1,des) +' kA';}
     {if fMuokDes (r,1) >= 100   then des := 1  else   //<,,6.0.4
      if fMuokDes (r,2) >= 10    then des := 2  else
      if fMuokDes (r,3) >= 1     then des := 3  else
                                      des := 4;
      if des=4  then s := fDemRx (1, r*1000,1,0) +' A'
                else s := fDemRx (1, r,1,des) +' kA';}
      if fMuokDes (r,3) < 1    then des := 99  else   // 0.9999 -> 999 A   ,,6.0.4
      if fMuokDes (r,3) < 10   then des := 3   else   // 9.9994 -> 9.999 kA
      if fMuokDes (r,2) < 100  then des := 2   else   // 99.994 -> 99.99 kA
      if fMuokDes (r,1) < 1000 then des := 1   else   // 999.94 -> 999.9 kA
                                    des := 0;         // 999.94 -> 999 kA
      if des=99  then s := fDemRx (1, r*1000,1,0) +' A'
                 else s := fDemRx (1, r,1,des) +' kA';
      result := s;
   end;//f_kA
   //-----------------------------------------------------------------------------------------------
   {Muokkaa AR tai BR :n 3:lle MERKITSEVƒlle no:lle ja m‰‰ritt‰‰ DIMensioliitteen isomman (TƒRKEƒMMƒN) luvun mk.
    IDEA: - Etsit‰‰n DEKadit -12(piko)...9(Tera) joilla alp. luku jaettuna tai kerrottuna antaa halutun ESITYSLUVUN,
            joka saadaan:  R := R * power(10,-1*DEK), eli R kerrotaan 10 potsiin -DEK, kun R>=1 ja DEK, kun R<1.
          - Kerroin -1 muuttaa DEkadin etumerkin siten, ett‰ negat.DEK muuttuu posit:ksi ja posit. neg:ksi =JAKOLASKU.
    HUOM: - Suurin ero luvuilla AR ja BR voi olla 3 dekadia, jotka viel‰ n‰kyy, mutta:  999.5=1.00 k ja 0.999=0.00 k.
                           0.000'678'34    = 6.78*10pot(-4) -> 678 *10pot(-6) = 678m
                           0.000'067'834   = 6.78*10pot(-5) -> 67.8*10pot(-6) = 67.8m
                           0.000'000'67834 = 6.8 *10pot(-7) -> 0.60*10pot(-9) = 0.68u
                           6.7834 -> 6.78,   67'834 -> 67.8k = 6.78*10pot(4),
                           678'400'000' -> 678M = 6.78*10pot(8)
           ohj 1=Eka  2=Toka str:ksi ISOMMAN DEKADIEN MUK.  3=VAIN etuliite 'u','m','k' tai 'M'......................}
   function fDim3 (AR,BR :real;  ohj :integer) :string;
                                       //,,DEK:   Esim. 0.068743 = 68.743*10pot(DEK), miss‰ DEK = -3 (3:n jaolla !!!!}
                             VAR r :real;  dek,dekA,dekB, des,desA,desB :integer;  s,dim :string;
      procedure tutki (z :real);      VAR i,d,n,mja :integer;  ra :real;  ss :string;      begin
         ss := fRmrkt0 (z,1,12); //<Pienin n‰kyv‰ arvo:  0.000'000'000'000 = 1 piko
         mja := Length (ss);     //                          m   u   n   p'''''''''''''''''''''''''''
         d := 1;
         while (mja>0) and (d<mja) and (ss[d]<>'.')  do d := d+1; //<Etsit‰‰n desimn paikka =d  1414d: +(mja>0)

         if (ss<>'') and (ss[1]='0')  then begin //<,,Luvun arvo < 1 ################################################################
            n := 0;
            for i := d+1 to mja  do                    //<,Etsit‰‰n vika '0' -> eka merkitsv‰ no = s[d+1], vrt. 0.0067
               if ss[i]='0'  then n := n+1             //<Lasketaan desimn j‰lkeiset '0'.  ,,Break =Lˆytyi vika '0'
                             else Break;
            dek := n+3;                                //< Ekan n‰kyv‰n n:on dekadi =n+1,  vikan 3 n‰kyv‰n = n+3
            des := dek MOD 3;                          //',Esim. 0.006¥874 = 6.874*10pot(dek), miss‰ dek = -3
            dek := dek-des;                            //',0.006¥786¥12  -> dek=3 des=2 -> 6.79m  desMax=2
            dek := -1 *dek;                            //',0.000¥067¥86  -> dek=6 des=1 -> 67.9n
         end                                           //' 0.000¥678¥61  -> dek=6 des=0 -> 679n
         else begin //<,,Luvun arvo >= 1 #############################################################################
            n := d-1;                                  //, Ekan n‰kyv‰n n:on dekadi =1,  vika kokon.osan =d-1
            if (ss<>'') and (ss[1]='-') then n := n-1; //<"Korjataan" mahd. etumerkin vaikutus
            dek := ((n-1) DIV 3) *3;                   //< Koska D oli sen sijainti SS:ss‰:  68.74xxx -> d=3 -->2
            des := dek+3 -n;                           //',Esim. 6.874 = 6.87*10pot(0), miss‰ dek = 0
               ra := power(10,dek);                    //', 6¥786¥435.2   -> dek=6 des=2 -> 6.79M  desMax=2
               ss := fRmrkt0( z/ra, 1,0);         //<Muutetaan stringiksi ESITETTƒVƒ KOKONAUSLUKUosa
               SokR (ss,ra);                      //<..ja takas luvuksi, jossa vain kokon.osa, jota
            if ra>=1000  then begin               //,,,testataan,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
               dek := dek+3;
               des := 2;  end;
         end;
      end;//tutki

      procedure vrtDekDes (dekV,desV :integer;  VAR dek,des :integer);      begin //<dek,des muuttuu jos aihetta #####
         if dekV>dek  then begin                                        //<Pienpi DEK = ISOMPI LUKU ##################
            dek := dekV;  des := 2;   end;                              //<Ekspon niin, ett‰ DIMENSIO ISOMMAN MUK.
      end;//vrtDekDes
   begin//fDim3.....................................................................................
      tutki (AR);   dekA := dek;   desA := des;
      tutki (BR);   dekB := dek;   desB := des;
      r := 0;                          //,,###########################################################################
      case ohj of                      //,,Luvut muokataan niin, ett‰ VAIN 3 NOA NƒKYY =DEK k‰‰nteisarvoksi ##########
{AR}     1  :begin r := AR;            //,,###########################################################################
                   dek := dekA;
                   des := desA;
                   if BR>AR  then vrtDekDes (dekB,desB, dek,des);       //<Muutetaan luku isomman DIM mukaiseksi #####
                   r := r * power (10,-1*dek);                          //<K‰‰nnet‰‰n eksponentti + -> - tai + -> -
             end;
{BR}     2  :begin r := BR;
                   dek := dekB;
                   des := desB;
                   if AR>BR  then vrtDekDes (dekA,desA, dek,des);       //<Muutetaan luku isomman DIM mukaiseksi #####
                   r := r * power (10,-1*dek);                          //< -1*dek muuttaa jakolaskuksi ###
                 //if r=101010.0101  then beep;                         //<Vain Breakpointtia varten
             end;
{DIM     3 :if AR>BR  then vrtDekDes (dekA,desA, dek,des);              //<Muutetaan DIM isomman mukaiseksi ##########}
{DIM}    3 :if AR>BR  then begin  dek := dekA;  des := desA;  end;      //<Muutetaan DIM isomman mukaiseksi ##########
      end; //CASE

      s := '';
      if dek<0
      then case Abs(dek) DIV 3 of
             1 :dim := 'm';
             2 :dim := 'u';
             3 :dim := 'n';
           else dim := 'p';  end
      else case dek DIV 3 of
             0 :dim := '';
             1 :dim := 'k';
             2 :dim := 'M';
             3 :dim := 'G';
           else dim := 'T';  end;

      if ohj IN [1,2]  then begin
         dim := '';
         s := fRmrkt0 (r,1,des);       //<Tehd‰‰n R :st‰ string
         SokR (s,r);                   //<Muutetaan str luvuksi R
       //if r=0  then s := '0';        //< r=0 tai 0.0 tai 0.00  Sittenkin hyv‰ n‰ytt‰‰ desimaalitkin
      end;
      result := s +dim;
   end;//fDim3
(* //----------------------------------- Kokeiluun, ƒLƒ TUHOA --------------------------------------
   //ASETA Rich:in VISIBLE TRUE:ksi, muuten kokeilu ei n‰y @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   //function Copy(S: string; Index, Count: Integer): string;
   procedure koeDim3 (y, os :integer);        VAR qR,qX :real;   desR,desX :integer;
      function fTuh (s :string) :string;      VAR su :string;  i,d,j,mja :integer;      begin
         mja := Length (s);
         d := 1;
         while (d<mja) and (s[d]='')  do d := d+1;

         j := 0;
         if s[d]='0'       //<,,0.003456xx -> 0.003'456x'x #########################################
         then begin
            su := Copy (s,1,d+1);                     //< Alku samanlaisena desimPisteeseen asti
            for i := d+2 to mja  do begin             //< 0.xxx  -> s[d+1]='.',  d+2 = EkaDesJ‰lkmrk
               j := j+1;
               su := su +s[i];
               if j MOD 3 = 0  then su := su +'''';
            end; end
         else begin        //<,,12345.78xx -> 12'345.78x'x #########################################
            d := 0;
            for i := 1 to mja  do                     //< Etsit‰‰n desimPiste
               if s[i]='.'  then begin
                  d := i;  Break;  end;
            su := '.';                                //< DesimPisteest‰ l‰hdet‰‰n ekax alkuun p‰in
            for i := d-1 DownTo 1  do begin
               j := j+1;
               su := s[i] +su;
               if j MOD 3 = 0  then su := ''''+su;
            end;
            j := 0;
            for i := d+1 to mja  do begin             //< DesimPisteest‰ l‰hdet‰‰n loppuun p‰in
               j := j+1;
               su := su +s[i];
               if j MOD 3 = 0  then su := su +'''';
            end;
         end;

         for i := 1 to mja  do                        //<Etsit‰‰n desim.piste
         if su[i]='.'  then begin
            su[i] := ';';         //<Piste OMAMERKIKSI ";" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
            Break;  end;
         result := su;
      end;//fTuh

      function fArvo (o :integer) :real;      VAR ar :real;      begin
      case o of
       1:  ar :=0.000000000995;{??}10: ar :=         0.995;
       2:  ar := 0.00000000995;    11: ar :=         9.995;
       3:  ar :=  0.0000000995;    12: ar :=         99.95;
       4:  ar :=   0.000000995;    13: ar :=         999.5;
       5:  ar :=    0.00000995;    14: ar :=        9995.0;
       6:  ar :=     0.0000995;    15: ar :=       99950.0;
       7:  ar :=      0.000995;    16: ar :=      999500.0;
       8:  ar :=       0.00995;    17: ar :=     9999999.5;
       9:  ar :=        0.0995;   else ar :=    99999995.0; end;
      result := ar;
     end;//fArvo
   begin//koeDim3...................................................................................
      qR := fArvo (os+3);                   //< qR (os),    qX (os+1) ->  qX < qR   +2 = 100 *vrtArvo
      desR := 12;  if qR>1  then desR := 3; //' qR (os+1),  qX (os)   ->  qX > qR

      qX := fArvo (os);
      desX := 12;  if qX>1  then desX := 3;

{.... IkFrm.Image.Canvas.TextOut (1,y,  fImrkt0(os,2)+':  '+ //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,T‰m‰ OK
         fRmrkt0(qR,1,desR)+'   '+fTuh(fRmrkt0(qR,1,desR))+'=>'+fDim3(qR,qX,1) +'  #  '+
         fRmrkt0(qX,1,desX)+'   '+fTuh(fRmrkt0(qX,1,desX))+'=>'+fDim3(qR,qX,2) +' '+fDim3(qR,qX,3)+'   ');'''''''''''}
      IkFrm.Rich.Lines.Add(fImrkt0(os,2)+':  '+
         fRmrkt0(qR,1,desR)+'   '+fTuh(fRmrkt0(qR,1,desR))+'=>'+fDim3(qR,qX,1) +'  #  '+
         fRmrkt0(qX,1,desX)+'   '+fTuh(fRmrkt0(qX,1,desX))+'=>'+fDim3(qR,qX,2) +' '+fDim3(qR,qX,3)+'   ');
   end;//koeDim3
   //---------------------------------------------------------------------------------------------------------------*)

      function fTikToDim (aika :real) :string;      VAR ar :real;  sa :string;      begin
         ar := fMuokDes (aika,2);
         if aika = 0   then sa := '- - - -'                  else //  < =0    => '- - - -'
         if ar < 0.01  then sa := '<10 ms'                   else //  < 0.01s
         if ar < 10    then sa := fRmrkt0 (aika,1,2) +' s'   else //  < 10  s = 0.01s - 9.99s
         if ar < 100   then sa := fRmrkt0 (aika,1,1) +' s'   else //  < 100 s = 10.0s - 99.9s
         if ar = 100   then sa := fRmrkt0 (aika,1,0) +' s'   else //  = 100 s = 100s
                            sa := '>100'             +' s';       // >= 100 s = 100s - ...
         result := ' ' +sa;
      end;
   function fTimOFA_3th (Isul :real) :real;      VAR ar :real;      begin
      if (Isul=0) or (Isul>630)
         then ar := 0
         else ar := TikYR (su_OFAg, pyor (Isul), qIk3t*1000);
      result := ar;
    end;

   function fPixPit (str :String) :Integer;
      function fPixPit_ (CanvasOWner :TFormNola;  Txt :String;  TxtFont :TFont) :Integer;
            var OldFont :Tfont;   begin           //'Fnc:n perusmuoto s‰ilyt=n‰kyy idea
         OldFont := TFont.Create;
         try  OldFont.Assign (CanvasOWner.Font);
              CanvasOWner.Font.Assign (TxtFont);
              Result := CanvasOWner.Canvas.TextWidth (Txt);
              CanvasOWner.Font.Assign (OldFont);
         finally  OldFont.Free;  end; end;
   begin//fPixPit
    {result := fPixPit_ (EdvRuu.EdvPohja.Canvas, str, EdvRuu.EdvPohja.Canvas.Font); end;}
     result := fPixPit_ (IkFrm, str, IkFrm.Image.Canvas.Font);  end;

   procedure txtVasX (x,y :integer;  Txt :String;  VAR oikX :Integer);      VAR s :string;  i :integer;   begin
                 {IkFrm.Image.Canvas.TextOut (x,y,Txt);                                  //'TXT alkaa VAS:lta x,y :st‰
                  oikX := x+fPixPit (Txt);  end;}
      s := '';   oikX := x;
      for i := 1 to Length(Txt)  do
      if Txt[i]='§'  then begin                     //<Tuli joko BOLDin aloitus- tai lopetusMrk
         if s<>''  then begin
            IkFrm.Image.Canvas.TextOut (oikX,y, s);
            oikX := oikX +fPixPit (s);  end;        //<Lasket str:n pituus ja lis‰t‰‰n X:‰‰n =Txtn p‰‰ttymisX OIKEALLA

         s := '';
         if IkFrm.Image.Canvas.Font.Style = [fsBold]
            then IkFrm.Image.Canvas.Font.Style := []
            else IkFrm.Image.Canvas.Font.Style := [fsBold];  end//if Txt[i]='§'
      else s := s +Txt[i];

      IkFrm.Image.Canvas.TextOut (oikX,y, s);
      oikX := oikX +fPixPit (s);                    //<Lasket str:n pituus ja lis‰t‰‰n X:‰‰n =Txtn p‰‰ttymisX OIKEALLA
   end;//txtVasX
   procedure txtOikX (x,y :integer;  Txt :String;  var vasX :Integer);      begin //<,,TXT alkaa OIK:lta x :st‰ ######
      vasX := x-fPixPit (Txt);         //<Lasket str:n pituus ja lis‰t‰‰n X:‰‰n =Txtn p‰‰ttymisX VASEMLLA
      IkFrm.Image.Canvas.TextOut (vasX,y,Txt);  end;                     //' joka nyt myˆs txtn alkukohta

   //,,Wcjpt w÷ = Ohmi,kappa,phii,pii,tau, oomega,≤juuri ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
   procedure txtMath (x,y :integer;  Txt :String;  var oikX :Integer);      VAR FntName :TFontName;   begin
      FntName := IkFrm.Image.Canvas.Font.Name;                              //<Talteen alp. fontti
      IkFrm.Image.Canvas.Font.Name := 'Symbol';
      IkFrm.Image.Canvas.TextOut (x,y,Txt);
      oikX := x+fPixPit (Txt);                                         //<fPixPit laskee juuriASETETUN FontinMuk.
      IkFrm.Image.Canvas.Font.Name := FntName;                         //<Alp. fontti takas
   end;                                       //<''Lasket str:n pituus ja lis‰t‰‰n X:‰‰n =Txtn p‰‰ttymisX OIKELLA

{             procedure RediS (os :integer;  Txt :String);      begin //+6.1.1
                  if os<20  then DetEvFrm.aRich.AddText (Txt);  end;//}
{          FUNCTION if0_RED (arvo :real;  tab,des :integer) :string;      VAR ss :string;      begin
              ss := '';
              if arvo<=0  then ss := ss +COLOR_RED;
              ss := ss +fRmrkt0(arvo,tab,des) +'</f>';
              result := ss;  end;
           FUNCTION if0_BLU (arvo :real;  tab,des :integer) :string;      VAR ss :string;      begin
              ss := '';
              if arvo<=0  then ss := ss +COLOR_BLUE;
              ss := ss +fRmrkt0(arvo,tab,des) +'</f>';
              result := ss;  end;//}
//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
begin//piirra
with IkFrm  do begin
   sijoita (ohj);   //<SIJOITTAA Ik3... qR,qX (qR,qX=Myˆt‰Resist,Myˆt‰Reakt.#####################################
                    //ORGX := IkFrm.Height-Image.Height; //< =55 =Panelin + FrmCaption korkeus
   ORGY := 155;     //ORGY := (Image.Height div 2) +5;   //< =158,  Height nyt 363
   VMARG := ORGY*2 +selRvja*cr;                          //< VMARG t‰ss‰ vain apuna
   if IkFrm.Height<VMARG  then IkFrm.Height := VMARG;    //< VMARG t‰ss‰ vain apuna,  Height 361 -> 436
   VMARG := 0;                   if ohj>1  then VMARG := IkFrm.Image.Width DIV 2; //< DIV = Trunc ()
   OMARG := Image.Width DIV 2;   if ohj>1  then OMARG := IkFrm.Image.Width;       //< OMARG  Width 892/2 -> 446
   ORGX :=  50;                  if ohj>1  then ORGX :=  IkFrm.Image.Width DIV 2 +ORGX;
   LEV := OMARG-ORGX;                          //<Kuvion leveys <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

   w := 2*pii*qHz;                             //< w = Oomega = 2*Pii*f }
   if ohj=1  then begin                        //,Talteen eka referenssiksi, jonka perusteella oik.
      qIk3d_0 := qIk3d;                        // palstan k‰yr‰n korkeus suhteutetaan vas. palstaan.
      tau_0 := qX/(w*qR);  end;                //<tau_0 m‰‰r‰‰ esitett‰vien jaksojen lukum‰‰r‰n!!!!!

   jaksoja := pyor (2* qHz*tau_0/0.63);  //< 2* jotta l‰hemm‰ksi norm.tasoa kuin pelk‰st‰‰n Tau:lla(37%:iin)
   if jaksoja<4  then jaksoja := 4  else
   if jaksoja>15 then jaksoja := 15;

   iToTim := jaksoja/(LEV*qHz);          //<iToTim muuntaa i :n (0..LEV) ajaksi (=8/(LEV*qHz)#######
   alfa := 0;{Ω 3*Pii/2;                      //<ALFA osuttaa k‰yr‰n niin, ett‰ eka piste osuu huip-}
                                              // pukohtaan, jolloin SIN antaa arvoksi 1.00 = max.
   Yker := (ORGY-20) / qIk3d_0;          //<YKER = Sinik‰yr‰n korkeuss‰‰tˆ. 1.:ll‰ krlla = 1.  20 irti yr:sta

pyyhiPohja;
   if OHJ>1  then begin BoxBtnOn;
                        alpEDJ := ohj;  end
             else begin BoxBtnOFF;      end;

//,,,,,,,,,,,,,,,,, Vaaka+Pystyakseli alussa, jottei k‰yr‰piirot pyyhi ekaa pixeli‰ ,,,,,,,,,,,,,,,,
Image.Canvas.Font.Size := 8;
      Image.Canvas.Pen.Width := 1;
      Image.Canvas.Pen.Style := psSolid;
      Image.Canvas.Pen.Color := clBlack;
   Image.Canvas.MoveTo(ORGX,0);                                                     //<,Pystyakseli
      py := Image.Height -selRvja*cr + cr DIV 2;
   Image.Canvas.LineTo(ORGX,py);                                              //<Pystyakselin alap‰‰
      Image.Canvas.Pen.Width := 2;
   Image.Canvas.MoveTo(ORGX-12,ORGY);                                               //<,Vaaka-akseli
   Image.Canvas.LineTo(OMARG,ORGY);

//,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Vaimeneva SINIk‰yr‰,,,,,,,,,,,,,,,,,,,,,,*)
Image.Canvas.Pen.Width := 1{2};
Image.Canvas.Pen.Color := {clBlack;}clBlue;{clYellow;{clRed;}{clGreen}
//Image.Canvas.Pen.Color := clBlack;                         //<NSSsuunOhje IsIk
   for i := 0 to LEV  do begin
      x := w* i*iToTim +alfa;           //KOE y := exp (-1* i/100);  //    y := exp (-1* i*w*qR/qX);
                      {if i=20
                        then begin //DetEvFrm.aRich.Font.Name := 'Courier New';
                                   DetEvFrm.aRich.AddText ('<br>');
                                   DetEvFrm.aRich.ReadOnly := false;
                                   DetEvFrm.Show;  end
                        else if i<20  then begin
                           if i=0  then
                              DetEvFrm.aRich.AddText ('w=' +fRmrkt0(w,5,3) +'  iTo=' +fRmrkt0 (iToTim,1,8)+
                              '  r/x='+fRmrkt0 (qR/qX,5,3) +'  Yker=' +fRmrkt0 (Yker,1,5)  +
                              '  0.02*iToTim=' +fRmrkt0 (0.02*iToTim,1,8) +'<br>');
                           DetEvFrm.aRich.AddText ('i='+fImrkt0(i,2) +'  x='+fRmrkt0(x,5,3) +
                           '  c(x)=' +fRmrkt0 (cos(x),1,3));  end;//}
               //========= i = ( V®2 U / Z)  [ sin(wt +alfa -fii ) - exp (-t / T)  sin(alfa -fii) ] ====INSKO====
               //========= i = ( V®2 U / Z)  [ sin(wt +alfa -fii ) - exp (-t R/L)  sin(alfa -fii) ] ====OK=======
               //========= i = ( V®2 U / Z)  [ cos(wt)             - exp (-t / T)      =MaxDC       ====INSKO====
               //========= i = ( V®2 U / Z)  [ cos(wt)             - exp (-t*w*R/X)    =MaxDC       ====OK=======
		         // T = L/R = X/(w*R) = X / (2Pii f R),    luokkaa 0.1 s
      y := iToTim;
    //y := iToTim*Yker;      //<L‰htee origon alapuolelta sinim‰isesti, kaikki huiput samalla tasolla
    //y := Yker/iToTim;      //<Ekax suora alas sinin min.tasolle ja kaikki huiput samalla tasolla
    //y := iToTim/Yker;      //<L‰htee origon alapuolelta, koko sinik‰yr‰ liian ylh‰‰ll‰, yl‰puoli korkeampi, k‰yr‰ vaimenee hitaammin
      if qX>0
       //then yy := exp (-1* i*iToTim *w *qR/qX)  //< -t/T, T=L/R =X/(w*R) -> -t*w*R/X ######## =ALKUPER.########
         then yy := exp (-1* i*y      *w *qR/qX)  //< -t/T, T=L/R =X/(w*R) -> -t*w*R/X ##########################
         else yy := 0;                            //<y := 0 jottei ERROR
                                       //RediS (i,'  yy='+fRmrkt0(yy,5,3) +'  c(x)-yy=' +fRmrkt0(cos(x)-yy,1,3));
      y := -1*Yker*qIk3v *Sqrt(2) *(cos(x) -yy);  //< -1* koska origo on VasYlh‰‰ll‰ =KASVAA ALAS.
    //y := -1*Yker*qIk3v *Sqrt(2) *(cos(x) -yy*0.9);
    //y := -1*Yker*qIk3v *Sqrt(2) *(cos(x) -yy/Yker);

      y := -1*y;

    //y := Yker*qIk3v *Sqrt(2) *cos(x) *0.5;               //<NSSsuunOhje sinik‰yr‰
      py := fY(y);                                 //< FNC fY := trunc(y) +OrgY   OrgY=155
      if i=0  then Image.Canvas.MoveTo(ORGX+i,py)  //< i>0 = ''Seuraavaksi LineTo
              else Image.Canvas.LineTo(ORGX+i,py);
                  {w=314.159  iTo=0.00023810  r/x=0.311  Yker=10.33175  0.02*iToTim=0.00000476
                   i= 0  x=0.000  c(x)=1.000  yy=1.000  c(x)-yy=0.000  #  y=0.000  py=155
                   i= 1  x=0.075  c(x)=0.997  yy=0.977  c(x)-yy=0.020  #  y=1.942  py=156
                   i= 2  x=0.150  c(x)=0.989  yy=0.955  c(x)-yy=0.034  #  y=3.298  py=158 }
                                       //RediS (i,'  #  y='+fRmrkt0(y,5,3) +'  py='+fImrkt0(py,1) +'<br>');
   end;
{KOEAJO-osa TƒSTƒ siirretty alummaksi 12.0.02:=======================================================================================
//,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Vaimeneva k‰yr‰ qIk3d,,,,,,,,,,,,,,,,,,,,
                                                           //NSSsuunOhje sinik‰yr‰>..
Image.Canvas.Pen.Width := 1;
Image.Canvas.Pen.Color := clRed;
{Image.Canvas.Pen.Color := clBlack;                        //<NSSsuunOhje IsIk
Image.Canvas.Pen.Style := psDot;                           //<NSSsuunOhje IsIk}
   for i := 0 to LEV  do begin         //KOE y := exp (-1* i/100);   //    y := exp (-1* i*w*qR/qX);
      if qX>0
         then y := exp (-1* w* i*iToTim *qR/qX)  //< -t/T, T=X/w*R -> -t*w*R/X #####################
         else y := 0;                            //' y := 0 jottei ERROR
      y := -1 *Yker*qIk3v *Sqrt(2) *y;           //< -1 koska origo on vy eik‰Alhaallaa =KASVAA ALAS
      py := fY(y);
      if i=0      then Image.Canvas.MoveTo(ORGX+i,py)  else
      if py<ORGY  then Image.Canvas.LineTo(ORGX+i,py)  else Break; //<Break, jottei punainen vaakaviiva pyyhkisi t-akselia
                       {     if i=0      then Image.Canvas.MoveTo(ORGX+i,py)  else
                             if py<ORGY  then Image.Canvas.LineTo(ORGX+i,py);}
   end;
{if ohj=1  then begin                                                   //<NSSsuunOhje IsIk
   Image.Canvas.MoveTo(ORGX+10,ORGY+85);                               //<NSSsuunOhje IsIk
   Image.Canvas.LineTo(ORGX+50,ORGY+85);                               //<NSSsuunOhje IsIk
   Image.Canvas.TextOut(ORGX+55,ORGY+78, 'idc = f (t)   DC-kompon.');  //<NSSsuunOhje IsIk
end;
Image.Canvas.Pen.Style := psDash;                                      //<NSSsuunOhje IsIk}
//,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Tehollisarvok‰yr‰ qIk3v, vaimeneva,,,,,,,,,,,,,,,,,,
Image.Canvas.Pen.Color := clBlack;
Image.Canvas.Pen.Width := 1;
   for i := 0 to LEV  do begin    //KOE y := exp (-1* i/100);   //    y := exp (-1* i*w*qR/qX);
      if qX>0
         then y := exp (-1* w* i*iToTim*qR/qX)   //< -t/T, T=X/w*R -> -t*w*R/X #####################
         else y := 0;                            //' y := 0 jottei ERROR
    //,,#########################################################################################################
    //y := -1 *(sin(pii/2)/Sqrt(2)); //<Piirt‰‰ tehollArvoSUORAN AC-kompon.k‰yr‰lle = 0.7*huippu. OK, tarkastettu
    //''#########################################################################''ƒLƒ POISTA''##################
      y := -1 *Yker*qIk3v *(y + 1/Sqrt(2));      //< -1 koska origo on vy eik‰Alhaallaa =KASVAA ALAS
      py := fY(y);
      if i=0  then Image.Canvas.MoveTo(ORGX+i,py)
              else Image.Canvas.LineTo(ORGX+i,py);
   end;
{if ohj=1  then begin                                                    //<NSSsuunOhje IsIk
   Image.Canvas.MoveTo(ORGX+180,ORGY+85);                               //<NSSsuunOhje IsIk
   Image.Canvas.LineTo(ORGX+225,ORGY+85);                               //<NSSsuunOhje IsIk
   Image.Canvas.TextOut(ORGX+235,ORGY+78, 'ik = f (t)   Tehollisarvo'); //<NSSsuunOhje IsIk
end;
Image.Canvas.Pen.Style := psSolid;               //<NSSsuunOhje IsIk}
//,,,,,,,,,,,,,,,,,,,,,,,,,,,,(Vaaka+Pystyakseli oli alussa, jottei k‰yr‰piirot pyyhi ekaa pixeli‰)
//,,,,,,,,,,,,,,,,,,,,,,,,,,,, SelitystekstiRivit (ylin rivi ekax) ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
                                            //,,, 1.+2. tekstirivi,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
py := Image.Height -selRvja*cr -1;                                  //<Ylimm‰n (1.) tekstirivin taso
   i := VMARG+5;  t := ORGX-7;   PX := ORGX;

      Image.Canvas.Font.Color := clBlue;
if ohj=1
then begin
py := py+cr;
      Image.Canvas.Font.Style := [fsBold];
      Image.Canvas.Brush.Style := bsClear;                               //<+12.0.02  T‰m‰ poistaaw7¥st‰ harmaan tekstitaustan =OK.
   txtVasX (i,py,  'Pahin tilanne; vikavaiheessa ', bx);
   txtVasX (bx,py, 'u:n huippuhetki ', bx);
      Image.Canvas.Font.Style := [];
   txtVasX (bx,py, '-> dc-kompon.', bx);

py := py+cr;
   txtVasX (i,py,  ' = i, eli i^ (=', bx);
      Image.Canvas.Font.Style := [fsBold];
   txtVasX (bx,py, 'is' ,bx);
      Image.Canvas.Font.Style := [];
   txtVasX (bx,py, ') l‰henee 2i.   Jos ', bx);
   txtMath (bx,py, 'w'{=oomega}, bx);
   txtVasX (bx,py, 't = n*', bx);
   txtMath (bx,py, 'p'{=pii}, bx);
   txtVasX (bx,py, ',  dc-kompon.= 0 ja i^ vain ', bx);
   txtMath (bx,py,'÷'{=juuri},bx);              //<Wcjpt w÷ = Ohmi,kappa,phii,pii,tau, oomega,≤juuri
   txtVasX (bx,py, '2  Ik3v.', bx);
end else begin
py := py+cr;
   txtVasX (ORGX,py,  'Tilanne: ks. vasen palsta.', bx);
py := py+cr;
end;
                                            //,,, 3. tekstirivi,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
py := py+cr;
      Image.Canvas.Font.Color := clBlack;
   if ohj=1
   then begin
    //txtVasX (i,py, '(', bx);
         Image.Canvas.Font.Size := 10;
         Image.Canvas.Font.Style := [fsBold];
      txtMath (i,py-5,'t '{=tau},bx);
         Image.Canvas.Font.Style := [];
         Image.Canvas.Font.Size := 8;
      txtVasX (bx,py,'= aikavak.(63%vaim.):   ',bx);
      ax := VMARG;  end
   else begin
      bx := 0;
      ax := ORGX;  end;

      s := '§R§=' +fDim3(qR,qX,1) +'  §X§='+fDim3(qR,qX,2) +' '+fDim3(qR,qX,3);
   txtVasX (ax+bx,py, s, bx);
   txtMath (bx,py,'W'{=oomega},bx);             //<Wcjpt w÷ = Ohmi,kappa,phii,pii,tau, oomega,≤juuri
   txtVasX (bx,py,'   ->  ',bx);
      Image.Canvas.Font.Size := 10;
      Image.Canvas.Font.Style := [fsBold];
   txtMath (bx,py-5,'t'{=tau},bx);              //< -5, koska isompi fnt tulee alemmaksi, todettu
      Image.Canvas.Font.Style := [];
      Image.Canvas.Font.Size := 8;
   txtVasX (bx,py,' = X / (2',bx);
   txtMath (bx,py,'p '{=pii},bx);

      y := qX/(w*qR);                                  //< y TƒSSƒ aikavakiomuuttujana
      ii := 2;   if y<0.095  then begin y := y*1000;   //< ms :ksi. ii TƒSSƒ desimLkmMuuttujana
                                        ii := 0;  end;
      s := 'f R) = ';
   txtVasX (bx,py, s, bx);
      s := '§' +fDemRx(1, y,1,ii);
      if ii>0  then s := s +' s§'
               else s := s +' ms§';
      Image.Canvas.Font.Color := clRed;
   txtVasX (bx,py, s, bx);
      Image.Canvas.Font.Color := clBlack;
                                            //,,, 4. tekstirivi,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
py := py+cr;
   txtVasX (PX,py, 'Ik3th = Ik3v',bx);
   txtMath (bx,py,'÷'{=juuri},bx);              //<Wcjpt w÷ = Ohmi,kappa,phii,pii,tau, oomega,≤juuri
   txtVasX (bx,py, '[(m+n] t],   ', bx);
   txtVasX (bx,py, '§m§ = {1/[2ftLn(', bx);
   txtMath (bx,py,'c'{=kappa},bx);
   txtVasX (bx,py, '-1)]} * [e', bx);
   txtVasX (bx,py-4, '4ftLn(', bx);
   txtMath (bx,py-4,'c'{=kappa},bx);
   txtVasX (bx,py-4, '-1)', bx);
   txtVasX (bx,py, '  -1],   §n§ ', bx);
   txtMath (bx,py,'ª'{=likim},bx);
   txtVasX (bx,py, ' 1', bx);
                                            //,,, 5. tekstirivi,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
py := py+cr;
      Image.Canvas.Font.Style := [fsBold];
   txtVasX (PX,py, 'is' ,bx);
      Image.Canvas.Font.Style := [];
   txtVasX (bx,py, ' = Ik3dyn = ', bx);
   txtMath (bx,py,'c'{=kappa},bx);              //<Wcjpt w÷ = Ohmi,kappa,phii,pii,tau, oomega,≤juuri
   txtVasX (bx,py, ' * Ik3v * ', bx);
   txtMath (bx,py,'÷'{=≤juuri},bx);
   txtVasX (bx,py, '2,   §', bx);
   txtMath (bx,py,'c'{=kappa},bx);
   txtVasX (bx,py, '§ = 1.022+0.969 e ', bx);
   txtVasX (bx,py-3, '-3.03R/X', bx);
// txtVasX (bx,py, ',   Ik3th ks.avuste', bx);

//,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,, Viivatyypit ja -selitykset ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
py := py+cr;
   if OHJ=1  then begin                                              //<VainVasPalstalleTYYPPIVIIVAT
      Image.Canvas.Pen.Width := 1;                                   // ,,SUMMAk‰yr‰Viiva===========
      Image.Canvas.Pen.Style := psSolid;
      Image.Canvas.Pen.Color := clBlue;{clYellow;{clRed;}{clGreen}{clBlack;}
      Image.Canvas.MoveTo(i, py+ADJ);                                                // ,,TyyppViiva
      Image.Canvas.LineTo(t, py+ADJ);  end;

      Image.Canvas.Font.Color := clBlue;{clBlack;}                                   //<,,SelitysTxt
      s := 'ik     = f (t) =AC+DC -kompon.=Vaikuttava,   ';
   txtVasX (PX,py, s, bx);
      Image.Canvas.Font.Color := clRed;
      Image.Canvas.Font.Style := [fsBold];
   txtVasX (bx,py, 'is', bx);
      Image.Canvas.Font.Style := [];
      s := ' = Ik3dyn = ';
   txtVasX (bx,py, s, AX);     //< AX = x -koordinaatti s :n lopussa, TARVITAAN SEUR.RVll‰ ja 2 kpl ETEENPƒIN ########
   txtVasX (AX,py,'§' +f_kA (qIk3d) +'§',bx);

py := py+cr;
      Image.Canvas.Font.Color := clBlue;
   bx := PX +fPixPit ('ik     = f (t)');        //<"ik..." vain loppumispisteen laskemiseen ########
   txtVasX (bx,py, ' = ( ',bx);
   txtMath (bx,py,'÷'{=≤juuri},bx);             //<Wcjpt w÷ = Ohmi,kappa,phii,pii,tau, oomega,≤juuri
   txtVasX (bx,py,'2  U / Zk3v ) * [cos (',bx);
   txtMath (bx,py,'w'{=oomega},bx);             //<Wcjpt w÷ = Ohmi,kappa,phii,pii,tau, oomega,≤juuri
   txtVasX (bx,py, 't)  - e ', bx);
   txtVasX (bx,py-4, '- t / ', bx);
      Image.Canvas.Font.Size := 10;
   txtMath (bx,py-4-1,'t'{tau},bx);
      Image.Canvas.Font.Size := 8;
   txtVasX (bx,py,' ]',bx);                           //,,,+6.0.4,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
                                                      //,Edja+1 :ll‰ ilmaistiin vikan loppuun laskenta, eik‰ sille
   oh := ohj;                                         // ole edv.edka[ohj].arvoU[3] :ta.##########################
   if OFAsul>0  then begin                //<,,===========OFAAn vaikutus Ik3d:hen +6.0.4============
py := py+cr;
      if oh=1  then begin
         Image.Canvas.Pen.Color := clYellow;
         Image.Canvas.MoveTo(i, py+ADJ);                                            //<,,TyyppiViiva
         Image.Canvas.LineTo(t, py+ADJ);
      end;
      ar := OFAsul;
         if (ar>0) and (ar<=630)
         then begin
              s := fRmrkt0 (ar,1,0) +' A';
              tim := fTimOFA_3th (ar);
              s := s +'/' +fTikToDim (tim);  end //<AR -OFAAsulakkeen poiskytkent‰YRaika
         else s := '- - - -';
      s := 'OFAAn (' +s +'/ Ik3th) rajoittama  ';
      Image.Canvas.Font.Color := clYellow;
//    Image.Canvas.Font.Color := clBlack;                  //<NSSsuunOhje IsIk
      Image.Canvas.Font.Style := [fsBold];       //<Yellow ei muuten erotu.
      txtVasX (PX,py, s, bx);
      s := 'is = ';
         if (ar>0) and (ar<=630)
         then s := s +f_kA (OFAvalIs)
         else s := s +'- - - -';
      txtVasX (bx,py, s, bx);                                                       //<SelitysTxt
   end;                                                //'''+6.0.4''''''''''''''''''''''''''''''''''''''''''''''''

py := py+cr;
   if OHJ=1  then begin                                              //<VainVasPalstalleTYYPPIVIIVAT
      Image.Canvas.Pen.Width := 1;                                   // ,,KESKIARVOk‰yr‰Viiva=======
      Image.Canvas.Pen.Color := clBlack;
    //Image.Canvas.Pen.Style := psDot;
      Image.Canvas.MoveTo(i, py+ADJ);                                                //<,,TyyppViiva
      Image.Canvas.LineTo(t, py+ADJ);
   end;
      Image.Canvas.Font.Color := clBlack;{clGray;}                                   //<,,SelitysTxt
      Image.Canvas.Font.Style := [];
   txtVasX (PX,py,'ik     = f (t) =Tehollisarvo  Ik3v = §' +f_kA (qIk3v) +'§  ->  ',bx);
   txtOikX (AX,py, 'Ik3th(1s) = ',bx);                               //< BX vain syntaxin takia
   txtVasX (AX,py,'§' +f_kA (qIk3t) +'§',bx);

py := py+cr{+2};
   if OHJ=1  then begin                                              //<VainVasPalstalleTYYPPIVIIVAT
      Image.Canvas.Pen.Width := 1;                                   // ,,DC-k‰yr‰Viiva=============
      Image.Canvas.Pen.Color := clRed;
      Image.Canvas.MoveTo(i, py+ADJ);                                                //<,,TyyppViiva
      Image.Canvas.LineTo(t, py+ADJ);  end;
   Image.Canvas.Font.Color := clRed;                                                 //<,,SelitysTxt
   txtVasX (PX,py,'idc  = f (t) =DC-komponentti  = ( ',ax);
   txtMath (ax,py,'÷'{=≤juuri},ax);             //<Wcjpt w÷ = Ohmi,kappa,phii,pii,tau, oomega,≤juuri
   txtVasX (ax,py,'2  U / Zk3v ) * '{[cos ('},ax);
// txtMath (ax,py,'w'{oomega},ax);
   txtVasX (ax,py,{'t)  -}' e ',ax);
   txtVasX (ax,py-4,'- t / ',ax);       //< -4 = Exponentin korotus
      Image.Canvas.Font.Size := 10;
   txtMath (ax,py-4-1,'t'{tau},ax);
      Image.Canvas.Font.Size := 8;

//,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,, Pystyakselin merkinn‰t ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
      Image.Canvas.Pen.Width := 1;                    //,,Ik3dyn MerkkViiva=========================
      Image.Canvas.Pen.Color := clRed;
//    Image.Canvas.Pen.Color := clBlack;                          //<NSSsuunOhje IsIk
      y := Yker*qIk3d;
      py := fY(-1 *y);
   Image.Canvas.MoveTo(ORGX-12,py);                                                  //,,MerkkiViiva
   Image.Canvas.LineTo(ORGX+10,py);                                                  //< MerkkiViiva
   if OHJ=1  then begin                                           //<VainVasPalstalleY-akselin Selit
      Image.Canvas.Font.Color := clRed;
//    Image.Canvas.Font.Color := clBlack;                         //<NSSsuunOhje IsIk
      Image.Canvas.Font.Style := [fsBold];
      txtOikX (ORGX-17,py-ADJ, 'is',py);                               //< PY paluuparam, ei k‰yttˆ‰
      Image.Canvas.Font.Style := [];  end;

      Image.Canvas.Pen.Width := 1;                    //,,KESKIARVOkViiva===========================
      Image.Canvas.Pen.Color := clBlack;
      y := Yker*qIk3v;
      py := fY (-1 *y);
   Image.Canvas.MoveTo(ORGX-12,py);                                                  //,,MerkkiViiva
   Image.Canvas.LineTo(ORGX+4 ,py);

      Image.Canvas.Font.Color := clBlue;
//    Image.Canvas.Font.Color := clBlack;                         //<NSSsuunOhje IsIk
      Image.Canvas.Font.Style := [];
   if OHJ=1  then                                                 //<VainVasPalstalleY-akselin Selit
      txtOikX (ORGX-17,py-ADJ,'Ik3v',PX);                              //< PX paluuparam, ei k‰yttˆ‰

 //oh := ohj;                              //<,,,+6.0.4,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
                                                      //,Edja+1 :ll‰ ilmaistiin vikan loppuun laskenta, eik‰ sille
                                                      // ole edv.edka[ohj].arvoU[3] :ta.##########################
(*                                                                //<NSSsuunOhje IsIk vex>...*)
   if OFAsul>0  then begin                //<,,=============OFAAn vaikutus Ik:hon = VAAKAVIIVA=====================
      Image.Canvas.Pen.Color := clYellow;
    //Image.Canvas.Pen.Color := clBlack;                          //<NSSsuunOhje IsIk
         ar := OFAvalIs;                              //<Yl‰viivaksi
       //py := fY(-1*Yker*ar);                        //<OFAAoikoSULraj_Is -arvo pystyakselille
         y := Yker *ar;                               //'=kuvaa n‰enn‰isesti Is ja Tim rajoja.!!!!!!!!!!!!!!!!!!!!
         py := fY (-1 *y);                            //<OFAAoikoSULraj_Is -arvo pystyakselille
      Image.Canvas.MoveTo(ORGX-12,py +1);             //<, +1 jotteiv‰t PUN ja KELT VIIVA tulisi p‰‰llekk. +6.1.1
      Image.Canvas.LineTo(ORGX+10,py +1);             //<Koe: OFAAsul -arvo pystyakselille (workki OK)}

{---  ar := 1 *a_getIntg (60012,edv.edka[oh].OfaVal); //<,,,Korvaa ed. (ORGX-12,py) ... (ORGX+10,py) -viivan------
       //if (ar>0) and (ar<=630)  then begin
            tim := fTimOFA_3th (ar);                  //<AR = Poiskytkent‰aika OFAA -sulakkeella.
    //tim := 0.07;//800;                              //<Kokeiluun, 0.02 = 20 ms = Yksi jakso.
      if tim<0.002  then tim := 0.002;                //<Jotta pystyviiva erottuisi pystyakseliviivasta.

    //bx := ORGX + pyor (1/qHz/iToTim);               //<Yhden jakson X -mitta = Vaakaviivan pituus

      ar := 1/qHz/iToTim;                             //< 1/qHz/iToTim = Yhden jakson X -mitta = 20ms=0.002s
      bx := pyor (tim*ar/0.02);                        //<, bx = OFAAn rajoittaman IS -viivan (Ik3d) pituus.
      bx := ORGX + bx;
    //bx := ORGX + pyor (tim*1000);                   //< bx = OFAAn rajoittaman IS -viivan (Ik3d) pituus.
      Image.Canvas.MoveTo(ORGX,py);                                         //<Vaakaviivan alkupiste
      Image.Canvas.LineTo(bx,  py);                                         //<Vaakaviiva oikealle.
      Image.Canvas.LineTo(bx,  ORGY);                                       //<Pystyviiva alas.
      Image.Canvas.Font.Color := clYellow;
      Image.Canvas.Font.Style := [fsBold]; //<Bold = Yellow ei muuten erotu.
      IkFrm.Image.Canvas.TextOut (bx+4,py-8, 'ofa');

     {with edv.edka[oh]  do IkFrm.Caption := 'q/edv:'+
               '  d=' +fRmrkt0 (qIk3d,1,2) +'/' +fRmrkt0 (arvo [arvo_IK3D_4]/1000,1,2) +
               '  t=' +fRmrkt0 (qIk3t,1,2) +'/' +fRmrkt0 (arvo [arvo_IK3T_3]/1000,1,2) +
               '  v=' +fRmrkt0 (qIk3v,1,2) +'/' +fRmrkt0 (arvo [arvo_IK3V_2]/1000,1,2); --------------}
   end;                                    //<'''+6.0.4''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                                                      //...< NSSsuunOhje IsIk.*)
                                                      //..<NSSsuunOhje sinik‰yr‰
      Image.Canvas.Font.Color := clBlack;             //,,Aika-akseliViiva==========================
   txtOikX (ORGX-17,ORGY-ADJ,'0',PX);                                  //< PX paluuparam, ei k‰yttˆ‰

      py := VMARG+125;                                //,,Tapahtumapaikan otsikko===================
      Image.Canvas.Font.Size := 12;
      Image.Canvas.Font.Style := [fsBold];
{|}   if a_getIntg (11001,Edv.Sorc[1].src.SorceKind) = 1 //< 1=Transformer  2=LV-Cable  3=Generator  4=UPS
         then s := 'Muuntajan toisionavoissa.'
         else s := 'PJ-liittym‰pisteess‰.';{|}
{|    s := 'Muuntajan toisionavoissa'; |}
      if ohj IN [2..edja+1]  then begin
         s := 'Johto-osan n:o  ';
         if ohj<=edja
            then s := s + IntToStr (ohj)  +'  alussa.'
            else s := s + IntToStr (edja) +'  LOPUSSA.';
      end;
   Image.Canvas.TextOut (py,5, s);

   Image.Canvas.Font.Style := [];
   Image.Canvas.Font.Size := 8;
   y := 1/qHz;
   ii := 0;  if qHz<>50  then ii := 2;
   s := IntToStr (jaksoja) +' jaksoa ('+IntToStr(qHz)+' Hz) · '+fRmrkt0(y*1000,1,ii) +' ms = ';
   if jaksoja*y < 0.01  then s := s +fDemRx (1, jaksoja*y*1000,1,1) +' ms'
                        else s := s +fDemRx (1, jaksoja*y,1,2) +' s';
   Image.Canvas.TextOut (py,25, s);
{|                                      Image.Canvas.Font.Size := 12;  Image.Canvas.Font.Color := clRed;
                                        Image.Canvas.TextOut (120,ORGY+70, 'Versio 2.0.0 :n esittely‰, tilanne '+
                                                              'ei vastaa v‰ltt‰m‰tt‰ k‰sitelt‰v‰‰ verkkoa');|}
//,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,, Vaaka-akselin merkinn‰t ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
                                                    //NSSsuunOhje sinik‰yr‰st‰ vex>..
      Image.Canvas.Pen.Color := clBlue;
    //Image.Canvas.Pen.Color := clBlack;            //<NSSsuunOhje IsIk
   for i := 1 to jaksoja  do begin              //,,Y tallessa viel‰ edellisest‰ = jakson pituus [s]
         PX := ORGX + pyor (i * y/iToTim);
         if i=jaksoja  then PX := PX-1;                              //<Muuten vika ei n‰y, todettu
      Image.Canvas.MoveTo(PX,ORGY-5);                                                //,,MerkkiViiva
      Image.Canvas.LineTo(PX,ORGY+5);                                                //,,MerkkiViiva
   end;

      Image.Canvas.Pen.Color := clRed;
      Image.Canvas.Pen.Width := 2;                                   //< 6.1.1  Width 1 => 2
      y := qX/(w*qR);                                                //< y TƒSSƒ aikavakiomuuttujana
      PX := ORGX + pyor (y/iToTim +1);
   Image.Canvas.MoveTo(PX,ORGY-7);                                                   //,,MerkkiViiva
   Image.Canvas.LineTo(PX,ORGY+7);                                                   //,,MerkkiViiva
      Image.Canvas.Font.Color := clRed;
      Image.Canvas.Font.Style := [fsBold];                           //<+6.1.1
      Image.Canvas.Font.Size := 12{10};                              //< 6.1.1  Size 10 => 12
   txtMath (PX+2,ORGY+1,'t'{tau},py);                                //< PY paluuparam, ei k‰yttˆ‰
                                                    //..<NSSsuunOhje sinik‰yr‰st‰ vex, korvattu >..
(*    Image.Canvas.Pen.Color := clBlack;
   for i := 1 to jaksoja*2  do begin            //,,Y tallessa viel‰ edellisest‰ = jakson pituus [s]
         PX := ORGX + pyor (i * y/iToTim /2);
         if i=jaksoja  then PX := PX-1;                               //<Muuten vika ei n‰y, todettu
      Image.Canvas.MoveTo(PX,ORGY-5);                                                //,,MerkkiViiva
      Image.Canvas.LineTo(PX,ORGY+5);                                                //,,MerkkiViiva
   end;                                             //..<NSSsuunOhje sinik‰yr‰

//------------------------------------------- Kokeiluun --------------------------------------------
(*if ohj=1  then begin
   pyyhiPohja;
   py := cr-3; //<Mahd. tiivis ruudulla =Mahd. paljon rivej‰ n‰kyviss‰
// py := cr+6; //<J‰tt‰‰ riviv‰li‰ kyn‰merkinnˆille tulosteissa
   Image.Canvas.TextOut (142,0{7}, 'm      u      n     p'); //<,N‰m‰ ei n‰y, jos RichEditille tulost.
   Image.Canvas.TextOut (408,0{7}, 'm      u      n     p');
   for i := 1 to 17  do
      koeDim3 (py*i,i);
end;//--------------------------------------------------------------*)
end;//with IkFrm
end;//piirra
//===============================================================================================================

procedure TIkFrm.FormShow(Sender: TObject);      VAR no :integer;
   procedure posFrm;      begin //+6.0.0               //IkFrm.Top := 800;  IkFrm.Left := 800; //<Koe
      if IkFrm.Left <0  then IkFrm.Left := 0;
      if IkFrm.Top  <0  then IkFrm.Top :=  0;
      if IkFrm.Left +IkFrm.Width > Screen.Width
         then IkFrm.Left := Screen.Width -IkFrm.Width;
      if IkFrm.Top +IkFrm.Top > Screen.Height
         then IkFrm.Top := Screen.Height -IkFrm.Height;
   end;
begin
// Color := clWhite; //clBtnFace ObjInsp:ssa = Image Transparent=TRUE => kuva harmaa. NSSsuunOhjeeseen valk.
   Caption := PROGRAM_VERSIO_STRING +':  Oikosulkutapahtuma'; //<+6.2.10
   qHz := 50;
{|}edja := a_getIntg (11001,edv.YLE.JohtoOsia);{|}
{| edja := 3;|}
   piirra (1);                   //< 0->1      6.0.4
   no := edja+1;                 //<,,+6.1.1
   if (alpEDJ<no) and (alpEDJ>0) //<,,+6.1.1  alpEdj alustettu 0 :ksi
      then no := alpEDJ;
   piirra (no);        //< 1->edja+1 6.0.4
   posFrm;             //< +6.0.0
   SetFocus;
end;

procedure TIkFrm.SuljeBtnClick(Sender: TObject);      begin
   Close;
end;

{The following code illustrates the differences between CopyRect and BrushCopy. The bitmap graphic ëTARTAN.BMPí is
loaded into Bitmap and displayed on the Canvas of IkFrm. BrushCopy replaces the color black in the graphic with the
brush of the canvas, while CopyRect leaves the colors intact.

var
  Bitmap: TBitmap;
  MyRect, MyOther: TRect;
begin
  MyRect := Rect(10,10,100,100);
  MyOther := Rect(10,111,100, 201);
  Bitmap := TBitmap.Create;
  Bitmap.LoadFromFile('c:\windows\tartan.bmp');
      IkFrm.Canvas.BrushCopy(MyRect,Bitmap, MyRect, clBlack);
  IkFrm.Canvas.CopyRect(MyOther,Bitmap.Canvas,MyRect);
  Bitmap.Free;
end;}
procedure TIkFrm.TulostaBtnClick(Sender: TObject);      VAR suorak :TRect;  ar,kerr :real;  edCapt :string;      begin
 //IkFrm.Print;                                         //<OK, mutta tulostaa koko lomakkeen. EiJos liianLeve‰, TODTTU
{--TulostaBtn.Enabled := false;
   Printer.BeginDoc;
   if Printer.PageWidth<Image.Width
   then begin
    //kerr := 0.8;
      kerr := Image.Width/Printer.PageWidth;
      suorak := Rect (0,0, trunc (kerr*IkFrm.Image.Width), trunc (kerr*IkFrm.Image.Height));
      Printer.Canvas.StretchDraw (suorak, Image.Picture.Graphic);  end
   else  Printer.Canvas.Draw (0,0,IkFrm.Image.Picture.Graphic); //< 20=Vas.marg.
   Printer.EndDoc;
   if not Printer.Printing  then TulostaBtn.Enabled := true;
//'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''}
   TulostaBtn.Enabled := false;
   edCapt := TulostaBtn.Caption;
   TulostaBtn.Caption := 'Tulostaa';
   Printer.BeginDoc;
 //kerr := Image.Width/Printer.PageWidth;
 //kerr := 5; //<OK
   ar := 0.9;   if Printer.PageWidth<210  then ar := 1;
   kerr := Printer.PageWidth/Image.Width *ar;
   suorak := Rect (20,0, trunc (kerr*IkFrm.Image.Width), trunc (kerr*IkFrm.Image.Height));
   Printer.Canvas.StretchDraw (suorak, Image.Picture.Graphic);
   Printer.EndDoc;
   if not Printer.Printing  then begin
      TulostaBtn.Enabled := true;
      TulostaBtn.Caption := edCapt;  end;
end;//Tulosta

//,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
function fLueComBx :integer;      VAR i :integer;      begin
   if SokI (IkFrm.ComBx.Text,i)   //<Val -> SokI 6.0.4
      then result := i
      else result := alpEDJ;
end;

procedure ChkComBxEnabl;      VAR no :integer;      begin
   no := fLueComBx;
   if (no<>alpEDJ) and (no>1) and (no<=edja+1)  
      then       PvitaBtnEnabON                              //<Enabloidaan jos muutoksia
      else begin PvitaBtnEnabOFF;
                 IkFrm.ComBx.Text := IntToStr (alpEDJ);  end;
end;

procedure TIkFrm.ComBxChange(Sender: TObject);      begin
   ChkComBxEnabl;
end;

procedure TIkFrm.ComBxExit(Sender: TObject);      begin
   ChkComBxEnabl;
end;

procedure TIkFrm.PvitaBtnClick(Sender: TObject);      VAR no :integer;      begin
   no :=fLueComBx;
   if no<=edja+1  then begin
      piirra (no);
      PvitaBtnEnabOFF;  end;
end;

procedure TIkFrm.RichMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;  X,Y: Integer);      begin
  inherited;
end;

{,,Ei onaa koska RichEdit on UnEnabloitu,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
procedure TIkFrm.RichKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);      begin
  if (Key IN [80,112]) and (Shift=[ssCtrl])  then                                       //< 'P','p'
//if MessageDlg ('Tulostetaanko?', mtConfirmation, [mbYes, mbNo], 0) = mrYes  then
     TulostaBtnClick(Sender);
end;}

procedure TIkFrm.FormClose(Sender: TObject; var Action: TCloseAction);      begin
   inherited;
   EdvNewFrm.KayraBtn.Enabled := true;
end;

initialization
   alpEDJ := 0;
end.

