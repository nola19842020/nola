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

///////////////////////////////////////////////////////////////////////////////
//
// FileName:  LicensePanelNola.pas
// Location:  src\components
// Abstract:  Panel displays license information in the Nola and NolaRek
//
///////////////////////////////////////////////////////////////////////////////
//
// Following fields are automatically generated by the version control system:
//
// $Revision: 1.4 $
//     $Date: 2005/10/09 13:58:17 $
//
///////////////////////////////////////////////////////////////////////////////
//
// Change Log. Old log entries can be removed by deleting them.
// $Log: LicensePanelNola.pas,v $
// Revision 1.4  2005/10/09 13:58:17  DEVELOPER2
// Reijolta 26.9.2005

{  MUUTOKSIA:
- 08�2.1  =10.02.2008: Kun verkkolis.lkm��� muutetaan tapahtuu OnChange (lis�ys vain TLicensePanelNola.Create�een
           yhdelle r�vlle. Aikaisemmin OnExit muutti VARMISTUSKOODIn kun klikkasi esim. "P�ivityssopimus"lbl.
}

// 4     22.09.04 20:09 DEVELOPER2
// Bug fix: Invalid Input value -viesti n�ytettiin avattaessa
// AsetusFrm-lomaketta.
// Ongelma johtui v��rin muotoilun p�iv�m��r�n sijoittamisesta
// MaskEdit-komponenttiin.
// - GetMaskFromDateFormat: poistettu, koska Maski on m��ritelty Nolassa 
// - Lis�tty p�iv�m��r�n tarkistuksia SetComponentStatus-funktioon
// 
// 3     28.03.04 14:45 DEVELOPER2
// Bug fix:
// - K�ytt�j�rjestelm�ss� k�ytetty p�iv�ysformaatti otettu k�ytt��n
//
// 2     28.03.04 12:56 DEVELOPER2
// LicensePanelNola
// - OnChange-event lis�tty
// - muutoksia NolaRek-ohjelmaa varten
//
// 1     21.03.04 20:00 DEVELOPER2
//
//Etsi m_LicenseScopeRadioGroup.ItemIndex 0..3    vs. LicenseScope
unit LicensePanelNola;

interface

uses
  Windows, Messages, SysUtils, Classes, vcl.Graphics, vcl.Controls, vcl.Forms, vcl.Dialogs,
  vcl.ExtCtrls, LabelNola, contnrs, vcl.buttons, vcl.stdctrls, vcl.mask, licensefuncs;

type
  TLicensePanelNola = class(TPanel)
  private
    { Private declarations }
    m_lisenssikoodirecCurrent: TLicenseKoodi_10;  // License is currently displayed
    m_lisenssikoodirecOriginal: TLicenseKoodi_10; // License was given to the component
    m_changingLicense: bool;                      // Are the components been updated?
    m_onChangeEvent: TNotifyEvent;                // Function that is called on change

    // Components
    m_LicenseGroupBox: TGroupBox;
    m_LicenseScopeRadioGroup: TRadioGroup;  // Lisenssin laajuus
    m_ContinuosRadioButton: TRadioButton;   // Jatkuva
    m_TimeLimitedRadioButton: TRadioButton; // M��r�aikainen
    m_NetworkCheckBox: TCheckBox;           // Verkkok�ytt�
    m_UpgradeCheckBox: TCheckBox;           // P�ivityssopimus
    m_EndDateStaticText: TStaticText;       // P��ttymispvm
    m_EndDateMaskEdit: TMaskEdit;           // P��ttymispvm edit
    m_CountStaticText: TStaticText;         // K�ytt�oikeuksia
    m_CountEdit: TEdit;                     // K�ytt�oikeuksia edit
    m_CountSymbolStaticText: TStaticText;   // Kpl

    // Function sets the status of components
    procedure  SetComponentStatus;

    // Function gets the status of components
    procedure  GetComponentStatus;

    // Function is called when the properties of the license are changed in the UI
    procedure LicenseChanged(Sender: TObject);

    // Function writes new caption of the component
    // Function is automatically called when the caption-property is set.
    // value:  new caption
    procedure WriteCaption(value: TCaption);

    // Function returns caption of the component
    // Function is automatically called when the caption-property is read.
    // return: caption of the component
    function  ReadCaption: TCaption;

    // Function writes new ShowHint value of the component
    // Function is automatically called when the showHint-property is set.
    // value:  new ShowHint value
    procedure WriteShowHint(value: boolean);

    // Function returns ShowHint value of the component
    // Function is automatically called when the ShowHint-property is read.
    // return: ShowHint of the component
    function  ReadShowHint: boolean;

    // Function writes new enabled value of the component
    // Function is automatically called when the Enabled-property is set.
    // value:  new Enabled value
    procedure WriteEnabled(value: boolean);

    // Function returns Enabled value of the component
    // Function is automatically called when the Enabled-property is read.
    // return: Enabled of the component
    function  ReadEnabled: boolean;

  protected
    { Protected declarations }
    procedure Paint; override;

  public
    { Public declarations }

    // Creates a new instance of the object.
    constructor Create(AOwner: TComponent); override;

    // Destroyes the object instance.
    destructor Destroy; override;

    // Recalculates the layout and repaints the component
    procedure Repaint; override;

    // Sets the license code
    procedure SetLicense(license: TLicenseKoodi_10);

    // Gets the license code
    function GetLicense(): TLicenseKoodi_10;

    // Gets the license string
    function GetLicenseStr(newKey: boolean): string;

    // Has the license been changed?
    function  IsChanged: boolean;

    // Is the license same as given?
    function  EqualsTo(value: TLicenseKoodi_10): boolean;

  published
    { Published declarations }

    // Caption of the component
    property Caption: TCaption read ReadCaption write WriteCaption;

    // Show hint
    property ShowHint: boolean read ReadShowHint write WriteShowHint;

    // Enabled
    property Enabled: boolean read ReadEnabled write WriteEnabled;

    // Called when license is changed
    property OnChange: TNotifyEvent read m_onChangeEvent write m_onChangeEvent;
  end;

  // Used for defining the mappings between displayed string and LicenseScope
  TScopeRec = record
    name: string;
    scope: LicenseScope;
  end;

procedure Register;

implementation

uses
  vcl.menus{, Asetus{+12.0.0 Err jos laittaa alun uses�iin};

const
  // Array is used for mapping displayed string to the LicenseScope definitions.
  // The values defined in this array are displayed in the license scope
  // RadioGroup. If a new value is need to be displayed in it can be added
  // to the list. Order defines the order on which the values are displayed.
  DisplayedScopes: array[0..3] of TScopeRec = (
    (name: 'LT';    scope: lvLT),        // 'LT'   = lvLT
    (name: 'PRO';   scope: lvPRO),       // 'PRO'  = lvPro
    (name: 'EXT';   scope: lvExtended),  // 'EXT'  = lvExtended
  //(name: 'EXD';   scope: lvExtended),  // 'EXT'  = lvExtended  15�3u
    (name: 'GLOB';  scope: lvGlobal)     // 'GLOB' = lvGlobal
  );//''N�it� ei voi vain poistaa..130.3
{   (name: ''),
    (name: ''),
    (name: ''),
    (name: ''));}

///////////////////////////////////////////////////////////////////////////////
procedure Register;
begin
  RegisterComponents('Nola', [TLicensePanelNola]);
end;

///////////////////////////////////////////////////////////////////////////////
constructor TLicensePanelNola.Create(AOwner: TComponent);
const
  VERTICAL_SPACE = 9;
begin
  inherited;

  m_changingLicense := false;

  // Create components
  Hint := 'M��rittelee lisenssin yksityiskohdat. Mik�li lisenssi� muutetaan, tarvitaan hyv�ksymiskoodi, joka saadaan ohjelman toimittajalta.';

  // LicenseGroupBox
  m_LicenseGroupBox :=          TGroupBox.Create(self);
  m_LicenseGroupBox.parent :=   self; //}AsetusFrm.LisenssiSheet;// ��
  m_LicenseGroupBox.align :=    alClient;
  m_LicenseGroupBox.visible :=  true;
  m_LicenseGroupBox.name :=     inherited Name;
  m_LicenseGroupBox.Caption :=  Caption;

  // Lisenssin laajuus
  m_LicenseScopeRadioGroup :=          TRadioGroup.Create(self);
  m_LicenseScopeRadioGroup.parent :=   self; //}AsetusFrm.LisenssiSheet;// ��
  m_LicenseScopeRadioGroup.visible :=  true;
  m_LicenseScopeRadioGroup.name :=     inherited Name;
  m_LicenseScopeRadioGroup.caption :=  '';//Kukkuu';
  m_LicenseScopeRadioGroup.width :=    250;
  m_LicenseScopeRadioGroup.height :=   35;
  m_LicenseScopeRadioGroup.left :=     10;
  m_LicenseScopeRadioGroup.top :=      17;
  m_LicenseScopeRadioGroup.hint :=     'Ks. P��valikko / Ohjeet/Tietoa / Versiolaajuudet LT, PRO...';//'LT = Rajoitetut toiminnat = LT-versio';
  m_LicenseScopeRadioGroup.anchors :=  [akLeft, akTop];
  //m_LicenseScopeRadioGroup.itemIndex := 0;            //<-12.0.0: DEVELOPER2, poistaminen korjasi tilanteen.
  m_LicenseScopeRadioGroup.OnClick :=   LicenseChanged;

  // Jatkuva
  m_ContinuosRadioButton :=         TRadioButton.Create(self);
  m_ContinuosRadioButton.parent :=  self; //}AsetusFrm.LisenssiSheet;// ��
  m_ContinuosRadioButton.visible := true;
  m_ContinuosRadioButton.name :=    inherited Name;
  m_ContinuosRadioButton.caption := 'Jatkuva';
  m_ContinuosRadioButton.width :=   110;
  m_ContinuosRadioButton.height :=  20;
  m_ContinuosRadioButton.left :=    m_LicenseScopeRadioGroup.left;// + 8;
  m_ContinuosRadioButton.top :=     m_LicenseScopeRadioGroup.top +
                                    m_LicenseScopeRadioGroup.height +
                                    VERTICAL_SPACE;
  m_ContinuosRadioButton.hint :=    'Onko k�ytt�oikeus jatkuva?'; //<1413A �
  m_ContinuosRadioButton.OnClick := LicenseChanged;

  // M��r�aikainen
  m_TimeLimitedRadioButton :=         TRadioButton.Create(self);
  m_TimeLimitedRadioButton.parent :=  self; //}AsetusFrm.LisenssiSheet;// ��
  m_TimeLimitedRadioButton.visible := true;
  m_TimeLimitedRadioButton.name :=    inherited Name;
  m_TimeLimitedRadioButton.caption := 'M��r�aikainen';
   //m_UpgradeCheckBox.Visible := false; //+1413A: Ettei samassa kohdassa 'P�ivityssopimus' kanssa ollessaan n�kyisi p��llekk�in, todettu. AccesviolErr.
  m_TimeLimitedRadioButton.width :=   m_ContinuosRadioButton.width;
  m_TimeLimitedRadioButton.height :=  m_ContinuosRadioButton.height;
  m_TimeLimitedRadioButton.left :=    m_ContinuosRadioButton.left;
  m_TimeLimitedRadioButton.top :=     m_ContinuosRadioButton.top +
                                      m_ContinuosRadioButton.height +
                                      VERTICAL_SPACE;
  m_TimeLimitedRadioButton.hint :=    'Onko k�ytt�oikeus m��r�aikainen?';
  m_TimeLimitedRadioButton.OnClick := LicenseChanged;

  // Verkkok�ytt�
  m_NetworkCheckBox :=         TCheckBox.Create(self);
  m_NetworkCheckBox.parent :=  self; //}AsetusFrm.LisenssiSheet;// ��
  m_NetworkCheckBox.visible := true;
  m_NetworkCheckBox.name :=    inherited Name;
  m_NetworkCheckBox.caption := 'Verkkok�ytt�';
  m_NetworkCheckBox.width :=   m_TimeLimitedRadioButton.width;
  m_NetworkCheckBox.height :=  m_TimeLimitedRadioButton.height;
  m_NetworkCheckBox.left :=    m_TimeLimitedRadioButton.left;
  m_NetworkCheckBox.top :=     m_TimeLimitedRadioButton.top +
                               m_TimeLimitedRadioButton.height +VERTICAL_SPACE;
  m_NetworkCheckBox.hint :=   'Sis�ltyyk� lisenssiin verkkok�ytt�oikeus?';
  m_NetworkCheckBox.OnClick := LicenseChanged;

  // P�ivityssopimus
  m_UpgradeCheckBox :=           TCheckBox.Create(self);
  m_UpgradeCheckBox.parent :=    self; //}AsetusFrm.LisenssiSheet;// ��
  m_UpgradeCheckBox.visible :=   true;
  m_UpgradeCheckBox.name :=      inherited Name;
  m_UpgradeCheckBox.caption :=   'P�ivityssopimus:';      //<Oli kommentoitu vex, palautettu 120.6                                         ,AccesviolErr.
 {if m_LicenseScopeRadioGroup.ItemIndex=0                 //<0 =LT jolle ei pvityssopimusta..
     then m_UpgradeCheckBox.visible := false
     else m_UpgradeCheckBox.visible := true;              //<'Vain LT�ll� vex, muilla valittavissa.
   //m_TimeLimitedRadioButton.visible := false;           //'+-1413A: Ettei samassa kohdassa 'M��r�aikainen' kanssa ollessaan n�kyisi p��llekk�in, todettu.}
//m_UpgradeCheckBox.caption :=   '____________________:'; //fKESKEN
  m_UpgradeCheckBox.width :=     100;//130;
  m_UpgradeCheckBox.height :=    m_ContinuosRadioButton.height;
  m_UpgradeCheckBox.left :=      114; //< 140.  Oli 160 =7.0.1 DEVELOPER1
  m_UpgradeCheckBox.top :=       m_ContinuosRadioButton.top;
  m_UpgradeCheckBox.hint :=      'Kuuluuko lisenssiin p�ivityssopimus?';
  m_UpgradeCheckBox.alignment := taLeftJustify;
  m_UpgradeCheckBox.OnClick :=   LicenseChanged;

  // P��ttymispvm
  m_EndDateStaticText :=           TStaticText.Create(self);
  m_EndDateStaticText.parent :=    self; //}AsetusFrm.LisenssiSheet;// ��
  m_EndDateStaticText.visible :=   true;
  m_EndDateStaticText.name :=      inherited Name;
  m_EndDateStaticText.caption :=   'P��ttymispvm:';
  m_EndDateStaticText.autosize :=  true;
  m_EndDateStaticText.height :=    m_TimeLimitedRadioButton.height;
  m_EndDateStaticText.left :=      m_UpgradeCheckBox.left + 1;
  m_EndDateStaticText.top :=       m_TimeLimitedRadioButton.top +3; //< +2=7.0.1 DEVELOPER1
  m_EndDateStaticText.hint :=      'P�iv�m��r�, jolloin lisenssin voimassaolo p��ttyy. PP/KK/VVVV.';

  // P��ttymispvm edit
  m_EndDateMaskEdit :=           TMaskEdit.Create(self);
  m_EndDateMaskEdit.parent :=    self; //}AsetusFrm.LisenssiSheet;// ��
  m_EndDateMaskEdit.visible :=   true;
  m_EndDateMaskEdit.name :=      inherited Name;
  m_EndDateMaskEdit.autosize :=  true;
  m_EndDateMaskEdit.width :=     80;
  m_EndDateMaskEdit.height :=    m_EndDateStaticText.height;
  m_EndDateMaskEdit.left :=      m_EndDateStaticText.left + m_UpgradeCheckBox.width - 15;
  m_EndDateMaskEdit.top :=       m_EndDateStaticText.top -2;  //< -2=7.0.1 DEVELOPER1
  m_EndDateMaskEdit.hint :=      m_EndDateStaticText.Hint;
  m_EndDateMaskEdit.editMask :=  '!90/90/0000;1; ';  // Note! This has to be in line with NolaDateToStr function
  m_EndDateMaskEdit.OnExit :=    LicenseChanged;
  m_EndDateMaskEdit.OnEnter :=   LicenseChanged;

  // K�ytt�oikeuksia
  m_CountStaticText :=           TStaticText.Create(self);
  m_CountStaticText.parent :=    self; //}AsetusFrm.LisenssiSheet;// ��
  m_CountStaticText.visible :=   true;
  m_CountStaticText.name :=      inherited Name;
  m_CountStaticText.caption :=   'K�ytt�oikeuksia:';
  m_CountStaticText.autosize :=  true;
  m_CountStaticText.height :=    m_NetworkCheckBox.height;
  m_CountStaticText.left :=      m_EndDateStaticText.left;
  m_CountStaticText.top :=       m_NetworkCheckBox.top +3;
  m_CountStaticText.hint :=      'Yht�aikaisten k�ytt�oikeuksien lukum��r�.';

  // K�ytt�oikeuksia edit
  m_CountEdit :=               TEdit.Create(self);
  m_CountEdit.parent :=        self; //}AsetusFrm.LisenssiSheet;// ��
  m_CountEdit.visible :=       true;
  m_CountEdit.name :=          inherited Name;
  m_CountEdit.autosize :=      true;
  m_CountEdit.width :=         40;
  m_CountEdit.height :=        m_CountStaticText.height;
  m_CountEdit.left :=          m_EndDateMaskEdit.left;
  m_CountEdit.top :=           m_CountStaticText.top -2;
  m_CountEdit.hint :=          m_CountStaticText.Hint;
  m_CountEdit.HideSelection := true;
  m_CountEdit.MaxLength :=     2;
  m_CountEdit.OnExit :=        LicenseChanged;
  m_CountEdit.OnEnter :=       LicenseChanged;
  m_CountEdit.OnChange :=      LicenseChanged; //<+08�2.1  Ny muutettaessa lkm tapahtuu OnChange, OK.
  m_CountEdit.Hint :=          'Jos LICenssiin liittyy rinnakkasiLicenssej�, ilmoita ne Gridin rvll� 0 LicNo:n '+
                               'j�lkeen, esim:  17  34 56  (miss� 17 on k�sitelt�v� lisenssiNo).';  //<',+08�1x
  m_CountEdit.ShowHint :=      true; //<'Nyt hintti her��.  T�m� sama Hintti on RekPaa.PAS�sissakin.

  // KPL
  m_CountSymbolStaticText :=           TStaticText.Create(self);
  m_CountSymbolStaticText.parent :=    self; //}AsetusFrm.LisenssiSheet;// ��
  m_CountSymbolStaticText.visible :=   true;
  m_CountSymbolStaticText.name :=      inherited Name;
  m_CountSymbolStaticText.caption :=   'kpl';
  m_CountSymbolStaticText.autosize :=  true;
  m_CountSymbolStaticText.height :=    m_CountEdit.height;
  m_CountSymbolStaticText.left :=      m_CountEdit.left + m_CountEdit.width + 7;
  m_CountSymbolStaticText.top :=       m_CountEdit.top +2;
  m_CountSymbolStaticText.hint :=      m_CountEdit.hint;
end;//TLicensePanelNola.Create

///////////////////////////////////////////////////////////////////////////////
destructor TLicensePanelNola.Destroy;
begin
     inherited;
end;

///////////////////////////////////////////////////////////////////////////////
procedure TLicensePanelNola.Repaint;
begin
     inherited;
//  m_LicenseScopeRadioGroup.height :=   50;//35; //<DEVELOPER1 7.0.1
end;

///////////////////////////////////////////////////////////////////////////////
procedure TLicensePanelNola.SetLicense(license: TLicenseKoodi_10);
begin
  m_lisenssikoodirecOriginal := license;
  m_lisenssikoodirecCurrent := m_lisenssikoodirecOriginal;
  SetComponentStatus;
end;

///////////////////////////////////////////////////////////////////////////////
function TLicensePanelNola.GetLicense(): TLicenseKoodi_10;
begin
  result := m_lisenssikoodirecCurrent;
end;

///////////////////////////////////////////////////////////////////////////////
function TLicensePanelNola.GetLicenseStr(newKey: boolean): string;
begin
  result := '';
end;

///////////////////////////////////////////////////////////////////////////////
function TLicensePanelNola.IsChanged: boolean;
begin
  // License is changed if the current license is not same are original
  result := not EqualsTo(m_lisenssikoodirecOriginal);
end;

///////////////////////////////////////////////////////////////////////////////
function TLicensePanelNola.EqualsTo(value: TLicenseKoodi_10): boolean;
var
  tmp: TLicenseKoodi_10; // Use so that given structure won't be changed
begin
  // Check if the given and current code are the same. Code structures may
  // not be same because the crypt key, crc and status may be different. So
  // set them to same and then only the license information is compared.
  // CompareMem is used so that the new additions to the license will be
  // automatically taken into account.
  tmp := value;
  tmp.status :=        m_lisenssikoodirecCurrent.status;
  tmp.avain :=         m_lisenssikoodirecCurrent.avain;
  tmp.versio :=        m_lisenssikoodirecCurrent.versio;
  tmp.tyyppi :=        m_lisenssikoodirecCurrent.tyyppi;
  tmp.crc :=           m_lisenssikoodirecCurrent.crc;
  tmp.lopetuspvmStr := m_lisenssikoodirecCurrent.lopetuspvmStr;

  result := CompareMem(@tmp, @m_lisenssikoodirecCurrent, sizeof(m_lisenssikoodirecCurrent));
end;

///////////////////////////////////////////////////////////////////////////////
procedure  TLicensePanelNola.SetComponentStatus;
var
  timelimited: bool;
  x: integer;
begin
  m_changingLicense := true;

  // Continuous / time limited
  if (m_lisenssikoodirecCurrent.paiva = 0) and (m_lisenssikoodirecCurrent.kuukausi = 0) then
    timelimited := false
  else
    timelimited := true;

  // Network
  m_networkCheckBox.checked :=       m_lisenssikoodirecCurrent.verkko;

  if (enabled) then
  begin
    m_CountStaticText.Enabled :=       m_lisenssikoodirecCurrent.verkko;
    m_CountEdit.Enabled :=             m_lisenssikoodirecCurrent.verkko;
    m_CountSymbolStaticText.Enabled := m_lisenssikoodirecCurrent.verkko;
    m_UpgradeCheckBox.enabled :=       not timelimited;
   {if m_UpgradeCheckBox.enabled  then            //<,+1314A  Ettei n�y p��llekk�in, todettu.
       m_TimeLimitedRadioButton.visible := false;}
    m_EndDateStaticText.enabled :=     timelimited;
    m_EndDateMaskEdit.enabled :=       timelimited;
  end;
//,,���
{if m_CountStaticText.Visible   then
if m_CountEdit.Visible         then
if m_CountSymbolStaticText.Visible  then
if m_UpgradeCheckBox.Visible   then
if m_EndDateStaticText.Visible then
if m_EndDateMaskEdit.Visible   then ;}

  m_CountEdit.text :=                 IntToStr(m_lisenssikoodirecCurrent.lukumaara);
  m_ContinuosRadioButton.checked :=   not timelimited;
  m_UpgradeCheckBox.checked :=        m_lisenssikoodirecCurrent.paivitys;
  m_TimeLimitedRadioButton.checked := timelimited;

  // Insert date to the MaskEdit only if there is date
  if (Trim(m_lisenssikoodirecCurrent.lopetuspvmStr) <> '') then
  begin
    m_EndDateMaskEdit.Text := m_lisenssikoodirecCurrent.lopetuspvmStr;
  end;

//,+15�3u:  Haamutekstien (tai mustaksi maalautuneet tapialueet) poistamiseksi: Kytket��n kaikki valituksi hetkeksi ja sen j�lk. vain se oikea.
  for x := 0 to Length(DisplayedScopes) - 1 do
      m_LicenseScopeRadioGroup.ItemIndex := x;

  // Find the scope that is used
  for x := 0 to Length(DisplayedScopes) - 1 do
  begin
    if (DisplayedScopes[x].scope = m_lisenssikoodirecCurrent.laajuus) then begin
      m_LicenseScopeRadioGroup.ItemIndex := x;
     {if x=0  //then                             //<,+1314A: x=0=LT. Ei edes n�ytet� LT�lle pvitysmahista. Nyt OK.
         //m_UpgradeCheckBox.Visible := false;
        then begin
             m_UpgradeCheckBox.Caption := 'Ei p�ivityssopimusta.'; //<,+1314A
             m_UpgradeCheckBox.Visible := false;  end
        else m_UpgradeCheckBox.Enabled := true;  //<'Viel� lis�tt�v� ruksi tai se vex.}
    end;
  end;

  m_changingLicense := false;
end;//SetComponentStatus

///////////////////////////////////////////////////////////////////////////////
procedure  TLicensePanelNola.GetComponentStatus;
var
  x: integer;
begin
  m_lisenssikoodirecCurrent.verkko :=    m_networkCheckBox.checked;
  m_lisenssikoodirecCurrent.paivitys :=  m_UpgradeCheckBox.Checked;
  m_lisenssikoodirecCurrent.laajuus :=   DisplayedScopes[m_LicenseScopeRadioGroup.itemIndex].scope;

  x := StrToIntDef(m_CountEdit.text, m_lisenssikoodirecCurrent.lukumaara);;
  m_lisenssikoodirecCurrent.lukumaara := x;

  // Mark that there is no end date
  m_lisenssikoodirecCurrent.lopetuspvmStr := '';
  m_lisenssikoodirecCurrent.lopetuspvmTDT := 0;
end;//GetComponentStatus

///////////////////////////////////////////////////////////////////////////////
procedure TLicensePanelNola.Paint;
var
  index: integer;
begin
     Inherited;

     // Adding items can not be done in the Create-function so lets do it here
     if (m_LicenseScopeRadioGroup.items.count = 0) then
     begin
        // Add the RadioGroup members to the license scope
        for index := 0 to Length(DisplayedScopes) - 1 do
        begin
          m_LicenseScopeRadioGroup.items.add(DisplayedScopes[index].name);
        end;

        // All values to one horizontal line
        m_LicenseScopeRadioGroup.Columns := m_LicenseScopeRadioGroup.items.count;

        // Refresh is needed so that the component is displayed correctly in form editor
        m_LicenseScopeRadioGroup.refresh;

        SetComponentStatus;
     end;
end;

///////////////////////////////////////////////////////////////////////////////
procedure TLicensePanelNola.LicenseChanged(Sender: TObject); //T�m� tapahtuu kaikissa tapauksissa, esim. PRO<->EXT,
begin                                                        //lkm-muutos vasta kun exit editBx:sta. Nyt tapahtuu
  if (not m_changingLicense) then                            //jo OnChange ao. editBx:ssa, ks. Create, etsi 08�2.1
  begin
    m_changingLicense := true;

    // Get the current status of the user interface components
    GetComponentStatus;

    // Set the status of the user interface components according to the changes
    SetComponentStatus;

    m_changingLicense := false;

    // Call the listener if it exists
    if Assigned(m_OnChangeEvent) then
      m_OnChangeEvent(self);
  end;
end;

///////////////////////////////////////////////////////////////////////////////
procedure TLicensePanelNola.WriteCaption(value: TCaption);
begin
  if (caption <> value) then
  begin
    inherited Caption := value;
    m_LicenseGroupBox.Caption := Caption;
  end;
end;

///////////////////////////////////////////////////////////////////////////////
function  TLicensePanelNola.ReadCaption: TCaption;
begin
  result := inherited Caption;
end;

///////////////////////////////////////////////////////////////////////////////
function  TLicensePanelNola.ReadShowHint: boolean;
begin
  result := inherited ShowHint;
end;

///////////////////////////////////////////////////////////////////////////////
procedure TLicensePanelNola.WriteShowHint(value: boolean);
var
  index: integer;
begin
  if (ShowHint <> value) then
  begin
    inherited ShowHint := value;

    // Go thought the components and set the hint to enabled state
    for index := 0 to ComponentCount - 1 do
    begin
      if (components[index] is TControl) then
        TControl(components[index]).ShowHint := value;
    end;

    SetComponentStatus;
  end;
end;

///////////////////////////////////////////////////////////////////////////////
function  TLicensePanelNola.ReadEnabled: boolean;
begin
  result := inherited Enabled;
end;

///////////////////////////////////////////////////////////////////////////////
procedure TLicensePanelNola.WriteEnabled(value: boolean);
var
  index: integer;
begin
  if (Enabled <> value) then
  begin
    inherited Enabled := value;

    // Go thought the components and set the enabled
    for index := 0 to ComponentCount - 1 do
    begin
      if (components[index] is TControl) then
        TControl(components[index]).Enabled := value;
    end;
  end;
end;

end.
