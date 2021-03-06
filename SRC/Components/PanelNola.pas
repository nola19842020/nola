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
// FileName:  PanelNola.pas
// Location:  src\components
// Abstract:  Normaali panel. Ei k�ytet� mihink��n.
//
///////////////////////////////////////////////////////////////////////////////
//
// Following fields are automatically generated by the version control system:
//
// $Revision: 1.3 $
//     $Date: 2005/10/09 13:59:09 $
//
///////////////////////////////////////////////////////////////////////////////
//
// Change Log. Old log entries can be removed by deleting them.
// $Log: PanelNola.pas,v $
// Revision 1.3  2005/10/09 13:59:09  DEVELOPER2
// Reijolta 26.9.2005
//
// 
// 2     31.07.02 9:46 DEVELOPER2
// New file header.
//

unit PanelNola;

interface

uses
  Windows, Messages, SysUtils, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls;

type
  TPanelNola = class(TPanel)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }

  published
    { Published declarations }

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Nola', [TPanelNola]);
end;

end.
