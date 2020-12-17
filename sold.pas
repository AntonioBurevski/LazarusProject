unit sold;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, sqldb, Forms, Controls, Graphics, Dialogs, DBGrids,
  StdCtrls, ExtCtrls;

type

  { TSoldForm }

    TSoldForm = class(TForm)
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label_firm: TLabel;
    SQLQuery1: TSQLQuery;
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);

  private

  public

  end;

var
  SoldForm: TSoldForm;

implementation
uses LoginUnit, Unit1;

{$R *.lfm}

{ TSoldForm }



procedure TSoldForm.Image1Click(Sender: TObject);
begin
  SoldForm.close;
  Form1.show;
end;

procedure TSoldForm.FormCreate(Sender: TObject);
begin
    SQLQuery1.UsePrimaryKeyAsKey := False;
    SQLQuery1.Open;
end;


procedure TSoldForm.Image2Click(Sender: TObject);
begin
  SoldForm.close;
  Login.show;
end;

procedure TSoldForm.Image3Click(Sender: TObject);
begin

     begin
        SQlQuery1.Close;
        DBGrid1.DataSource := DataSource1;

        if SQLQuery1.Active then SQLQuery1.Close;
         SQLQuery1.UsePrimaryKeyAsKey := False;
         SQLQuery1.SQL.Clear;
         SQLQuery1.SQL.Add('select * from Sold ');
         SQLQuery1.Open;

     end

end;
end.

