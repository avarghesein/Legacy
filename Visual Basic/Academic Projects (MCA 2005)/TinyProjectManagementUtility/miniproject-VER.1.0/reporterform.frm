VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form reporterform 
   Caption         =   "GENERAL REPORT"
   ClientHeight    =   6225
   ClientLeft      =   810
   ClientTop       =   1680
   ClientWidth     =   10260
   Icon            =   "reporterform.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6225
   ScaleWidth      =   10260
   Begin RichTextLib.RichTextBox rtf 
      Height          =   6105
      Left            =   90
      TabIndex        =   0
      Top             =   60
      Width           =   10035
      _ExtentX        =   17701
      _ExtentY        =   10769
      _Version        =   393217
      Enabled         =   -1  'True
      ReadOnly        =   -1  'True
      ScrollBars      =   3
      TextRTF         =   $"reporterform.frx":030A
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Bookman Old Style"
         Size            =   9.75
         Charset         =   0
         Weight          =   300
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSComDlg.CommonDialog dialog1 
      Left            =   0
      Top             =   0
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.Menu opts 
      Caption         =   "OPTIONS"
      Begin VB.Menu savtofile 
         Caption         =   "SAVE-TO-FILE"
      End
      Begin VB.Menu sep 
         Caption         =   "-"
      End
      Begin VB.Menu print 
         Caption         =   "PRINT"
      End
   End
End
Attribute VB_Name = "reporterform"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Public hlp As Boolean


Private Sub Form_Load()
On Error GoTo label


opts.Visible = False
If Not hlp Then
        Dim X As New Connection
        Dim Y As New Recordset
        Dim tmp As Integer
        Dim stg As String
        
        Me.Caption = "GENERAL REPORT"
        Set X = dn.cn
        If X.State = 0 Then X.Open
        Set Y = X.Execute("select projdesc as pdesc,projid as pid,projname as pname,name as pman,projects.completed as pstat,projects.deleted as pdels from  projects,person where person.id=projects.projmanager")
        
        rtf.SelIndent = 500
        rtf.SelHangingIndent = -250
        rtf.SelRightIndent = 100
        rtf.RightMargin = 20000
               
        rtf.Text = Space(10) & vbCrLf & vbCrLf & Space(40) & "PROJECTS REPORT" & vbCrLf
        rtf.Text = rtf.Text & Space(40) & "***************" & vbCrLf & vbCrLf & vbCrLf
        
        
        Call formattextinrtf(rtf, findvalidstring(rtf.Text), "courier new", 10)
        If Y.EOF And Y.BOF Then
            rtf.Text = rtf.Text & vbCrLf & vbCrLf & vbCrLf & "No items to Show"
            Exit Sub
        End If
        
        With rtf
            .Text = .Text & "-------------------------------------------------------------------------------------------------------------" & vbCrLf
            .Text = .Text & "PROJECTID" & Space(5) & "PROJECTNAME     " & Space(5) & "PROJECTMANAGER" & Space(5) & "PROJECT DESCRIPTION" & Space(5) & "STATUS     " & Space(5) & "DELETED        " & vbCrLf
            .Text = .Text & "-------------------------------------------------------------------------------------------------------------" & vbCrLf
        Y.MoveFirst
        While Not Y.EOF
            .Text = .Text & Mid(Y("pid"), 1, 9)
            tmp = 9 - Len(Y("pid"))
            If tmp > 0 Then .Text = .Text & Space(tmp)
            .Text = .Text & Space(5) & Mid(Y("pname"), 1, 16)
            tmp = 16 - Len(Y("pname"))
            If tmp > 0 Then .Text = .Text & Space(tmp)
            .Text = .Text & Space(5) & Mid(Y("pman"), 1, 13)
            tmp = 13 - Len(Y("pman"))
            If tmp > 0 Then .Text = .Text & Space(tmp)
            stg = delmultiline(Trim(Y("pdesc")))
            .Text = .Text & Space(6) & Mid(stg, 1, 19)
            tmp = 19 - Len(stg)
            If tmp > 0 Then .Text = .Text & Space(tmp)
            stg = IIf(Trim(Y("pstat")) = "T", "Completed", "InCompleted")
            .Text = .Text & Space(5) & stg
            tmp = 11 - Len(stg)
            If tmp > 0 Then .Text = .Text & Space(tmp)
            stg = IIf(Trim(Y("pdels")) = "T", "Deleted", "ActiveProject")
            .Text = .Text & Space(5) & stg & vbCrLf
            Y.MoveNext
        Wend
        .Text = .Text & vbCrLf & "-------------------------------------------------------------------------------------------------------------" & vbCrLf
        End With
 
Else
       Me.Caption = "PSCHEDULER HELP TOPICS"
       rtf.LoadFile App.Path & "\phelp.txt", 0
End If
Exit Sub

label:
    MsgBox Err.Description, vbOKOnly, "PShedule ERROR!!!"
        
End Sub

Public Function delmultiline(X As String) As String
Dim I As Integer
Dim j As String

I = 1
j = ""
While I <= Len(X)
    If Mid(X, I, 2) = vbCrLf Then
        I = I + 2
    Else
        j = j & Mid(X, I, 1)
        I = I + 1
    End If
Wend
delmultiline = j

End Function

Private Sub Form_Resize()
    rtf.Left = 50
    rtf.Top = 50
    rtf.Height = IIf(Me.ScaleHeight - 50 > 0, Me.ScaleHeight - 50, 20)
    rtf.Width = IIf(Me.ScaleWidth - 50 >= 0, Me.ScaleWidth - 50, 20)
End Sub

Private Sub print_Click()
On Error GoTo cancel
Dim I As Integer

If Trim(rtf) <> "" Then
    rtf.SelStart = 1
    rtf.SelLength = Len(rtf)
    dialog1.PrinterDefault = True
    dialog1.ShowPrinter
    For I = 1 To dialog1.Copies
        Printer.NewPage
        rtf.SelPrint (Printer.hDC)
    Next I
End If
Exit Sub

cancel:
    MsgBox Err.Description
End Sub

Private Sub rtf_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
If Button = vbRightButton Then
    If Trim(rtf) <> "" Then
        PopupMenu opts
    End If
  End If
End Sub

Private Sub savtofile_Click()
On Error GoTo cancel

If Trim(rtf.Text) <> "" Then
    dialog1.DefaultExt = "txt"
    dialog1.InitDir = "c:\"
    dialog1.Filter = "Text Files (*.txt)|*.txt"
    dialog1.Flags = &H2000& Or &H2& Or &H800
    dialog1.ShowSave
    rtf.SaveFile dialog1.FileName, rtfRTF
    Exit Sub
Else
    Exit Sub
End If

cancel:
   MsgBox Err.Description
End Sub
