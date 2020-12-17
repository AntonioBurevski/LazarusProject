unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, Forms, Controls, Graphics, Dialogs, DBGrids,
  Buttons, StdCtrls, DBCtrls, ExtCtrls, ComCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    DataSource4: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBGrid1: TDBGrid;
    Image1: TImage;
    Image2: TImage;
    img_logo: TImage;
    Label_firm: TLabel;
    Panel1: TPanel;
    search: TEdit;
    brand: TEdit;
    model: TEdit;
    price: TEdit;
    ID: TEdit;
    Label_Search: TLabel;
    Label_ID: TLabel;
    Label_Brand: TLabel;
    Label_Model: TLabel;
    Label_Price: TLabel;
    SQLQuery1: TSQLQuery;
    SQLQuery2: TSQLQuery;
    SQLQuery3: TSQLQuery;
    SQLQuery4: TSQLQuery;
    StatusBar1: TStatusBar;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure searchChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  datum1, vreme1, datum2, vreme2: string[10];

implementation
uses LoginUnit, sold;

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin

  datum1 := FormatDateTime('dd-mm-yyyy',Date);
  vreme1 := FormatDateTime('hh:mm:ss',Time);
  StatusBar1.Panels[0].Text := FN;
  StatusBar1.Panels[1].Text := LN;
  StatusBar1.Panels[2].Text := datum1;
  StatusBar1.Panels[3].Text := vreme1;


  if SQLQuery1.Active then SQLQuery1.Close;
    SQLQuery1.UsePrimaryKeyAsKey := False;
    SQLQuery1.SQL.Clear;
    SQLQuery1.SQL.Add('insert into Log (First_Name, Last_Name, Time_LogIN, Date_LogIN)');
    SQLQuery1.SQL.Add('values ('''+ FN+''', '''+LN+''', '''+vreme1+''', '''+datum1+''' ) ');

    try
       SQlQuery1.ExecSQL;
    except
       ShowMessage(' No, there is a problem with log file. ');
    end;

end;

procedure TForm1.searchChange(Sender: TObject);
begin
  if length(search.Text) > 0 then
     begin
        SQlQuery1.Close;
        DBGrid1.DataSource := DataSource3;

        if SQLQuery3.Active then SQLQuery3.Close;
         SQLQuery3.UsePrimaryKeyAsKey := False;
         SQLQuery3.SQL.Clear;
         SQLQuery3.SQL.Add('select * from Glasses ');
         SQLQuery3.SQL.Add('where Brand like ''%' + search.Text + '%'' or Model like ''%' + search.Text + '%'' or Price like ''%' + search.Text+ '%'' ');
         SQLQuery3.Open;

     end
  else
  begin
     DBGrid1.DataSource := DataSource1;
     SQLQuery1.Open;
  end;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin

  if SQLQuery1.Active then SQLQuery1.Close;

  if SQLQuery2.Active then SQLQuery2.Close;
   SQLQuery2.UsePrimaryKeyAsKey := False;
   SQLQuery2.SQL.Clear;
   SQLQuery2.SQL.Add('insert into Glasses (Brand,Model,Price)');
   SQLQuery2.SQL.Add('values ('''+ brand.Text+''', '''+model.Text+''', '''+price.Text+''' ) ');

  if MessageDlg('Question?','Do you want to CREATE new record?',mtWarning,[mbOk, mbNo, mbCancel], 0) = mrOk then
     begin
         try
           SQlQuery2.ExecSQL;
           ShowMessage('Inserted!');
         except
           ShowMessage(' There is a problem. ');
         end;
     end
    else
       MessageDlg('Information!','Nothing is being inserted! Aborted! ',mtInformation,[mbOk], 0) ;


   SQLQuery1.Open;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
   if SQLQuery1.Active then SQLQuery1.Close;
   if SQLQuery2.Active then SQLQuery2.Close;
   SQLQuery4.UsePrimaryKeyAsKey := False;
   SQLQuery4.SQL.Clear;
   SQLQuery4.SQL.Add('insert into Sold (Glasses_ID,Brand_S,Model_S,Price_S,Date_Sold,Time_Sold) ');
   SQLQuery4.SQL.Add('values ('''+ID.Text+''', '''+ brand.Text+''', '''+model.Text+''', '''+price.Text+''','''+datum1+''', '''+vreme1+''' ) ');

   if MessageDlg('Question?','Do you want to add this item to SOLD?',mtWarning,[mbOk, mbNo, mbCancel], 0) = mrOk then
     begin
         try
           SQlQuery4.ExecSQL;
           ShowMessage('Inserted!');
         except
           ShowMessage(' There is a problem. ');
         end;
     end
    else
       MessageDlg('Information!','Nothing is being inserted! Aborted! ',mtInformation,[mbOk], 0) ;


   SQLQuery1.Open;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Form1.Hide;
  SoldForm.show;
end;

procedure TForm1.DBGrid1CellClick(Column: TColumn);
begin
    if SQLQuery1.Active then
   begin
      ID.Text := SQLQuery1.FieldByName('ID').AsString;
      brand.Text := SQLQuery1.FieldByName('Brand').AsString;
      model.Text := SQLQuery1.FieldByName('Model').AsString;
      price.Text := SQLQuery1.FieldByName('Price').AsString;

     end
   else
   begin
      ID.Text := SQLQuery1.FieldByName('ID').AsString;
      brand.Text := SQLQuery1.FieldByName('Brand').AsString;
      model.Text := SQLQuery1.FieldByName('Model').AsString;
      price.Text := SQLQuery1.FieldByName('Price').AsString;
   end;
end;

procedure TForm1.Image1Click(Sender: TObject);
begin
   datum2:= FormatDateTime('dd-mm-yyyy',Date);
   vreme2 := FormatDateTime('hh:mm:ss',Time);


  if SQLQuery1.Active then SQLQuery1.Close;

   SQLQuery1.UsePrimaryKeyAsKey := False;
   SQLQuery1.SQL.Clear;
   SQLQuery1.SQL.Add('insert into Log (First_Name, Last_Name, Time_LogOUT, Date_LogOUT)');
   SQLQuery1.SQL.Add('values ('''+FN+''', '''+LN+''', '''+vreme2+''', '''+datum2+''' ) ');

         try
           SQlQuery1.ExecSQL;
         except
           ShowMessage(' No, there is a problem with log file. ');
         end;

  Form1.Hide;
  Login.show;
end;

procedure TForm1.Image2Click(Sender: TObject);
begin
  begin
        SQlQuery1.Close;
        DBGrid1.DataSource := DataSource1;

        if SQLQuery1.Active then SQLQuery1.Close;
         SQLQuery1.UsePrimaryKeyAsKey := False;
         SQLQuery1.SQL.Clear;
         SQLQuery1.SQL.Add('select * from Glasses ');
         SQLQuery1.Open;

     end
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
     if SQLQuery1.Active then SQLQuery1.Close;
     if SQLQuery2.Active then SQLQuery2.Close;

      SQLQuery2.UsePrimaryKeyAsKey := False;
      SQLQuery2.SQL.Clear;
      SQLQuery2.SQL.Add('update Glasses ');
      SQLQuery2.SQL.Add('set ');
      SQLQuery2.SQL.Add('Brand = '''+brand.Text+''' ,');
      SQLQuery2.SQL.Add('Model = '''+model.Text+''' ,');
      SQLQuery2.SQL.Add('Price = '''+price.Text+''' ');
      SQLQuery2.SQL.Add('where ID = '+ID.Text);


     if MessageDlg('Question?','Do you want to UPDATE this record?',mtWarning,[mbOk, mbNo, mbCancel], 0) = mrOk then
        begin
            try
              SQLQuery2.ExecSQL;
              ShowMessage('Updated!');
            except
              ShowMessage(' No, there is a problem. ');
            end;
        end
       else
          MessageDlg('Information!','Nothing is being changed! Aborted! ',mtInformation,[mbOk], 0) ;


      SQLQuery1.Open;

end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin

    if SQLQuery1.Active then SQLQuery1.Close;

    if SQLQuery2.Active then SQLQuery2.Close;
     SQLQuery2.UsePrimaryKeyAsKey := False;
     SQLQuery2.SQL.Clear;
     SQLQuery2.SQL.Add('delete from Glasses ');
     SQLQuery2.SQL.Add('where ID = '+ID.Text );

     ShowMessage(' the query is '+SQlQuery2.SQL.Text);

     if MessageDlg('Warning!','Do you want to delete this record?',mtWarning,[mbOk, mbNo, mbCancel], 0) = mrOk then
     begin
        try
            SQlQuery2.ExecSQL;
            ShowMessage(' Deleted!');
        except
           ShowMessage(' Not deleted, there is a problem.');
        end;
     end
     else MessageDlg('Information!','Nothing is deleted! ',mtInformation,[mbOk], 0);

     SQLQuery1.Open;
end;


end.

