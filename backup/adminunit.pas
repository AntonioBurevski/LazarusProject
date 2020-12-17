unit AdminUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TForm2 }

  TForm2 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label_firm: TLabel;
    Label_retail: TLabel;
    Label_retail1: TLabel;
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);

  private

  public

  end;

var
  Form2: TForm2;

implementation
uses Unit1, LoginUnit, Employee;

{$R *.lfm}

{ TForm2 }

procedure TForm2.Image2Click(Sender: TObject);
begin
    Form2.Hide;
    Form1:= TForm1.Create(Nil);
    Form1.ShowModal;
    FreeAndNil(Form1);
    Close;
end;

procedure TForm2.Image1Click(Sender: TObject);
begin
    Form2.Hide;
    Form3.Show;
end;


end.

