unit log;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, Forms, Controls, Graphics, Dialogs, DBGrids,
  StdCtrls, ExtCtrls;

type

  { TLogForm }

  TLogForm = class(TForm)
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
  LogForm: TLogForm;

implementation
uses AdminUnit, LoginUnit;

{$R *.lfm}

{ TLogForm }

procedure TLogForm.FormCreate(Sender: TObject);
begin
  SQLQuery1.UsePrimaryKeyAsKey := False;
  SQLQuery1.Open;
end;

procedure TLogForm.Image1Click(Sender: TObject);
begin
  LogForm.close;
  Form2.show;
end;

procedure TLogForm.Image2Click(Sender: TObject);
begin
  LogForm.close;
  Login.show;
end;

procedure TLogForm.Image3Click(Sender: TObject);
begin
   begin
        SQlQuery1.Close;
        DBGrid1.DataSource := DataSource1;

        if SQLQuery1.Active then SQLQuery1.Close;
         SQLQuery1.UsePrimaryKeyAsKey := False;
         SQLQuery1.SQL.Clear;
         SQLQuery1.SQL.Add('select * from Log ');
         SQLQuery1.Open;

     end
end;

end.

