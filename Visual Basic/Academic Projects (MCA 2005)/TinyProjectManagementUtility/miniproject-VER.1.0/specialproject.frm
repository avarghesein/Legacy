VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Begin VB.Form specialproject 
   Caption         =   " SPECIAL PROJECT & TASK VIEWS"
   ClientHeight    =   6315
   ClientLeft      =   1200
   ClientTop       =   1515
   ClientWidth     =   9465
   Icon            =   "specialproject.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6315
   ScaleWidth      =   9465
   Begin VB.Frame frich1 
      Caption         =   "PROJECT INFORMATION"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   5325
      Left            =   90
      TabIndex        =   6
      Top             =   915
      Width           =   9285
      Begin RichTextLib.RichTextBox rich1 
         Height          =   4965
         Left            =   120
         TabIndex        =   5
         Top             =   240
         Width           =   9105
         _ExtentX        =   16060
         _ExtentY        =   8758
         _Version        =   393217
         ReadOnly        =   -1  'True
         ScrollBars      =   3
         TextRTF         =   $"specialproject.frx":030A
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Book Antiqua"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
   Begin VB.Frame flook 
      Caption         =   "STARTTING AND ENDING DATE FOR  SEARCHING"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   705
      Left            =   4890
      TabIndex        =   2
      Top             =   75
      Width           =   4455
      Begin MSComCtl2.DTPicker fixstart 
         Height          =   375
         Left            =   120
         TabIndex        =   3
         Top             =   240
         Width           =   1335
         _ExtentX        =   2355
         _ExtentY        =   661
         _Version        =   393216
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Format          =   61276161
         CurrentDate     =   37987.3958333333
      End
      Begin MSComCtl2.DTPicker fixend 
         Height          =   375
         Left            =   3000
         TabIndex        =   4
         Top             =   240
         Width           =   1335
         _ExtentX        =   2355
         _ExtentY        =   661
         _Version        =   393216
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Format          =   61276161
         CurrentDate     =   37987.3958333333
      End
   End
   Begin VB.Frame fprojectid 
      Caption         =   "SELECT PROJECT ID"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   705
      Left            =   90
      TabIndex        =   0
      Top             =   75
      Width           =   2745
      Begin VB.ComboBox projectid 
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Left            =   120
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   270
         Width           =   2445
      End
   End
   Begin MSComDlg.CommonDialog dialog1 
      Left            =   3720
      Top             =   240
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.Menu dates 
      Caption         =   "OPTIONS"
      Begin VB.Menu projectexplore 
         Caption         =   "PROJECT-EXPLORING-WITH-DATE"
      End
      Begin VB.Menu sep1 
         Caption         =   "-"
      End
      Begin VB.Menu exitme 
         Caption         =   "EXIT"
      End
   End
   Begin VB.Menu savertf 
      Caption         =   "SAVE-RTF"
      Begin VB.Menu toprint 
         Caption         =   "PRINT"
      End
      Begin VB.Menu sep2 
         Caption         =   "-"
      End
      Begin VB.Menu savetofile 
         Caption         =   "SAVE-TO-FILE"
      End
   End
End
Attribute VB_Name = "specialproject"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Private Sub exitme_Click()
 Unload Me
End Sub

Private Sub Form_Load()
On Error GoTo cancel
Dim X As New Connection
Dim Y As New Recordset

savertf.Visible = False
Set X = dn.cn
If X.State = 0 Then X.Open
Set Y = X.Execute("select projid from projects")
Call addtocombobox(projectid, Y, "projid")

Exit Sub

cancel:
    MsgBox Err.Description
End Sub



Private Sub Form_Resize()
    frich1.Top = fprojectid.Top + fprojectid.Height + 200
    frich1.Width = IIf((Me.ScaleWidth - 200) > 0, Me.ScaleWidth - 200, 50)
    frich1.Height = IIf((Me.ScaleHeight - frich1.Top - 200) > 0, Me.ScaleHeight - frich1.Top - 200, 50)
    rich1.Top = 225
    rich1.Left = 150
    rich1.Width = IIf((frich1.Width - 300) > 0, frich1.Width - 300, 50)
    rich1.Height = IIf((frich1.Height - 300) > 0, frich1.Height - 300, 50)
End Sub

Private Sub Form_Unload(cancel As Integer)
    adminform.Show
End Sub


Private Sub projectexplore_Click()
 If projectid.ListIndex <> -1 Then
    If fixstart.Value > fixend.Value Then
        MsgBox "STARTING DATE IS GREATER THAN ENDING DATE", vbCritical, "DATE ERROR!!!"
    Else
        Call find_all_information_of_project(Val(projectid.Text), rich1, fixstart.Value, fixend.Value, True)
    End If
 Else
    MsgBox "SELECT ANY PROJECT-ID AND RETRY", vbOKOnly, "SELECTION ERROR!!!"
 End If
End Sub

Private Sub projectid_Click()

 If projectid.ListIndex <> -1 Then
    Call find_all_information_of_project(Val(projectid.Text), rich1, CDate("01/01/0001"), CDate("01/01/0001"), False)
    Exit Sub
 Else
    MsgBox "SELECT ANY PROJECT-ID AND RETRY", vbOKOnly, "SELECTION ERROR!!!"
 End If
 
End Sub




Private Sub rich1_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
   If Button = vbRightButton Then
        PopupMenu savertf
    End If
End Sub

Private Sub savetofile_Click()
On Error GoTo cancel

If Trim(rich1.Text) <> "" Then
    dialog1.DefaultExt = "txt"
    dialog1.InitDir = "c:\"
    dialog1.Filter = "Text Files (*.txt)|*.txt"
    dialog1.Flags = &H2000& Or &H2& Or &H800
    dialog1.ShowSave
    rich1.SaveFile dialog1.FileName, rtfRTF
    Exit Sub
Else
    Exit Sub
End If

cancel:
   MsgBox Err.Description
End Sub

Private Sub toprint_Click()
On Error GoTo cancel
Dim I As Integer

If Trim(rich1) <> "" Then
    rich1.SelStart = 1
    rich1.SelLength = Len(rich1)
    dialog1.PrinterDefault = True
    dialog1.ShowPrinter
    For I = 1 To dialog1.Copies
        Printer.NewPage
        rich1.SelPrint (Printer.hDC)
    Next I
End If
Exit Sub

cancel:
    MsgBox Err.Description
End Sub
