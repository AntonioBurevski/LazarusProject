unit InfoUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TInfo }

  TInfo = class(TForm)
    Image1: TImage;
    img_info: TImage;
    Label1: TLabel;
    Label_firm: TLabel;
    procedure Image1Click(Sender: TObject);
  private

  public

  end;

var
  Info: TInfo;

implementation

{$R *.lfm}

{ TInfo }

procedure TInfo.Image1Click(Sender: TObject);
begin
  Info.close;
end;

end.

