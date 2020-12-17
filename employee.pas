unit employee;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, sqldb, Forms, Controls, Graphics, Dialogs, DBGrids,
  DBCtrls, StdCtrls, ExtCtrls;

type

  { TForm3 }

  TForm3 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    DataSource1: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    img_back: TImage;
    Label1: TLabel;
    Label_firm: TLabel;
    SQLQuery1: TSQLQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure img_backClick(Sender: TObject);
  private

  public

  end;

var
  Form3: TForm3;

implementation
uses AdminUnit, LoginUnit, log;

{$R *.lfm}

{ TForm3 }

procedure TForm3.FormCreate(Sender: TObject);
begin
    SQLQuery1.UsePrimaryKeyAsKey := False;
    SQLQuery1.Open;
end;

procedure TForm3.Image2Click(Sender: TObject);
begin
  Form3.close;
  Login.show;
end;

procedure TForm3.Image3Click(Sender: TObject);
begin
  begin
        SQlQuery1.Close;
        DBGrid1.DataSource := DataSource1;

        if SQLQuery1.Active then SQLQuery1.Close;
         SQLQuery1.UsePrimaryKeyAsKey := False;
         SQLQuery1.SQL.Clear;
         SQLQuery1.SQL.Add('select * from Employee ');
         SQLQuery1.Open;

     end
end;

procedure TForm3.img_backClick(Sender: TObject);
begin
  Form3.Hide;
  Form2.show;
end;

procedure TForm3.Button1Click(Sender: TObject);
begin

     if SQLQuery1.Active then SQLQuery1.Close;
     SQLQuery1.UsePrimaryKeyAsKey := False;
     SQLQuery1.SQL.Clear;
     SQLQuery1.SQL.Add('delete from Employee ');
     SQLQuery1.SQL.Add('where ID = '+Edit1.Text );


     if MessageDlg('Warning!','Do you want to delete this record?',mtWarning,[mbOk, mbNo, mbCancel], 0) = mrOk then
     begin
        try
            SQlQuery1.ExecSQL;
            ShowMessage(' Deleted!');
        except
           ShowMessage(' Not deleted, there is a problem.');
        end;
     end
     else MessageDlg('Information!','Nothing is deleted! ',mtInformation,[mbOk], 0);

end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  Form3.close;
  LogForm.show;
end;

procedure TForm3.DBGrid1CellClick(Column: TColumn);
begin
  if SQLQuery1.Active then
   begin
      Edit1.Text := SQLQuery1.FieldByName('ID').AsString;
      DBEdit1.Text := SQLQuery1.FieldByName('First_Name').AsString;
      DBEdit2.Text := SQLQuery1.FieldByName('Last_Name').AsString;
      DBEdit3.Text := SQLQuery1.FieldByName('Username').AsString;

   end
   else
   begin
      Edit1.Text := SQLQuery1.FieldByName('ID').AsString;
      DBEdit1.Text := SQLQuery1.FieldByName('First_Name').AsString;
      DBEdit2.Text := SQLQuery1.FieldByName('Last_Name').AsString;
      DBEdit3.Text := SQLQuery1.FieldByName('Username').AsString;
   end;
end;

end.

